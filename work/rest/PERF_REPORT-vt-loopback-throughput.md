# Performance Report: VT Loopback Throughput

**Date:** 2026-03-02
**Author:** web.rest team
**Audience:** Compiler & stdlib team
**Severity:** High — order-of-magnitude gap vs mature runtimes

## Summary

We benchmarked raw VT + TCP loopback throughput to establish a performance
floor for the REST framework. The result — **~4,300 req/sec** on a minimal
zero-allocation echo path — places the Drift VT runtime roughly **10-25x
behind mature runtimes** on an equivalent workload.

This ceiling directly limits every networked Drift application. The REST
framework cannot exceed this rate regardless of how well optimized its own
code path becomes.

## Benchmark: baseline-vt

**What it measures:** absolute minimum cost of one HTTP-shaped TCP
round-trip on the VT runtime, with all application-level overhead removed.

**Setup:**
- Server VT: pre-allocated read buffer, pre-built fixed 63-byte response,
  scan for `\r\n\r\n`, write fixed bytes. Zero allocations per request.
- Client VT: pre-allocated write buffer, pre-built fixed 34-byte request,
  read fixed-length response. Zero allocations per request.
- Single keep-alive TCP connection on 127.0.0.1 (loopback).
- 50 warmup requests, 5000 measured requests.
- Default executor: 1 carrier thread (both VTs cooperative on same OS thread).
- Reactor thread handles epoll wakeups.

**Results (3 runs):**

| Run | iters | total_ms | avg_us | req/sec |
|-----|-------|----------|--------|---------|
| 1   | 5000  | 1148     | 229    | 4,355   |
| 2   | 5000  | 1205     | 241    | 4,149   |
| 3   | 5000  | 1197     | 239    | 4,177   |

**Median: ~4,200 req/sec, ~235µs per round-trip.**

**Repro:**

```sh
tools/drift_test_parallel_runner.sh run-one \
  --src-root packages/web-jwt/src \
  --src-root packages/web-rest/src \
  --test-file packages/web-rest/tests/perf/baseline_vt_test.drift \
  --target-word-bits 64
```

## Comparison: mature runtimes

Equivalent workload: single-connection loopback TCP echo, minimal parsing,
fixed response, single-threaded/single-core. Published numbers and
independently reproducible benchmarks.

| Runtime | req/sec (approx) | avg latency | Notes |
|---------|-----------------|-------------|-------|
| Raw C + epoll | 100,000–200,000 | 5–10µs | Direct syscalls, no scheduler |
| Go (net/http) | 50,000–100,000 | 10–20µs | Goroutine scheduler, netpoller |
| Tokio (Rust) | 50,000–100,000 | 10–20µs | async/await, epoll, work-stealing |
| Node.js (libuv) | 15,000–30,000 | 33–66µs | Single-threaded event loop |
| **Drift VT** | **~4,200** | **~235µs** | ucontext fibers, 1 carrier, epoll reactor |

**Gap: 10–25x behind Go/Tokio, 4–7x behind Node.js.**

## Per-request cost breakdown (estimated)

Each round-trip involves:

```
client: stream.write()     →  reactor_register_io + vt_park + epoll_ctl
        [carrier switches to server VT]
server: stream.read()      →  reactor wakeup + vt_unpark + swapcontext
server: [scan 34 bytes for \r\n\r\n]
server: stream.write()     →  reactor_register_io + vt_park + epoll_ctl
        [carrier switches to client VT]
client: stream.read()      →  reactor wakeup + vt_unpark + swapcontext
```

Per I/O operation:
1. `reactor_register_io()` — pthread_mutex lock, epoll_ctl, unlock
2. `vt_park_until()` — pthread_mutex lock, state change, swapcontext
3. Reactor: `epoll_wait()` returns → pthread_mutex lock, unpark, cond_signal
4. Carrier: pthread_mutex lock, dequeue, swapcontext into VT

That's **4 mutex lock/unlock pairs per I/O call**, and **4 I/O calls per
round-trip** = **~16 mutex operations per request**, plus 4 epoll_ctl calls
and multiple swapcontext calls.

For comparison, Go's netpoller integrates epoll directly into the goroutine
scheduler with lock-free readiness queues. Tokio uses thread-local task
queues with work-stealing. Both avoid per-I/O mutex contention.

## Suspected hotspots

In priority order:

1. **Mutex contention in reactor registration.** Every `stream.read()` and
   `stream.write()` takes a pthread_mutex lock on the reactor. On a single
   carrier thread this serializes but still pays lock/unlock overhead. On
   multi-carrier it would become true contention.

2. **Per-I/O epoll_ctl calls.** The reactor appears to add/remove fds from
   epoll on each I/O operation rather than keeping persistent registrations.
   Persistent edge-triggered registration with rearm would eliminate most
   epoll_ctl syscalls.

3. **VT park/unpark path.** Each park involves mutex + state machine
   transition + swapcontext. Each unpark involves mutex + cond_signal.
   Lighter mechanisms (futex, atomic-only fast path) could reduce this.

4. **Reactor thread polling granularity.** If the reactor's epoll_wait has
   a non-zero timeout or batches poorly, it adds latency between I/O
   readiness and VT unpark.

## Impact on web.rest

| Benchmark | req/sec | Description |
|-----------|---------|-------------|
| baseline-vt | ~4,200 | VT + TCP floor (this report) |
| baseline-health (REST) | ~97 | Full REST framework path |

The REST framework adds its own 45x overhead (allocation, string ops,
parsing, serialization) on top of the VT floor. That's a separate problem
we'll address in the framework. But even with a perfect zero-overhead
framework, the VT runtime caps us at ~4,200 req/sec — well below what
users expect from an HTTP server.

Both problems need to be solved for Drift to be competitive in networked
workloads.

## Suggested investigation

We don't prescribe solutions — the runtime team knows the codebase best.
But the benchmark and repro are available for profiling:

- `perf record` / `perf report` on the baseline-vt binary will show
  exactly where cycles are spent
- The benchmark is self-contained (no framework dependencies) and runs
  in ~1.2 seconds

We're happy to add additional benchmark variants if useful (multi-carrier,
larger payloads, concurrent connections, etc.).
