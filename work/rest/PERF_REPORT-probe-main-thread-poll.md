# Performance Report: Main-Thread 10ms Poll Quantum is the Bottleneck

**Date:** 2026-03-02
**Author:** web.rest team
**Severity:** Critical finding — explains the entire 10ms per-request stall

## Summary

The ~10ms per-request latency observed in all REST benchmarks is caused by
the **benchmark client running on the main thread**, which uses a 10ms
polling loop (`_park_main_thread_io` / `MAIN_THREAD_IO_POLL_QUANTUM_MS`)
instead of epoll for I/O readiness. Moving the client to a VT fiber
(epoll path) reduces round-trip latency from ~10,000µs to **~20-30µs**.

This means:
1. The REST framework is **not** the bottleneck. Full dispatch is ~20-30µs.
2. The VT baseline report's ~235µs number was also main-thread-bound.
3. The "680x allocation bottleneck" report's headline was wrong — the gap
   was the poll quantum, not allocations.

## Root cause

`stdlib/std/net/net.drift` line 68:
```
pub const MAIN_THREAD_IO_POLL_QUANTUM_MS: Int = 10;
```

When `vt_current() == 0` (main thread), every `stream.read()` and
`stream.write()` that would block calls `_park_main_thread_io()`, which
sleeps for up to 10ms before retrying. On a VT fiber, the same call uses
`reactor_register_io()` + `vt_park_until()` → epoll, which wakes
immediately when data arrives.

All previous benchmarks run `main()` → client loop on the main thread.
The server is spawned via `conc.spawn_cb()` onto a VT fiber (fast path).
Result: the client adds ~10ms of poll latency per read/write call.

## Probe results

### Probe 1: Timeout sensitivity (both sides on VT fibers)

Client and server both spawned via `conc.spawn_cb()` — both use epoll.

| Server read_timeout | Server read_avg_us | Client read_avg_us | Served |
|---------------------|--------------------|--------------------|--------|
| 5ms                 | 30                 | 30                 | 100/100 |
| 10ms                | 20                 | 20                 | 100/100 |
| 100ms               | 10                 | 30                 | 100/100 |
| 5000ms              | 10                 | 30                 | 100/100 |

**Full REST framework dispatch in ~20-30µs.** The server read_timeout
has no effect on latency because data arrives immediately via epoll.

### Probe 2: Read-call count (client on main thread)

Server on VT fiber, client on main thread.

| Metric | Value |
|--------|-------|
| avg reads per request | 1 |
| server first_read_avg_us | **10,188** |
| client read_avg_us | **10,166** |

The server makes exactly 1 `stream.read()` call per request, but that
call takes ~10ms because the **client** write is delayed by the main
thread poll quantum. The data doesn't arrive at the server until the
client's `_park_main_thread_io()` cycle completes.

### Probe 3: Raw keep-alive ping-pong (client on main thread)

Minimal server (scan for \r\n\r\n, write canned response). No HTTP
parsing, no dispatch, no framework. Client on main thread.

| Side | read_avg_us | write_avg_us |
|------|-------------|--------------|
| Server | **10,212** | 40 |
| Client | **10,190** | — |

Same ~10ms stall. Confirms the bottleneck is the main thread poll
quantum, not anything in the HTTP/REST code path.

### Probe 4: TCP_NODELAY

Not available. Drift's net module has no socket option API.
Only `SO_REUSEADDR` is set internally on listener sockets.

## Implications

### For the REST framework

The framework is fast: ~20-30µs per full dispatch on VT fibers. No
further framework-level optimization is needed to close this gap.

### For the benchmarks

All previous benchmark numbers (perf_test.drift, instrument_test.drift,
decompose_test.drift CPU-vs-REST comparison) are misleading because
the client ran on the main thread. To get accurate REST framework
numbers, the client must run on a VT fiber:

```drift
// WRONG — client on main thread (10ms poll quantum)
fn main() nothrow -> Int {
    // ... spawn server ...
    _client_loop(port);  // runs on main thread
}

// RIGHT — client on VT fiber (epoll, immediate wakeup)
fn main() nothrow -> Int {
    // ... spawn server ...
    var cl = conc.spawn_cb(| | captures(...) => {
        return _client_loop(port);
    });
    val _ = cl.join();
}
```

### For the stdlib allocation report

The allocation reductions (StringBuilder, parse_int_bytes, remove_range,
etc.) are still good changes — they reduced heap allocation counts by
15-25% and eliminated O(n²) string concat. But they did not and could
not affect the ~10ms headline number, because that was the poll quantum.

### For real-world usage

In production, REST server handlers run on VT fibers (fast epoll path).
Clients connect from external processes, not from `main()`. The 10ms
stall only affects benchmarks where the client loop runs in `main()`.

## Repro

```sh
just rest-probe
```

Runs all 4 probes. Compare Probe 1 (both VT, ~20-30µs) vs Probes 2/3
(client main thread, ~10,000µs).

## Recommendation

1. **No framework optimization needed** for this issue.
2. **Fix benchmarks**: move client loops to VT fibers for accurate numbers.
3. **Consider for stdlib**: either document that `main()` I/O is
   poll-based (10ms granularity), or allow main thread to register with
   the epoll reactor for immediate wakeup.
