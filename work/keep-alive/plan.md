# HTTP/1.1 Keep-Alive — Plan

Status: approved
Date: 2026-03-01

## Goal

Add HTTP/1.1 persistent connections to `web.rest`. This is the prerequisite
for meaningful performance benchmarks — without keep-alive, all measurements
are dominated by TCP connection lifecycle overhead.

## Prerequisites

Keep-alive must not ship without fixing two existing correctness risks:

1. **Partial writes.** `write_response()` currently assumes one
   `stream.write()` flushes the entire response. Under keep-alive a
   truncated response poisons the connection for the next request.

2. **Buffered request parsing.** `read_request_bytes()` can legally receive
   bytes from the next request in the same `stream.read()` call.
   `parse_request()` parses one request and ignores trailing bytes. Under
   keep-alive, those trailing bytes are request N+1 and must not be dropped.
   "No pipelining" does not remove this requirement — even sequential
   clients can have back-to-back bytes in kernel/user-space buffers.

## Scope (Pinned)

### 1. HTTP/1.1 persistent connections by default

Default response header changes from `Connection: close` to
`Connection: keep-alive`. Connections are reused across multiple requests.

### 2. Per-connection loop

```
accept →
  init per-connection read buffer (empty) →
  loop {
    read request from buffer + stream → parse from prefix → retain remainder
    dispatch → write response (full flush)
    break on: client close, server opt-out, idle timeout, error
  } →
close
```

### 3. Per-connection buffered request parsing (pinned)

The current `read_request_bytes()` flow must change to support remainder
preservation:

- Each connection owns a byte buffer that persists across loop iterations.
- On each iteration, the parser first checks the existing buffer for a
  complete request (headers + body). If insufficient, it reads more bytes
  from the stream and appends to the buffer.
- After parsing one complete request, the consumed bytes are removed from
  the buffer. Any unconsumed trailing bytes remain in the buffer for the
  next iteration.
- The interface becomes approximately:
  ```
  read_one_request(stream, buffer, timeout)
    → Result<(Request, updated_buffer), RestError>
  ```
  or equivalent in-place mutation of the buffer.
- `parse_request()` must report how many bytes it consumed so the caller
  knows where the remainder starts.

This is the most important correctness requirement. Without it, keep-alive
silently drops or corrupts requests.

### 4. Respect client `Connection: close`

If the client sends `Connection: close`, the server writes the response and
closes the connection. No further reads on that socket.

`Connection` header state is internal to the HTTP/server layer (pinned for
MVP). It is not exposed on the user-visible `Request` type. The server
parses it during request reading and uses it to control the per-connection
loop. If a future use case requires exposing it, it can be added later
without breaking changes.

### 5. Server-initiated close

The server closes the connection on:
- Parse/read/write error (malformed request, timeout, short write)
- Stop/shutdown path (`_is_stopped()`)
- Idle timeout exceeded

**Error recovery policy (pinned):** on any read/parse error for a
keep-alive connection, discard the per-connection buffer and close that
socket immediately. Do not attempt to recover and continue on the same
connection after malformed input — the buffer state is untrusted.

### 6. No pipelining (MVP)

Sequential requests on one connection only. The server does not accept a
second request until the first response is fully written. This must be
documented explicitly.

Note: "no pipelining" means the server does not *dispatch* multiple
requests concurrently on one connection. It does *not* mean the server can
ignore bytes that arrive ahead of time — those must be buffered and
processed in order (see scope item 3).

### 7. Idle timeout for inactive keep-alive connections

Configurable idle timeout on the read side. When a keep-alive connection
has been silent for longer than the timeout, the server closes it and
returns to the accept loop. Default TBD (likely 5-15 seconds).

### 8. Fix `write_response()` short write handling

`write_response()` must write in a loop until all bytes are flushed or an
error occurs. The current single-call assumption is incorrect for large
responses and becomes a connection-corruption risk under keep-alive.

## Files affected (expected)

| File | Change |
|------|--------|
| `server.drift` | Per-connection loop, idle timeout, shutdown integration, per-connection buffer ownership |
| `http.drift` | `read_request_bytes()` → buffered reader with remainder, `write_response()` short-write loop, `Connection` header parsing (internal), default `Connection: keep-alive` header emission |

`response.drift` is not expected to change — the `Connection` header is
currently emitted inside `serialize_response()` in `http.drift`, and that
is where it stays.

## Tests required

All must pass before keep-alive is considered done.

| # | Test | What it proves |
|---|------|---------------|
| 1 | Two valid requests on one TCP connection → two valid responses | Basic keep-alive works |
| 2 | Back-to-back requests written before first response is read, both processed correctly | Remainder buffer preservation (most important parser correctness case) |
| 3 | Client sends `Connection: close` → server closes after response | Client opt-out respected |
| 4 | Server idle timeout closes silent keep-alive connection | Idle connections reclaimed |
| 5 | Malformed request closes that connection cleanly without killing server | Error isolation per-connection |
| 6 | Large response on keep-alive connection, followed by another request | Short-write fix verified + connection survives large payload |
| 7 | No-pipelining claim documented | Explicit contract |

## Perf implication

After keep-alive lands, the first useful benchmark becomes:
- One connection
- Warmup N requests on that connection
- Measured M requests on the same socket
- Print: iters, total_ms, avg_ms, req_per_sec

This will finally expose parser/router/dispatch/serialization cost without
TCP establishment noise.

## What is paused

- Perf benchmark expansion (additional scenarios beyond `baseline-health`)
- Perf work resumes after keep-alive lands, on top of reused connections

## Delivery order

1. Fix `write_response()` short-write loop
2. Buffered request reader with remainder preservation in `http.drift`
3. Per-connection read/write loop in `server.drift`
4. `Connection` header parsing (internal to HTTP/server layer)
5. Idle timeout
6. Default `Connection: keep-alive` response header
7. Unit tests (7 required tests above)
8. Stress test additions (keep-alive under sustained load)
9. Resume perf benchmarks with single-connection harness
