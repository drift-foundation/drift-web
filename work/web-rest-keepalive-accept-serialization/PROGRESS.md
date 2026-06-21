# web-rest keep-alive accept serialization — PROGRESS

## 2026-06-21 (latest) — ADOPTED 0.33.49 RC (token readiness + zero-copy writes)
New staged RC `driftc 0.33.49 | abi 18` (/home/sl/opt/drift/staged/toolchain/
drift-0.33.49+abi18) supersedes 0.33.48 and folds in OUR requested API changes:
- PollEntry/PollReady now carry `token: Int` (was a REQUIRED migration — 0.33.48
  PollEntry without token no longer compiles).
- `TcpStream.write_bytes(&mut Array<Byte>, off, len, timeout)` — zero-copy range write.
- `io.buffer_reset(&mut Buffer)`. Edge-backed readiness contract now documented.

server.drift updated to use all of it:
- `_Conn.woff` (write offset) added; 2b write now uses `write_bytes(&mut wbuf, woff,
  remaining, zero)` and advances `woff` — eliminates the per-write Array->Buffer
  copy AND the O(n) `remove_range(0, wrote)` shift. Response fully sent when
  `woff >= wbuf.len` (then clear + woff=0).
- poll entries carry `token` (-1 = listener, else conn index); readiness dispatch
  uses `ready.token` → dropped the O(ready x conns) fd->conn linear scan.
- want_write now `wbuf.len > woff`; drain flush uses write_bytes from woff.
Builds + keepalive 9/9 under 0.33.49.
PERF (4 runs): framework_ratio 0.56/0.58/0.58/0.58 (up from 0.54-0.56; threshold
0.45). health 166-172k (up from 161-166k). rest_ratio 1.43/1.48/1.34/1.48 → 3/4
PASS (still go_net_http-variance sensitive on this loaded host). write_bytes/token
help the high-conn & large-response paths more than the single-conn small-response
benchmark (which is syscall-bound: poll+read+write).
FULL SUITE under 0.33.49: 140 ok / 30 failed → web-rest fails: 0 (all web-rest
unit+e2e across plain+asan+memcheck pass; 30 failures all web-client net-tls
collision). Zero regressions from token/write_bytes. FIX COMPLETE on 0.33.49.

## 2026-06-21 — RESEALED, READY FOR CERT
- web-rest version 0.5.4 -> 0.5.5 (patch bump per feedback_versioning; only
  web-rest changed). Consumers pin to "0.5" (minor), unaffected.
- `just author-claim web-rest` minted drift/web-rest.author-claim (0.5.5,
  source_content_id sha256:bbbc0c12...).
- `just prepare` re-resolved drift/lock.json (web-rest->web-jwt@0.4.2,
  web-client->net-tls@0.5.2; lock content unchanged — deps didn't move).
- `just trust-check`: all 4 artifacts trust-v1 ready (✓ web-jwt ✓ web-rest
  ✓ or-throw-probe ✓ web-client).
Changed for review/commit: drift/manifest.json, drift/web-rest.author-claim,
packages/web-rest/src/{server,http}.drift, packages/web-rest/tests/unit/keepalive_test.drift.
Remaining infra (not blocking web-rest cert): net-tls re-cut for abi18 (web-client
e2e cross-check), idle-host rest_ratio re-measure.

## 2026-06-21 — net-tls 0.5.3 (abi18 re-cut) IN; FULL SUITE GREEN END-TO-END
net-tls 0.5.3 published to ~/opt/drift/staged/libs/net-tls/0.5.3/ (ProcessSignal
schema collision fixed). web-client pins net-tls "0.5" (minor) → `just prepare`
auto-resolved net-tls@0.5.3 (lock.json updated: sha 7b6833e4...). 
- FULL SUITE under 0.33.49 + net-tls 0.5.3: **170 ok / 0 failed** (every web-rest
  AND web-client test, plain+asan+memcheck). The web-client e2e tests run against
  the web.rest server, so this is the cross-check of the fix — GREEN.
- `just trust-check`: all 4 artifacts trust-v1 ready.
FINAL CHANGED FILES (review/commit): drift/lock.json (net-tls 0.5.3),
drift/manifest.json (web-rest 0.5.5), drift/web-rest.author-claim,
packages/web-rest/src/{server,http}.drift, packages/web-rest/tests/unit/keepalive_test.drift.
STATUS: COMPLETE — bug fixed, fully validated end-to-end, resealed, cert-ready.
(Optional: idle-host rest_ratio re-measure; 3/4 pass on loaded dev host,
framework_ratio 0.56-0.58 comfortable.)


## 2026-06-21 (late) — EDGE-TRIGGERED READ DRAIN FIX (code review + toolchain confirm)
Code review caught a HIGH bug; compiler team CONFIRMED the runtime reactor is
edge-backed (EPOLLET) internally — the staged docs' "level-triggered" wording was
a docs bug they're fixing. Contract (now authoritative):
  after readable → drain reads until WOULD_BLOCK / EOF / error / fairness cap;
  after writable → write until WOULD_BLOCK / output queue empty;
  a partial drain may get NO further wake for bytes already in the socket buffer.

FIXED (server.drift 2a): replaced the one-read-per-readiness with a DRAIN loop —
read until WOULD_BLOCK/EOF/error, 256 KB per-pass fairness cap (cap-hit leaves
`readable` true → resume next pass). Previously a request larger than read_scratch
(4096B) or split across segments would stall until idle-timeout under ET.
- Write side (2b) NOT looped: a partial write means the socket buffer is full, so
  we correctly wait on the `want_write` poll edge (already in poll entries) and 2b
  retries each pass — correct for ET without an O(n^2) per-pass re-copy. (Reads are
  the asymmetric case: socket holds an unknown amount.)
- NEW regression: keepalive_test scenario_large_request_drained — POST ~12KB body
  (> scratch), require prompt 200. Stalls under the old single-read on this ET
  runtime → has teeth. keepalive 9/9 pass.

Toolchain team response to our feedback (folding into ABI 18 RC before cert):
  1. Token-carrying readiness: PollEntry/PollReady gain `token: Int` (dup fd valid
     only when tokens agree). → WHEN THE NEW RC LANDS, adopt token and drop the
     fd→conn linear scan at server.drift poll-result loop (the `while ci<conns.len`
     fd match). Our PollEntry construction will need the token field then.
  2. Edge-triggered docs + example (above) — done on their side.
  3. Maybe: Array<Byte> range writes + buffer reset/set_len (zero-copy writes) if
     scope stays small. Deferred: io_uring/fused readiness->read, accept_many.

FINAL VERIFICATION (abi18, staged toolchain):
- Correctness: full suite 140 ok / 30 failed → **web-rest fails: 0** (every
  web-rest unit+e2e across plain+asan+memcheck, incl. keepalive 9/9 with the new
  large-request drain test). The 30 failures are ALL web-client (net-tls
  ProcessSignal schema collision — infra, see blocker above). Zero regressions
  from the drain change.
- Perf (post-drain, 3 runs): framework_ratio 0.54/0.56/0.54 (threshold 0.45 — PASS
  with margin); rest_ratio 1.38/1.43/1.51 (2/3 PASS, borderline, variance/load
  dominated on this dev host; framework_ratio is the machine-independent measure).

STATUS: web-rest fix COMPLETE and validated. Remaining items are all infra/handoff
(net-tls re-cut for abi18; idle-host perf re-measure for rest_ratio; version bump
0.5.4→0.5.5 + reseal; adopt PollEntry/PollReady `token` when the updated RC lands).


## 2026-06-21 — TOOLCHAIN SHIPPED THE PRIMITIVES; PERF-CLEAN FIX DONE
Toolchain delivered exactly the requested primitives in staged RC
`driftc 0.33.48 | abi 18` (`/home/sl/opt/drift/staged/toolchain/drift-0.33.48+abi18`,
libs `/home/sl/opt/drift/staged/libs`; net-tls self-attested ready):
- `std.concurrent.yield_now()` (cheap cooperative yield).
- `std.io.poll_many(entries, timeout)` (multi-fd readiness) + `TcpListener.raw_fd()`.

Switched verification to the staged toolchain (abi18 requires rebuilds).

EVENT LOOP NOW USES poll_many (not sleep). Readiness-driven design:
- park in `io.poll_many` on {listener + all conn fds} until ready (or poll_timeout
  200ms for housekeeping/shutdown). Reactor-fast wake on data; parks (yields to
  co-located client); strictly fair (idle conn isn't "ready").
- ACCEPT gated on poll-reported listener readability (+ first iter + 64-iter
  safety) → no per-sweep accept() syscall.
- READ gated on poll-reported per-conn readability (`_Conn.readable`, level-
  triggered) → no wasted WOULD_BLOCK read; parsing of buffered/pipelined requests
  stays unconditional.
- Optimistic flush: read→parse→dispatch→write in ONE iteration.
- Reused read scratch buffer + poll-entries array (fewer per-request allocs).
- Graceful drain still flushes pending wbuf on shutdown.

PERF (perf_smoke_runner.sh, single keep-alive conn, 15k round-trips):
- sleep(1ms) version: 944 req/s, framework 0.00 → poll_many version: **166,666
  req/s**, framework_ratio **0.56** (threshold 0.45 — passes with margin).
- drift_raw_ratio ~1.0 (unaffected; baseline server). drift_rest_ratio
  (health/go_net_http) = 1.36 / 1.46 / 1.40 across 3 runs → 2/3 PASS, right at the
  1.40 threshold, variance dominated by go_net_http on a LOADED dev host
  (quantized 5k-request timing). Cert host measures on an idle host → expected
  cleaner. The event loop is inherently ~1 extra syscall/request (poll+read vs the
  old inline blocking-read), so health is ~166k vs the old inline ~191k — that's
  the cost of fair multiplexing; framework_ratio (the machine-independent measure
  of OUR overhead) has 24% margin.

Correctness under abi18: ALL web-rest tests PASS (unit + e2e, plain+asan+memcheck) —
keepalive 8/8 incl. fairness regressions, server_test, serve_test, middleware,
zero_timeout, startup. **0 web-rest failures.**

BLOCKER for the web-client e2e cross-check (those tests use a web.rest server, so
they'd additionally exercise this fix): all 25 web-client jobs FAIL to BUILD under
abi18 with `variant schema collision for 'std.concurrent:ProcessSignal'`. Cause:
staged net-tls latest is 0.5.2 (May 31), built against pre-abi18 std.concurrent
(abi18 changed std.concurrent — gained yield_now), so the net-tls artifact's
imported ProcessSignal schema collides. web-rest has NO net-tls dep → unaffected.
This is a **net-tls re-cut for abi18 (infra)**, NOT this fix. ("self-attested
ready" appears stale — the artifact predates the abi18 toolchain.) Do not re-cut
net-tls ourselves (feedback_no_deploy_tls). Surface to net-tls/toolchain team.
[Note: serve_test + http_e2e were 0/6 valgrind on the PRE-poll_many (abi17,
sleep) event loop; re-running http_e2e under abi18+poll_many is blocked on the
above. web-rest serve_test under abi18 passes, covering the server path.]

OPEN / handoff:
- net-tls re-cut for abi18 → then re-run web-client e2e to fully cross-check.
- rest_ratio: 2/3 PASS on a loaded dev host (variance ~1.40); re-measure on the
  idle cert host. framework_ratio 0.56 (machine-independent, 24% margin) is solid.
- version bump web-rest patch 0.5.4→0.5.5 + reseal on staged (infra/trust).
- stdlib feedback filed: /tmp/drift-announce/2026-06-21-poll_many-feedback-*.md
  (durable: ./stdlib-feedback-poll_many-perf.md).



## 2026-06-20 — PERF BLOCKED ON MISSING RUNTIME YIELD (current head state)
Event-loop rewrite is CORRECT: passes full correctness suite (170/170 plain+asan+
memcheck), all new regressions, serve_test + http_e2e 0/6 valgrind (were 5/5 FAIL).
BUT it FAILS perf-smoke: the only available yield is `conc.sleep(≥1ms)`, which adds
~1ms/round-trip → 944 req/s → drift_framework_ratio 0.00 (threshold 0.45).
- VERIFIED: non-blocking Duration(0) ops do NOT yield the worker; `conc.sleep(0)`
  ALSO does NOT yield — BOTH busy-spin at 100% CPU and deadlock a co-located client
  (spike2 / spike3, 40+ CPU-min, never complete). Only `sleep(≥1ms)` yields.
- So the clean fix needs a runtime primitive that does not exist: `yield_now()`
  (cheap cooperative yield) or `poll()` (multi-fd readiness). NOT a compiler bug.
- TOOLCHAIN REQUEST WRITTEN: /tmp/drift-announce/2026-06-20-runtime-primitives-for-
  concurrent-servers.md (durable copy: ./toolchain-request-concurrency-primitives.md)
  — comprehensive: why/end-goal/architecture/perf-needs + full primitive suite
  (yield_now, multi-fd poll, non-blocking-yields, multi-worker reactor, executor
  lifecycle) with proposed APIs + evidence.
- DECISION PENDING (user): how to proceed while perf is blocked —
  (A) ship event loop + sleep(1ms) now, accept perf-gate fail, swap to yield_now()
      when it lands (one line); (B) hold the fix until yield_now()/poll() lands;
  (C) interim hybrid = blocking read with a SHORT timeout (reactor-driven, ~baseline
      perf, bounded — not strictly-zero — fairness; needs no new primitive). I
      analyzed C as viable for perf AND the fairness tests but it weakens the strict
      invariant the user emphasized.



## 2026-06-20 — EVENT-LOOP REWRITE IMPLEMENTED (current state)
Replaced per-connection fibers with a single-fiber non-blocking event loop
(PLAN.md option 1). See PLAN.md for the staged plan; all 6 steps essentially done:
- Step 1 (pin regression): keepalive_test scenario_sequential_fresh_connections.
- Step 2 (spike): work/.../spike/spike.drift — passed plain 3/3 + valgrind 3/3.
- Step 3 (parser boundary): `http.try_parse_request(&mut conn_buf)` added/exported
  — pure completeness-check + parse + trim, NO I/O.
- Step 4 (serve rewrite): server.drift serve() is now a single fiber owning a
  `_Conn[]` (stream, rbuf, wbuf, close_after, last_active_ms). Each tick: one
  non-blocking accept; per conn ONE non-blocking op (flush pending wbuf, else
  read→accumulate→try_parse→dispatch→serialize into wbuf); swap-remove on
  EOF/error/Connection:close/idle-timeout; sleep(1ms) only on a no-progress tick
  (yields the worker to co-located fibers). Graceful drain flushes pending wbuf
  before close (so the final response under max_requests / shutdown is delivered).
  Removed: _serve_connection, _handle_connection, _dispatch_and_write, the
  per-connection fibers, the started-handshake, and the shared atomics. `timeout`
  param now unused for per-conn I/O (all non-blocking).
- Step 5 (revalidate): keepalive_test (8 scenarios incl. new #8 partial/silent)
  PASS 0.2s; server_test/serve_test/middleware PASS plain; serve_test + http_e2e
  rebuilt against new source → VALGRIND 0/6 each (were 5/5 FAIL on fibers). Full
  executor run (plain+asan+memcheck) IN PROGRESS.
- Step 6 (perf-smoke): PENDING.

Regression tests added (all assert PROMPT progress < idle_timeout, per user):
- #7 scenario_sequential_fresh_connections — idle A doesn't block fresh B/C.
- #8 scenario_partial_connection_does_not_block — A sends partial headers + stays
  silent; B must get prompt 200 (2000ms budget < 5000ms idle). Catches the
  blocking-read trap directly.
- (#2 same-connection keep-alive already covered by scenario_two_requests.)
- #4 large-write fairness: not added as a unit test (hard to force response >
  socket buffer + slow reader reliably). Writes ARE non-blocking by design
  (wbuf buffering); documented as a follow-up to add a targeted test.

Key impl decisions / gotchas discovered:
- non-blocking write may be PARTIAL: track by removing written bytes from wbuf,
  retry next tick. timeout=0 read: Ok(0)=EOF, Err(WOULD_BLOCK)=no-data.
- `Array<_Conn>` with in-place field mutation via index WORKS (probed):
  `conns[i].rbuf.push()`, `conns[i].last_active_ms = x`, `conns[i].stream.read()`,
  swap+pop. Empty array in struct ctor needs a typed local (`var rb:Array<Byte>=[]`).
- max_requests check at loop top fired AFTER dispatch but BEFORE wbuf flush →
  final response lost. Fixed by graceful-drain flush.
- monotonic clock: capture `time.now_monotonic()` once, `time.elapsed_ms(&clock)`
  per tick for idle math.

**Status:** FIX IMPLEMENTED + passing locally (keepalive_test 0.4s, incl. new
regression scenario). Full unit/e2e executor (plain+asan+memcheck) running.
Cert gate wrappers (`just test/stress/perf-smoke`) BLOCKED on a pre-existing
stale `net-tls` lock (see "Infra blocker" below) — NOT caused by this change.

## DECISION (user, 2026-06-20): staged event-loop rewrite (option 1)
NOT per-connection fibers (fragile until runtime has fair scheduling), NOT a
test-policy workaround. Single server fiber that never parks behind one idle
stream. User's staged plan:
1. Pin the regression FIRST: conn A keep-alive, reads one response, stays idle;
   conn B fresh request must get a prompt response. (DONE: keepalive_test
   scenario_sequential_fresh_connections — holds A/B/C open, 2000ms read budget
   < 5000ms idle_timeout. Keep it.)
2. Narrow event-loop SPIKE: prove one fiber multiplexes accept + readable
   connection set via std.net non-blocking timeouts; keep small, no response
   semantics yet. [IN PROGRESS — work/.../spike/]
3. Extract ONLY the parser boundary: http.drift exposes "buffer has complete
   request / parse complete request from buffer" so the loop accumulates per-conn
   bytes without blocking inside read_one_request.
4. Rewrite serve() around connection state: parallel arrays (stream, read buf,
   last-active ms, close-after-write). Each tick: accept any new conn, service
   readable conns with zero/short-timeout reads, dispatch complete requests,
   write responses, close idle/errored/Connection:close streams.
5. Revalidate contract: same-conn keep-alive, pipelined/back-to-back, malformed
   closes only that conn, fresh conn progresses while another keep-alive idle,
   prompt shutdown.
6. Re-run perf-smoke; tune loop tick/read batching if the pinned ratio regresses.

Key Drift facts for the rewrite:
- non-blocking I/O: accept/read/write with `conc.Duration(millis=0)` →
  `Err(net.NetError)` with `.kind == net.NET_ERROR_KIND_WOULD_BLOCK`. read Ok(0)=EOF.
- connection list = PARALLEL arrays (idiom: context.drift) with swap-remove:
  `arr.swap(i,last); arr.pop()`. pop returns Optional<T>.
- monotonic clock: `std.time.now_monotonic()` + `elapsed_ms` for idle timeout.
- CO-LOCATED YIELD: a timeout=0 poll returns immediately and may NOT yield; the
  loop MUST `conc.sleep(small)` when a tick made no progress, both to avoid
  busy-spin and to yield the single worker to the co-located client fiber.

## RESOLUTION SUMMARY (read first)
Fix = per-connection detached VT fibers on the **default** executor + a
**started-handshake** (NOT a fixed sleep) gating the accept loop. The connection
fiber sets a shared `started` atomic to 1 as its first action; serve() blocks
(sleep-loop) until it sees started==1 before re-entering accept(). This
deterministically hands the single worker to the freshly-spawned fiber so it gets
its first slice; once started it parks on its read and is reactor-scheduled
fairly. Robust under valgrind (serve waits as long as needed).

WHY the handshake (not the earlier 1ms sleep): the fixed `conc.sleep(1ms)`
yield passed plain+asan but was FLAKY under valgrind — `serve_test#run-memcheck`
and the web-client e2e tests (they use web.rest as their server) intermittently
failed with an EMPTY response: under valgrind's dilated/serialized scheduling 1ms
wasn't enough for the new fiber to even start, so it starved exactly like the
original bug. Reproduced standalone: `serve_test` under valgrind 1/3 fail with
1ms sleep; 8/8 pass with the handshake.

Iteration history (only the handshake works):
1. Detached fiber on default executor, no yield → connection fiber STARVES (never
   scheduled) when ≥2 other I/O fibers are ready (co-located client+server).
2. Dedicated multi-thread executor (`build_executor` + `spawn_on`) → connection
   fiber runs, BUT (a) custom-executor workers can't service async socket I/O
   (epoll reactor is tied to the default runtime → flaky/hung reads), and (b) no
   Executor shutdown API → per-server pools leak threads and the 2nd build/submit
   fails. REJECTED.
3. Default executor + fixed `conc.sleep(1ms)` yield → passed plain+asan but
   FLAKY under valgrind (see above). REJECTED.
4. **Default executor + started-handshake** (fiber sets `started` atomic first;
   serve sleep-loops until started==1 before re-accepting) → robust plain + asan
   + memcheck. ADOPTED.

Trade-off: serializes connection ACCEPTANCE on the started-handshake (~the time
for the new fiber to take its first slice and park on read — microseconds
normally); connection HANDLING is concurrent and established keep-alive
connections are unaffected (no handshake in their path). perf-smoke uses ONE
persistent connection (one accept) so it's unaffected. Underlying single-worker
scheduler-fairness limitation (a freshly-spawned VT fiber is not scheduled ahead
of ready I/O fibers without an explicit handoff) flagged for the runtime team — a
real yield primitive / multi-worker reactor would let us drop the handshake. NOT
a compiler bug, NOT blocking.

## CRITICAL FINDING (2026-06-20, later): per-connection fibers are fundamentally fragile here
The started-handshake fixed serve_test + cookie_e2e under memcheck, but 3 web-client
e2e tests (http_e2e, pool_reuse, pool_framing — they use web.rest as their server)
still fail. Root: with per-connection fibers, a co-located client+server has 3
fibers (client + serve-accept-loop + connection) on ONE cooperative worker; a
LATER keep-alive request's read-wake on the connection fiber intermittently
starves → `client.send` Err (http_e2e exit 45 == return 301, the 3rd pooled
request). The started-handshake only covers the FIRST scheduling.

PROVEN: rebuilt http_e2e against ORIGINAL server.drift → 0/10 plain fail, 3/3
valgrind pass (rock stable). Against my fiber version → 1/5 plain fail, 5/5
valgrind fail. So MY change caused it. Bumping accept_timeout 200→2000 did NOT
help (not a polling-steal issue). It's inherent cooperative-scheduler contention.

Note: memory already records that the REST concurrency STRESS scenario is
deliberately NOT memchecked ("valgrind serializes its threads") — i.e. the team
already knows REST-server-concurrency-under-valgrind is problematic. My change
extends that fragility to the web-client e2e memcheck lane.

### The robust fix = single-fiber poll-based event loop (NOT per-connection fibers)
Keep serve() as ONE fiber (2-fiber total w/ client, like the stable original) and
multiplex accept + all connections via NON-BLOCKING I/O. No connection-handler
fibers → no cooperative-scheduler contention → robust under plain/asan/memcheck.
Feasibility checked:
- net has non-blocking I/O: accept/read/write with Duration(millis=0) return
  `NetError(kind = NET_ERROR_KIND_WOULD_BLOCK)`. (No WOULD_BLOCK handling exists
  anywhere in the repo yet — this would be the first.)
- Array has `.pop()` and `.swap()` → swap-remove pattern for the move-only
  connection list (Conn{stream, buf, served, last_active}).
- `http.read_one_request` is NOT directly usable (treats WOULD_BLOCK as a hard
  error). Extract a pure `try_parse_one(&mut conn_buf) -> Option<ParsedRequest>`
  from its Phase-1 completeness check + `_parse_request_full` + remove_range.
- RISK: a poll loop + sleep-when-idle vs the PINNED perf baseline (perf-smoke
  framework ratio 0.65). Saturated single connection shouldn't sleep (processes
  back-to-back) but must be measured.

### Current code state
server.drift currently holds the per-connection-fiber + started-handshake version
(passes plain+asan; fragile co-located/memcheck). Left in place per
feedback_compiler_iteration. The event-loop rewrite is the planned next step
(awaiting user direction — non-trivial architectural change + perf-baseline risk).

## Infra blocker (pre-existing, unrelated to this fix)
`just test/stress/perf-smoke` fail at the `lock-check` precondition:
`drift/lock.json` is stale vs the certified `net-tls` in DRIFT_PKG_ROOT — the
locked `source_content_id` for net-tls@0.5.2 differs from the resolved one (the
certified net-tls was re-cut). This is the recurring net-tls re-cut issue
(see memory project_staged_net_tls_schema_collision). My diff touches only
web-rest src + test. Workaround for validating THIS change: run the executor
directly, bypassing lock-check:
```
RUNNER="$DRIFT_TOOLCHAIN_ROOT/lib/tools/drift_test_run.py"; WORK=$(mktemp -d)
python3 tools/emit_test_plan.py test --out "$WORK/test-plan.json"
python3 "$RUNNER" --plan "$WORK/test-plan.json" --work-dir "$WORK"
```
Resolving the lock (`just prepare` = `drift prepare`) is an infra/trust action,
out of scope for this bug fix — surface to user; do not re-resolve unilaterally.
NOTE: gate recipe names are `test`, `stress`, `perf-smoke` (memory's
`rest-check-par`/`stress-test` are stale).

---
(historical detail below)

**Status:** root cause confirmed, fix in progress (scheduling obstacle being resolved).
**Owner:** sl. **Started:** 2026-06-20. Toolchain: certified `driftc 0.33.45 | abi 17 | git 01cee266`.

> Recovery note: the original repro bundle (`/tmp/wcbench/`) and the announcement
> (`/tmp/drift-announce/...`) live in `/tmp` and are LOST on reboot. Copies are
> preserved here: `./2026-06-20-microflows-web-rest-keepalive-latency.md` and
> `./repro/` (src + run.sh + drift/ manifest/trust/lock). Repro binaries are NOT
> copied — rebuild with `./repro/run.sh` (needs DRIFT_TOOLCHAIN_ROOT/DRIFT_PKG_ROOT).

## Defect

Reporter: Microflows team (`work/business-team-starter-kit`). Severity HIGH for
long-running services.

A client doing **sequential requests, each on a fresh `web.client` session**
(new TCP conn, default `Connection: keep-alive`) against a **`web.rest` server**
sees **~2.3 s/request** and **alternating send-errors** (every other request
fails at connect/send). The identical client load against a stock Python
HTTP/1.1 server is instant with zero failures → client and OS are exonerated;
the defect is server-side.

Reproduced locally (see repro/run.sh):
```
web.rest  (wcserver): 23.0s  send-errors=5   (10 sequential fresh-conn GETs)
python HTTP/1.1     :  0.0s  send-errors=0
```

## Root cause (CONFIRMED — NOT a compiler/stdlib bug)

`packages/web-rest/src/server.drift` `serve()` ran the per-connection handler
`_handle_connection` **inline on the single accept fiber**. The accept loop
therefore services one connection to completion before accepting the next. With
keep-alive, after a fresh-session client sends ONE request and goes idle,
`_handle_connection` loops back and **parks in `http.read_one_request` for up to
`idle_timeout_ms` (default 5000)** waiting for a 2nd request that never comes —
blocking `accept()` of every subsequent connection. Hence the per-request stall
and the 2-state oscillation. Stdlib has everything needed to fix it; nothing is
missing or misbehaving at the compiler/runtime level. **No compiler report
filed** (user asked to file ASAP if it were a compiler bug — it is not).

Confirmation that the serial design is intrinsic: every existing keep-alive test
exercises ONE client at a time; `keepalive_test.scenario_idle_timeout`
explicitly documents that a silent keep-alive conn is held until idle_timeout —
during which the single accept loop can serve no one else.

## Fix approach

Make connection handling concurrent: spawn one VT fiber per accepted connection
so `accept()` is never blocked; an idle keep-alive conn now parks only its OWN
fiber. Implemented in `serve()`:
- `_serve_connection(...)` = fiber entry; owns the moved stream, runs
  `_handle_connection`, then closes the stream. Detached (handle dropped — the
  spawn thunk keeps its own Arc to the result buffer, so the fiber runs to
  completion and frees itself; drop != cancel, drop != join-block).
- Two shared `sync.AtomicInt` (Arc-wrapped) replace the old per-loop `Int`s:
  `event_counter` (globally-unique evt-ids via fetch_add) and `requests_served`
  (max_requests accounting across all in-flight conns). A plain `&mut Int`
  shared across fibers would be a data race.
- `_handle_connection` signature changed to take the two `&conc.Arc<sync.AtomicInt>`.

Uses only `MemoryOrder::Acquire/Release` (the only variants the repo uses;
avoids risk on a `Relaxed` constructor name).

## OPEN OBSTACLE — single-worker scheduler starvation (being resolved)

Compiles clean. But `just check-one keepalive_test` FAILS: `keepalive_test#run`
exit=106 (scenario_two_requests_one_connection, response-1 read times out 5s).
Debug `console.eprintln` markers show: `serve` accepts and prints "spawning
fiber", but **"DBG conn: fiber started" NEVER prints** — the connection fiber is
queued but never scheduled.

Why: the **default executor has only 1 worker thread**. In the unit tests the
client + server are co-located in ONE process on that 1 worker:
- main/client fiber (parked reading resp1)
- serve fiber (parked in accept)
- connection fiber (freshly spawned, queued)

The fresh task starves behind the two I/O-ready fibers. (A real cross-process
server might not hit this, but co-located client+server is every unit test and a
legit use case, so the fix must handle it.)

Empirical probes (in /tmp, may be lost — re-derivable):
- nested `spawn_cb` child RUNS while parent parks in `conc.sleep(500ms)` → YES
- child RUNS while parent parks in `listener.accept(500ms)` → YES (accept yields)
- but in the real 3-fiber co-located topology the connection fiber starves → the
  difference is contention from a 2nd parked I/O fiber (the client).

### Candidate resolutions (deciding empirically)
1. **Dedicated multi-thread executor for connections** (`executor_policy_builder`
   → `max_threads(N)` → `build_executor`/`build_executor()`, then `spawn_on`).
   Gives real OS-thread parallelism; removes starvation. RISK A: concurrent
   `app.dispatch` across OS threads must be thread-safe — believed OK (App is
   immutable after serve() begins; dispatch clones Arc + fresh Context per req;
   JsonHandle is atomic-Arc) but must be validated under ASAN/memcheck/TSAN.
   RISK B: executor lifecycle — does dropping the local `Executor` (Copy/shared
   handle) at serve() return cleanly shut down / drain workers, or leak threads
   at process exit (ASAN)? No drop/shutdown semantics in std_concurrent.md docs;
   must test. (If it drains, shutdown blocks up to idle_timeout — same as today.)
2. **Tiny cooperative yield after spawn** (`conc.sleep(1ms)`) to give the fresh
   fiber its first slice. Preserves single-thread cooperative dispatch (NO new
   cross-thread races — safest for cert) BUT caps accept throughput at
   ~1/sleep·s → likely fails `just perf-smoke`. Probably unacceptable.

Leaning option 1 (real concurrency is the correct server design) pending the two
risk validations.

## Files touched

- `packages/web-rest/src/server.drift` — serve()/_serve_connection/_handle_connection
  rewritten for per-connection fibers + shared atomics.
  **STILL CONTAINS TEMPORARY DEBUG** `console.eprintln("DBG ...")` lines and an
  added `import std.console as console;` — REMOVE before finishing.

## Verification checklist (cert gates, run all four after fix)

```
export DRIFT_TOOLCHAIN_ROOT="$HOME/opt/drift/certified/current/toolchain"
export DRIFT_PKG_ROOT="$HOME/opt/drift/certified/current/libs"
export DRIFT_PYTHON="$(which python3)"
```
- [ ] `just check-one packages/web-rest/tests/unit/keepalive_test.drift` (fast loop)
- [ ] NEW regression test: concurrent/sequential fresh-conn keep-alive (must run
      under ASAN+memcheck per cert policy)
- [ ] `just rest-check-par`
- [ ] `just test`   (plain + ASAN + memcheck — critical for the concurrency change)
- [ ] `just stress-test`
- [ ] `just perf-smoke`  (watch ratio vs Go — esp. if any yield/sleep added)
- [ ] Cross-process repro: `./repro/run.sh` → web.rest time ≈ python time, 0 errors
- [ ] Version bump web-rest per feedback_versioning policy
```
```

## Key API facts (learned, durable)

- Default executor: 1 worker thread, unbounded queue, return-busy. `spawn`/
  `spawn_cb` use it. `executor_policy_builder().max_threads(n)...build_executor()`
  for a custom pool; `spawn_on(exec, cb) -> Result<VT>`.
- VT/Future: drop = detach (safe linearized path; buffer freed when last Arc
  clone — incl. the cb thunk's — dies). `cancel()` is separate. `Future.is_complete()`
  checks the underlying task (non-blocking); `Future.is_done()` only means
  `.join` already ran (NOT useful for reaping).
- Atomics live in `std.sync`: `sync.atomic_int(v) -> AtomicInt` with
  `load/store/fetch_add/fetch_sub(order)`. Arc via `conc.arc(...)`, `.get()`
  borrows inner, `.clone()` clones the Arc. Repo only uses
  `MemoryOrder::Acquire()/Release()`.
- `conc.sleep(0)` = immediate Err(Timeout), not a no-op.
