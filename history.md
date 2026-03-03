# History

## 2026-02-26

- Initialized project history tracking.
- Added JWT design and usage guidance:
  - `docs/jwt-webtoken-design.md`
  - `docs/effective-web-jwt.md`
- Added initial `web-jwt` package skeleton and unit test suite.
- Completed `work/initial/plan.md` for `web.jwt` MVP.
- Resolved initial review blockers:
  - Drift const-literal compatibility for public JWT tag constants.
  - Strict-first verify behavior for missing `typ` when `require_typ_jwt=true`.
  - Temporal-claim arithmetic hardening with bounded timestamp clamping and typed `Optional` inference fix.
- Validation:
  - `just jwt-check-par` passed (5/5 unit tests).
- Added REST UX-first artifacts:
  - `docs/effective-web-rest.md`
  - `work/rest/plan.md`
  - `work/rest/progress.md`
- Delivered REST acceptance-test skeleton and minimal story-driven `web-rest` surface:
  - `packages/web-rest/src/{lib,errors,response,context,request,jwt_guard}.drift`
  - REST unit tests: `health_test`, `jwt_guard_test`, `validation_test`, `repro_array_push_struct_field`
- Validation:
  - `just test` passed (JWT unit + JWT e2e + REST unit suite).

## 2026-03-01

- Completed `web.rest` MVP internal machinery:
  - typed REST events in `packages/web-rest/src/events.drift`
  - router + `{name}` path parameter support in `packages/web-rest/src/router.drift`
  - builder, middleware chain, and dispatch pipeline in `packages/web-rest/src/app.drift`
- Aligned callback contracts back to the pinned plan:
  - callbacks use `(&Request, &mut Context)`
  - internal dispatch keeps framework-owned request mutation before shared callback reborrow
- Added HTTP listener integration:
  - HTTP parsing/serialization in `packages/web-rest/src/http.drift`
  - TCP listener/serve loop in `packages/web-rest/src/server.drift`
  - shared cross-VT stop lifecycle via `Arc<AtomicBool>`
- Expanded REST test coverage:
  - `dispatch_test`
  - `http_test`
  - `server_test`
- Fixed HTTP-path issues discovered in review:
  - query string split/parsing before routing
  - incomplete/truncated request body rejection
  - integration tests now exercise the real `listen_app()` / `serve()` / `stop()` lifecycle
- Pinned and reported a compiler defect:
  - `CORE_BUG`: Arc-in-struct field borrow via `.get()` suppressed destructor emission and leaked the Arc backing allocation
  - Added repro: `packages/web-rest/tests/unit/repro_arc_struct_drop.drift`
  - Added bug note: `work/rest/CORE_BUG-arc-struct-field-drop-leak.md`
- Upstream compiler issues were fixed and the project validated cleanly afterward.
- Validation:
  - `just rest-check-par` passed
  - `just test` passed

## 2026-03-03

- Completed REST stress and correctness coverage:
  - added `packages/web-rest/tests/stress/stress_test.drift`
  - covered sequential mixed requests, concurrent clients, lifecycle cycling, large headers, malformed requests, slow clients, large responses, and keep-alive sustained load
- Added HTTP/1.1 keep-alive support to `web.rest`:
  - persistent per-connection request loop in `packages/web-rest/src/server.drift`
  - remainder-preserving buffered request reader in `packages/web-rest/src/http.drift`
  - `Connection: keep-alive` default response behavior with client `Connection: close` opt-out
  - idle keep-alive timeout and short-write-safe response flushing
- Added a VT-first public server lifecycle API:
  - `start()`
  - `server_port()`
  - `shutdown()`
  - low-level server primitives were demoted from the `web.rest` facade and retained under `web.rest.server`
- Expanded performance investigation and harnesses:
  - added perf baselines and decomposition tests under `packages/web-rest/tests/perf/`
  - corrected benchmark methodology to avoid main-thread I/O polling distortion by running client/server on virtual threads
  - established credible keep-alive baseline throughput for `web.rest`
- Pinned and documented the performance false alarm root cause:
  - main-thread socket I/O in current Drift runtime polls at a 10ms quantum
  - reports added under `work/rest/` for VT loopback baseline, allocation bottleneck analysis, and main-thread poll behavior
- Validation:
  - `just test` passed
  - `just rest-stress` passed
  - `just rest-perf` passed
