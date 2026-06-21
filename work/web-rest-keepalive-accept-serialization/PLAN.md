# PLAN — web-rest keep-alive accept serialization fix

## Decision (user-approved 2026-06-20)
**Option 1: staged event-loop rewrite as a root-cause fix.** Rewrite `web.rest`
`serve()` as a SINGLE server fiber that multiplexes accept + all active
connections via non-blocking I/O, so an idle keep-alive connection never parks
the loop and never blocks accept of / service of other connections.

Rejected alternatives:
- Per-connection VT fibers (the path explored earlier): fragile on this runtime —
  a co-located client+server has 3+ fibers on ONE cooperative worker and a
  later keep-alive request's read-wake starves → `client.send` Err (proven:
  original inline server 0/10 plain + 3/3 valgrind stable; fiber version 1/5
  plain + 5/5 valgrind fail). Do NOT reintroduce per-connection fibers until the
  runtime has fair fiber scheduling / a multi-worker reactor.
- Test-policy workaround (exclude the concurrent path from memcheck): wrong
  tradeoff for a server library — bakes in a scheduler-dependent failure mode.

Design constraint: a single server fiber that never parks behind one idle stream
is the robust root-cause fix for this repo today.

## Staged plan (execute in order; validate each before the next)
1. **Pin the regression FIRST.** A web-rest test: conn A sends default keep-alive,
   reads one complete response, stays open/idle; conn B sends a fresh request and
   must receive a response promptly. Pins the invariant "idle keep-alive must not
   block accept or unrelated connections."
   STATUS: DONE — `keepalive_test.scenario_sequential_fresh_connections` (holds
   A/B/C open simultaneously; 2000ms client read budget < 5000ms server
   idle_timeout, so a serial server fails it). Keep it; it must pass post-rewrite.
2. **Narrow event-loop spike.** Prove one fiber can multiplex accept + a readable
   connection set using std.net non-blocking timeout behavior (echo only, no HTTP
   semantics). Validate: WOULD_BLOCK detection, Array<stream> swap-remove,
   non-blocking read/write, and yielding to a co-located client fiber. Keep small.
3. **Extract only the parser boundary.** `http.drift` exposes a pure
   buffer→request helper: "does conn_buf hold a complete request? parse it and
   trim consumed bytes; else signal need-more." Reuse existing Phase-1
   completeness logic + `_parse_request_full` + `remove_range`. No I/O. So the
   server loop accumulates per-connection bytes without blocking inside
   `read_one_request`.
4. **Rewrite serve() around connection state.** Parallel arrays of active
   connections: stream, read buffer, last-active timestamp/idle counter,
   close-after-write flag. Each loop tick:
   - accept any newly-available connection (non-blocking);
   - service readable existing connections with zero/short-timeout reads;
   - dispatch complete requests and write responses;
   - close idle / errored / `Connection: close` streams;
   - `conc.sleep(small)` when the tick made no progress (avoid busy-spin AND
     yield the worker to co-located fibers).
5. **Revalidate the contract.** same-connection keep-alive still works;
   pipelined/back-to-back requests still work; malformed-request recovery closes
   only that connection; fresh connections progress while another keep-alive is
   idle; shutdown still exits promptly. (= existing keepalive_test scenarios 1-7
   + server_test + e2e, under plain + asan + memcheck.)
6. **Re-run perf-smoke.** The event loop changes the hot path; the pinned ratio
   (0.65 vs Go net/http) matters. If it regresses, tune loop tick / read batching
   before merging.

## Validation gates (all must pass)
- `just check-one packages/web-rest/tests/unit/keepalive_test.drift` (fast loop)
- Full unit/e2e executor, plain+asan+memcheck, incl. web-client e2e (they use a
  web.rest server) — run directly to bypass the stale-lock `lock-check`:
  `python3 tools/emit_test_plan.py test --out P && python3 $RUNNER --plan P --work-dir W --keep-going`
- Targeted valgrind loop on serve_test + http_e2e (was 5/5 fail on fibers; must be
  0/N fail).
- `just stress` and `just perf-smoke` (blocked on stale net-tls lock — see
  PROGRESS "Infra blocker"; run via emit_test_plan stress/perf directly).
- Version bump web-rest patch (0.5.4 → 0.5.5) + reseal — infra/trust step, confirm
  with user (coupled to the stale-lock resolution).

## Notes
- NOT a compiler bug (stdlib has non-blocking I/O + everything needed). The
  single-worker cooperative scheduler starving freshly-woken fibers is a runtime
  limitation worth flagging, but the event-loop design sidesteps it entirely.
- See PROGRESS.md for live status, the preserved repro (`./repro/`), key API
  facts, and the iteration history that led to this decision.
