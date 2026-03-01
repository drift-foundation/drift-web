# Stress & Correctness Tests — Plan

## Goal

Verify that the REST server handles sustained load, edge cases, and
adversarial input without crashes, leaks, or incorrect behavior. All tests
must pass under `DRIFT_MEMCHECK=1`.

## Runtime model

Drift VTs are fibers scheduled on a pool of carrier OS threads (M:N model).
Blocking I/O (`stream.read`, `stream.write`, `listener.accept`) does not
block the carrier thread — the runtime parks the VT via reactor interest +
`vt_park_until` and schedules other runnable VTs on the freed carrier.

Implications for the server:

- **Server VT parks on I/O.** While `_handle_connection` is blocked on
  `stream.read()`, client VTs can make progress on their own connections.
  This is how the test setup works: server on one VT, client(s) on others.
- **Sequential accept loop** — `_handle_connection` is called inline (not
  spawned per-connection), so the server processes one connection at a time.
  Concurrent clients queue in the OS socket backlog.
- **Parallel execution is possible** if the executor has multiple carrier
  threads. Two VTs (e.g. server + client) may truly run in parallel, not
  just interleave.

## Architecture constraints

These shape what is and isn't testable:

- **Sequential connection handling** — `_handle_connection` inline in accept
  loop. Concurrent clients queue in OS backlog, processed one at a time.
- **200ms accept timeout** — the loop polls `_is_stopped()` every iteration,
  so shutdown latency is ≤200ms.
- **No keep-alive** — `Connection: close` on every response. Each request is
  a fresh TCP connection.
- **`max_requests` field** — lets a test bound the server to N connections,
  then it self-stops. Avoids relying on timing for test termination.
- **Header limit: 8192 bytes.** Enforced during `read_request_bytes()`.
- **Body limit: Content-Length only.** No chunked encoding.
- **VTs for test clients** — `conc.spawn_cb()` spawns client VTs that run
  concurrently with the server VT (truly parallel or interleaved depending
  on carrier thread count).

## Test file

Single file: `packages/web-rest/tests/stress/stress_test.drift`

Stress tests live under `tests/stress/`, not `tests/unit/`. This keeps
`rest-check-par` fast (unit tests only) and lets stress tests run via a
dedicated `rest-stress` recipe.

Reuse the helpers from `server_test.drift` (duplicated into the new file —
Drift has no cross-test imports): `_to_bytes`, `_bytes_to_string`,
`_http_roundtrip`, `_run_serve`, `_contains`, `_starts_with`, `_health_handler`.

Add a new multi-request lifecycle helper:

```
_multi_roundtrip(app, handle, requests: Array<String>, timeout)
  → Result<Array<String>, Int>
```

Lifecycle: `listen_app` → `clone_handle` → set `handle.max_requests = N` →
spawn server VT → loop N requests via `_http_roundtrip` → `stop` → `join`.

Returns array of raw response strings (one per request).

## Scenarios

### 1. Many sequential requests, mixed types (scenario 100-range)

**What:** Send 50 sequential requests to a single server instance using a
mix of request types. Use `max_requests = 50` for clean shutdown.

Request mix (repeating pattern across 50 requests):
- `GET /health` → 200, `{"ok":true}`
- `GET /v1/echo?key=val` → 200, echoed query param
- `POST /v1/echo` with JSON body → 200, echoed body
- `GET /nonexistent` → 404, not-found envelope
- `GET /v1/me` (no auth) → 401, unauthorized envelope

This exercises success paths, error paths, body parsing, query params, and
guard rejection across a sustained run.

**Why:** Confirms no accumulating state leak, no counter overflow, no
stale-context bleed between requests. Mixing success and error responses
ensures error envelopes don't corrupt state for subsequent requests.

**Asserts:**
- Each response matches its expected status and body marker.
- Server VT exits cleanly (join returns 0).

### 2. Concurrent client connections (scenario 200-range)

**What:** Spawn 10 client VTs, each sending 1 request. Server has
`max_requests = 10`. Clients connect ~simultaneously; the server processes
them one at a time from the accept loop while client VTs park on their own
I/O, yielding carriers back to the executor.

**Why:** Exercises the VT scheduler under contention — multiple client VTs
park/wake alongside the server VT. Confirms no dropped connections, no
garbled responses, and no VT scheduling pathology when the OS backlog holds
queued connections.

**Mechanism:**
- Spawn 10 VTs, each calling `_http_roundtrip(port, request, timeout)`.
- Collect results via `join()` on each VT handle.
- All 10 must return `200 OK`.

**Asserts:**
- All 10 VT joins succeed.
- All 10 responses contain `200 OK` and `{"ok":true}`.

### 3. Repeated start/stop cycles (scenario 300-range)

**What:** In a loop, 5 times: build app → listen → spawn serve → send 1
request → stop → join. Each cycle is a fresh server instance on port 0.

**Why:** Confirms no leaked file descriptors, listener handles, or Arc
refcounts across lifecycles. Memcheck will catch leaked allocations.

**Asserts:**
- All 5 roundtrips return `200 OK`.
- All 5 server VTs exit cleanly.

### 4. Large headers near limit (scenario 400-range)

**What:** Two sub-scenarios via real TCP roundtrips:
1. Header safely under limit (~7000 bytes) → 200 OK.
2. Header safely over limit (~10000 bytes) → 400 `header-too-large`.

No exact-boundary pinning — the check in `read_request_bytes()` fires when
`collected.len >= 8192` before the next read, and the exact cutover depends
on how bytes arrive in 4096-byte chunks. Testing under/over is sufficient.

**Mechanism:** Build headers by repeating `X-Pad-NN: <value>\r\n` lines
until the total header block (including request line and `\r\n\r\n`
terminator) reaches the target size.

**Asserts:**
- Sub 1: response starts with `HTTP/1.1 200 OK`.
- Sub 2: response starts with `HTTP/1.1 400 Bad Request`, body contains
  `"header-too-large"`.

### 5. Malformed request matrix (scenario 500-range)

**What:** Send a variety of malformed HTTP payloads through real TCP
connections and verify proper error responses for each. One sub-scenario per
malformation type.

| # | Payload | Expected tag |
|---|---------|-------------|
| 1 | Empty string (connect + immediate close) | `read-failed` or `empty-request` |
| 2 | `\r\n\r\n` (blank request line) | `malformed-http` |
| 3 | `GET\r\n\r\n` (no path) | `malformed-http` |
| 4 | `GET / HTTP/1.1\r\n\r\n` + `Content-Length: 100\r\n\r\n` but no body | `incomplete-body` |
| 5 | Binary garbage (random high bytes) + `\r\n\r\n` | `malformed-http` |
| 6 | `POST /health HTTP/1.1\r\nContent-Length: 5\r\n\r\nAB` (truncated body) | `incomplete-body` |
| 7 | Request line with no HTTP version: `GET /health\r\n\r\n` | `malformed-http` |

**Why:** Ensures every parse failure path returns a well-formed error
envelope and the server stays alive for the next connection.

**Mechanism:** Use `max_requests = N` (one per sub-scenario) on a single
server instance. Send each malformed request sequentially. The server must
respond to every one and then exit cleanly.

**Asserts:**
- Each response is `HTTP/1.1 400 Bad Request`.
- Each response body contains the expected tag.
- Server VT exits cleanly after processing all requests.

### 6. Partial/slow client (scenario 600-range)

**What:** Client sends header bytes in two separate TCP writes with a 500ms
pause between them. The full request is valid; it just arrives slowly.

**Why:** Validates that `read_request_bytes()` correctly accumulates partial
reads across multiple `stream.read()` calls without treating a partial
header as complete.

**Mechanism:** New helper `_slow_roundtrip` that:
1. Connects to server.
2. Writes first half of the request (e.g., `GET /health HTTP/1.1\r\n`).
3. Sleeps 500ms (`conc.sleep(conc.Duration(millis = 500))`).
4. Writes second half (`Host: localhost\r\n\r\n`).
5. Reads response normally.

Server timeout is set to 5000ms, so 500ms delay is well within tolerance.

**Asserts:**
- Response is `HTTP/1.1 200 OK` with `{"ok":true}`.
- Server VT exits cleanly.

### 7. Large response body (scenario 700-range)

**What:** Handler returns a JSON response with a body >8KB (e.g. ~12KB of
repeated payload). Client reads the full response and verifies it arrived
intact.

**Why:** `write_response()` in `http.drift` serializes the entire response
into a single byte array and calls `stream.write()` once. For large
responses this is a single large write. This scenario pins that the full
payload survives the TCP roundtrip without truncation or short-write
corruption.

**Mechanism:** Register a handler at `/v1/large` that builds a JSON body
with a repeated string field totaling ~12KB. Send `GET /v1/large`, read the
full response, verify Content-Length header matches actual body length and
body content is intact.

**Asserts:**
- Response starts with `HTTP/1.1 200 OK`.
- Response body length matches the Content-Length header value.
- Body content is the expected repeated pattern (spot-check start/end).
- Server VT exits cleanly.

## What is NOT tested (and why)

- **Concurrent handler execution** — `_handle_connection` is called inline
  in the accept loop, not spawned per-connection. If we later spawn handler
  VTs, `&App` sharing is safe (read-only), but `event_counter` and
  `requests_served` would need atomics. Send/Sync is not compiler-enforced
  in v1, so that future change needs manual review. Not a test target now.
- **Keep-alive / pipelining** — not implemented (Connection: close).
- **TLS** — not in scope for MVP.
- **Backpressure / connection refusal** — OS TCP backlog handles this
  transparently; we don't control it.
- **Very large request bodies** — no request body size limit exists in the
  implementation yet; adding one is a future task, not a test target.
  (Large *response* bodies are tested in scenario 7.)

## Justfile

Add recipe `rest-stress` that compiles and runs stress_test.drift:

```
rest-stress:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/stress/stress_test.drift \
      --target-word-bits 64
```

`rest-stress` is a separate gate, not included in `just test`. Stress tests
are slower and more timing-sensitive than unit tests — they belong in a
heavier CI lane, not the default feedback loop.

## Verification

1. `just rest-stress` — passes
2. `DRIFT_MEMCHECK=1 just rest-stress` — 0 leaks, 0 errors
3. `just test` — unchanged, full unit suite green (no stress tests)

## Error code ranges

| Scenario | Range |
|----------|-------|
| Many sequential (mixed) | 100–199 |
| Concurrent clients | 200–299 |
| Start/stop cycles | 300–399 |
| Large headers | 400–499 |
| Malformed matrix | 500–599 |
| Partial/slow client | 600–699 |
| Large response body | 700–799 |
