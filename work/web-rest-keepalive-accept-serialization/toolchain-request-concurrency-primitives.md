# TOOLCHAIN REQUEST — runtime/stdlib primitives for writing concurrent network servers

**From:** web-drift team (web.rest server framework + web.client).
**Toolchain:** reproduced on `driftc 0.33.45 | abi 17 | git 01cee266` (certified) and
the current `…00b1479` snapshot — neither provides the primitives below.
**Priority:** HIGH. We have a *correct* server fix that is blocked from shipping
purely by a missing scheduler primitive: it passes every correctness gate
(plain + ASAN + memcheck) but fails the perf gate because the only available
"yield" is a ≥1 ms sleep. Hard numbers below.

---

## 1. End goal — why this matters

`web.rest` is Drift's production HTTP/1.1 server framework (paired with `web.client`
and `web-jwt`). It is a **load-bearing component**: the Microflows product builds
its coordinator and participant services on it — a long-running coordinator
dispatches to many participant services over HTTP, each call a fresh keep-alive
connection. A workflow with ≥4 remote operations must complete well within request
timeouts, and the coordinator runs for days under sustained dispatch.

The end goal is a server that can **fairly and efficiently multiplex many
concurrent keep-alive connections**, competitive with Go `net/http`, with no
pathological stalls. The non-negotiable invariant:

> An idle (or slow) keep-alive connection must never block accept/read/write
> progress for other connections.

We can express the *logic* of such a server in Drift today. What we cannot do is
make it both **fair** and **fast** — because the runtime lacks a cooperative
yield and a multi-fd readiness primitive. This request is the full list of what we
need to close that gap cleanly.

(The bug that surfaced all this: a single idle keep-alive connection serialized the
old server's accept loop, costing ~2.3 s/request and ~50% connection failures for
Microflows. Reported separately in
`2026-06-20-microflows-web-rest-keepalive-latency.md`.)

---

## 2. Architecture — what we are building

- **Server (`web.rest`)**: binds a `TcpListener`, accepts connections, and for each
  request parses HTTP/1.1, routes to a handler, runs guard/middleware, and writes a
  response. Keep-alive is the default: one connection carries many sequential
  requests. Runs on a VT fiber spawned via `conc.spawn_cb` (default executor).
- **Dispatch** is synchronous and read-only over an immutable `Arc<App>` (routes
  fixed once serving starts; a fresh `Context` per request). So request handling
  itself is cheap and parallel-safe; the hard part is purely the **I/O multiplexing
  loop**.
- **Client (`web.client`)**: connection-pooled keep-alive client. Many of our tests
  (and Microflows' own integration tests) run a `web.client` AND a `web.rest`
  server **co-located in one process** — which is exactly where the scheduler
  limitations bite hardest (see §4).
- **Connection model we want**: a single server fiber owning an event loop that
  multiplexes `accept` + all active connections, holding per-connection read buffers
  and pending-write buffers, so no one connection can stall the loop. (We
  deliberately moved AWAY from one-fiber-per-connection — see §4.A.)

---

## 3. Performance needs (concrete, with the cert thresholds)

`web.rest`'s `perf-smoke` gate measures throughput against Go and against a raw
Drift baseline. Pinned thresholds (these are enforced; a regression fails CI):

| ratio                                   | definition                  | threshold | prior baseline |
|-----------------------------------------|-----------------------------|-----------|----------------|
| `drift_raw_ratio`   = drift_vt / go_raw | raw TCP echo vs Go raw      | ≥ 0.80    | ~1.02          |
| `drift_rest_ratio`  = drift_health / go_http | REST framework vs Go net/http | ≥ 1.40 | —              |
| `drift_framework_ratio` = drift_health / drift_vt | framework overhead | ≥ 0.45    | ~0.65          |

The workload: a single keep-alive connection driving **15 000 request/response
round-trips** (request → response → next request), co-located client fiber, through
`rest.start`. To hit these ratios the per-request cost must be **microseconds**, not
milliseconds. Concretely we need the server to react to "the next request arrived"
with **sub-millisecond latency** — which a reactor-driven blocking read gives for
free, but a poll-and-sleep loop cannot.

We also need this to hold while remaining **fair across many connections** and while
running clean under **ASAN and valgrind/memcheck** (valgrind serializes threads, so
anything relying on multi-core parallelism or timing luck breaks there).

---

## 4. Why we are blocked — both viable architectures hit a runtime wall

### A. One VT fiber per connection — blocked by scheduler fairness
The "obvious" design. On the default executor's **single cooperative worker**, a
freshly-spawned (or freshly-woken) connection fiber is **starved** behind
already-ready I/O fibers. Most visible co-located (client + server in one process)
and under valgrind. What we measured:
- A new connection fiber never gets its first slice; a `sleep`-based handshake
  papers over the *first* scheduling but not later keep-alive requests.
- → intermittent `client.send` failures on the 3rd+ pooled request; **deterministic
  under valgrind**. Original inline server: 0/10 plain + 3/3 valgrind stable.
  Per-connection-fiber server: **1/5 plain + 5/5 valgrind FAIL**.
- Custom multi-thread executors (`build_executor` + `spawn_on`) did not rescue it:
  their worker threads do **not** reliably service async socket I/O (the epoll
  reactor appears tied to the default runtime → hung/flaky reads), and there is **no
  executor shutdown API** (per-server pools leak threads; a 2nd executor
  build/submit failed outright).

→ needs **multi-worker reactor / fair scheduling (#4)** and **executor lifecycle +
reactor integration (#5)**.

### B. One VT fiber, non-blocking event loop — blocked by the missing yield
The design we actually implemented and which is **correct**: it passes the full
correctness suite (plain + ASAN + memcheck, including the co-located web-client e2e
tests). The loop does non-blocking (`Duration(0)`) `accept` + per-connection
`read`/`write`, buffers partial reads/writes, and never blocks on any single fd —
so an idle or slow connection cannot stall it. But it cannot yield cleanly:

- A `Duration(0)` socket op that returns `WOULD_BLOCK` does **NOT** yield the worker.
  A pure poll loop therefore **busy-spins and deadlocks a co-located client**
  (server spins at 100% CPU, client fiber never runs). Verified: the no-yield spike
  pegs a core and never makes progress.
- `conc.sleep(Duration(millis=0))` does **NOT** yield either — also busy-spins
  (verified: same 100%-CPU deadlock). So a zero-delay sleep is not a usable yield.
- The **only** thing that yields is `conc.sleep(d)` with `d ≥ 1 ms`. Yielding once
  per no-progress tick therefore adds **~1 ms to every request/response round-trip**.

→ needs **`yield_now()` (#1)** or **multi-fd `poll` (#2)** or **non-blocking ops
that yield (#3)**.

---

## 5. Evidence — the perf cost (hard numbers)

`web.rest` `perf-smoke`, single keep-alive connection, 15 000 round-trips, co-located
client, via `rest.start`:

| server I/O strategy                       | throughput     | `drift_framework_ratio` | perf gate (≥0.45) |
|-------------------------------------------|----------------|-------------------------|-------------------|
| original inline **blocking read** (buggy: serializes connections) | (baseline) | ~0.65 | PASS |
| event loop + non-blocking poll, **no yield** | deadlock (100% CPU) | — | hangs |
| event loop + non-blocking poll, `sleep(0)` yield | deadlock (100% CPU) | — | hangs |
| event loop + non-blocking poll, **`sleep(1ms)` yield** | **944 req/s** | **0.00** | **FAIL** |
| event loop + (hypothetical) `yield_now()` / `poll()` | (expect ~baseline) | (expect ~0.65) | (expect PASS) |

944 req/s is exactly the ~1 ms/round-trip `sleep` floor. The fix is functionally
correct; it fails *only* the perf gate, *only* because there is no cheap yield. A
real `yield_now()` (or, better, a multi-fd `poll` so the loop blocks instead of
polling) restores reactor-speed round-trips.

---

## 6. The asks (full suite, priority order)

**#1 — `conc.yield_now()` (smallest unblock).**
```drift
fn yield_now() nothrow -> Void
// Relinquish the current VT to the scheduler's ready queue; resume on the next
// scheduler turn. No timer, no minimum delay. Cheap no-op off the VT runtime.
```
Lets the event loop hand the worker to the co-located client between non-blocking
sweeps without the ~1 ms `sleep` floor. One-line swap in our server; we re-run perf.

**#2 — multi-fd readiness / `poll` (the durable, "correct" primitive).**
```drift
struct PollEntry { fd: Int, want_read: Bool, want_write: Bool }
struct PollReady { fd: Int, readable: Bool, writable: Bool, hangup: Bool }
fn poll(entries: &Array<PollEntry>, timeout: conc.Duration)
    nothrow -> core.Result<Array<PollReady>, NetError>
// Park the calling VT until ≥1 fd is ready (or timeout); return the ready subset.
```
`TcpStream.raw_fd()` / `TcpListener.raw_fd()` already exist to obtain fds — what's
missing is the *wait* primitive. With this the event loop **blocks efficiently** on
"any of {listener, conn₁…connₙ} ready" and never spins or sleeps at all. This is the
standard substrate for an epoll/kqueue server and the thing we actually want.

**#3 — make `Duration(0)` `accept`/`read`/`write` yield on `WOULD_BLOCK`** (partial
substitute for #1): a non-blocking op that finds nothing ready should cooperatively
yield rather than return into a spin.

**#4 — multi-worker reactor / fair scheduling**: a default executor with >1
reactor-integrated worker, OR fair scheduling of freshly-spawned/woken VTs so they
are not starved behind already-ready I/O fibers. This is what would make the
one-fiber-per-connection design (§4.A) robust, including under valgrind.

**#5 — custom executor lifecycle + reactor integration:**
```drift
fn Executor.shutdown(self: &Executor, timeout: conc.Duration)
    nothrow -> core.Result<Void, ConcurrencyError>   // drain + join workers
```
and: VTs spawned on a custom executor must service async socket I/O through the same
reactor as the default executor (today they don't, reliably).

Any one of **#1 / #2 / #3** unblocks shipping the correct event-loop server. **#2**
is the long-term right answer; **#1** is the minimal safe stopgap. **#4 / #5** would
additionally reopen the per-connection-fiber design.

---

## 7. Repro / artifacts (in the web-drift repo)
- Single-fiber event-loop **spike** proving the design works and that neither
  non-blocking ops nor `sleep(0)` yield:
  `work/web-rest-keepalive-accept-serialization/spike/spike.drift`
  (`spike` = working with `sleep(1ms)`; `spike2` = no-yield, busy-spins; `spike3` =
  `sleep(0)`, busy-spins).
- Full investigation, iteration history, and the shipped event-loop fix:
  `work/web-rest-keepalive-accept-serialization/{PLAN,PROGRESS}.md`.
- Perf reproduces via `packages/web-rest/tests/perf/perf_smoke_test.drift`
  (`bench_baseline_health` → `rest.start` → the event loop).

We will adopt `yield_now()` (or `poll()`) the moment it lands and re-run the perf
gate. Happy to pair on the API shape or test against a prototype.
