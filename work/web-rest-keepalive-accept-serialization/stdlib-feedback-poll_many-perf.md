# FEEDBACK — `poll_many` / `yield_now` trial: what's golden + perf/ergonomics asks

**From:** web-drift team (web.rest). **Re:** staged `driftc 0.33.48 | abi 18`.
**Context:** We rebuilt `web.rest`'s server as a single-fiber `poll_many` event loop
(the design these primitives were requested for — see
`2026-06-20-runtime-primitives-for-concurrent-servers.md`). It works and is fair.
This is trial feedback after implementing and benchmarking against it.

## What's golden (ship as-is)
- **`yield_now()`** — exactly right; the cheap cooperative point we needed.
- **`poll_many` core semantics** — multi-fd wait, `millis<=0` parks, fd coalescing,
  hangup/error surfaced regardless of requested direction, fd-close → hangup.
- **Level-triggered + advisory readiness** ("do the op, handle WOULD_BLOCK, poll
  again") — correct default; our pipelining/partial-read handling relies on it.
- `TcpListener.raw_fd()` for listener readiness — needed, present.

These unblocked us completely. The asks below are additive perf/ergonomics, not
corrections.

## Measured result (so the asks have weight)
`web.rest` perf-smoke, single keep-alive connection, 15k request/response
round-trips, co-located client:
- sleep(1ms)-yield event loop: **944 req/s**.
- `poll_many` event loop: **~166,000 req/s** (a 175× fix — thank you).
- Raw blocking-read baseline (no multiplexing): ~294,000 req/s.
- So the framework ratio (our event loop / raw baseline) is ~0.56 — comfortably
  above our 0.45 gate, but down from ~0.65 for the old (buggy, non-fair) inline
  blocking-read server. That ~14% gap is the multiplexing tax, and it traces to
  exactly two things below.

## Perf asks (highest-impact first)

### 1. A fused readiness→read path (the multiplexing tax)
Per request the loop pays **two** syscalls — `poll_many` (wait) then a non-blocking
`read` (drain) — where a plain blocking `read` is **one** (the kernel fuses
wait+read). For non-pipelined request/response (the common case) that doubled
wait-path syscall count is the bulk of the 0.65→0.56 gap. Options:
- An **`io_uring`-backed submission/completion API** (batch reads/writes/accepts,
  amortize syscalls, scale to many fds) — the durable answer; would likely beat
  the blocking baseline under load.
- Or, smaller: a `poll_many` variant that, for readable fds, returns the **first
  available chunk** already read into caller buffers — collapsing wait+read for
  the steady state.

### 2. Token-carrying readiness (O(1) dispatch + ergonomics)
`PollReady` reports `fd`, so the loop must map fd→connection with a linear scan
(O(ready × conns) per wake). Add an opaque caller token (like `epoll_event.data`):
```drift
struct PollEntry { fd: Int, token: Int, want_read: Bool, want_write: Bool }
struct PollReady { token: Int, fd: Int, readable: Bool, writable: Bool, hangup: Bool, err: Bool }
```
The loop then indexes its connection table directly — no scan, matters at high
connection counts, and is cleaner.

### 3. Zero-copy writes from `Array<Byte>` + offset
`TcpStream.write` takes only `&io.Buffer`, so we copy each serialized response
(`Array<Byte>`) into a fresh `io.Buffer` per write; and a partial write forces
`Array.remove_range(0, n)` (O(n) shift) to advance. Both vanish with:
```drift
fn write(self: &TcpStream, bytes: &Array<Byte>, offset: Int, len: Int, timeout) -> Result<Int, NetError>
```
(write a sub-range; track an offset instead of shifting). Removes an alloc+copy
and an O(n) shift from every response.

### 4. Buffer reuse ergonomics
To reuse one scratch write-buffer across differently-sized responses we need to
reset/return its length — e.g. `io.buffer_reset(&mut Buffer)` /
`io.buffer_set_len(&mut Buffer, n)`. Today reuse only works for the read side
(read returns n; we ignore the buffer's len).

### 5. Minor
- `accept_many` / a "drain the backlog" accept that returns up to N pending
  connections in one call (we currently loop `accept(0)` until WOULD_BLOCK).

## Net
`poll_many` + `yield_now` are the right primitives and made a correct, fair server
possible at ~166k req/s. #1 (fused/batched I/O, ideally io_uring) is the one that
would also make it *fast* — beating the blocking baseline rather than trailing it —
and #2/#3 are easy wins that drop per-request work. Happy to prototype against any
of these.
