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
- Added same-hardware comparison baselines against Go:
  - raw TCP control
  - minimal `net/http` keep-alive health path
- Re-ran Drift baselines with optimized toolchain/runtime support:
  - optimized raw TCP baseline improved materially over dev build
  - optimized `web.rest` keep-alive health benchmark outperformed Go `net/http` on the same machine/workload
  - framework overhead was pinned to a small per-request cost above the Drift raw TCP floor
- Added staged performance protection:
  - ratio-based `perf-smoke` guard against same-run Go baselines
  - guard uses optimized Drift baselines plus Go reference baselines on the same machine
  - shell orchestration passes Go baseline values into Drift via `std.env`
  - guard remains separate from default correctness suites
- Pinned and documented the performance false alarm root cause:
  - main-thread socket I/O in current Drift runtime polls at a 10ms quantum
  - reports added under `work/rest/` for VT loopback baseline, allocation bottleneck analysis, and main-thread poll behavior
- Validation:
  - `just test` passed
  - `just rest-stress` passed
  - `just rest-perf` passed

## 2026-03-10

- Completed `web.rest` UX Pass 2 request parsing and validation layer:
  - JSON field extraction helpers in `packages/web-rest/src/json_extract.drift`
  - source-agnostic validators in `packages/web-rest/src/validators.drift`
  - validation collector in `packages/web-rest/src/validation_collector.drift`
- Converted REST UX contract tests into real acceptance coverage:
  - stories 1-5 and 7 in `packages/web-rest/tests/unit/ux_pass2_test.drift`
  - focused helper coverage in `json_extract_test`, `validators_test`, and `validation_collector_test`
- Adopted additive shared JSON for request bodies:
  - `body_json(req)` now returns `std.json.JsonHandle`
  - `JsonHandle` is re-exported from `web.rest`
  - public callback contracts remain on `&Request`
- Landed request-body JSON caching on the normal dispatch path:
  - dispatch populates request-scoped cached JSON root handles
  - `body_json(req)` returns cached handles on framework-managed requests
  - direct/manual request usage remains correct but may reparse outside dispatch
  - `cache_body_json()` was removed from the public `web.rest` facade
- Closed the upstream JSON-sharing design loop:
  - reviewed and sent `work/rest-next/shared-json-proposal.md` as the additive shared-JSON direction
  - aligned `web.rest` with delivered `std.json.JsonHandle`
- Validation:
  - `just rest-check-par` passed
  - `just test` passed
  - `just stress-test` passed
  - `just perf-smoke` passed

## 2026-03-15

- Adopted standardized downstream packaging via `drift deploy`:
  - added `drift-package.json` with two published package artifacts:
    - `web-jwt@0.1.0`
    - `web-rest@0.1.0`
  - `web-rest` declares packaged dependency on `web-jwt@0.1.0`
  - added deploy entrypoint in `justfile`
- Aligned published package metadata with actual Drift module namespaces:
  - explicit `module_namespace` for `web.jwt`
  - explicit `module_namespace` for `web.rest`
- Added consumer-facing package docs:
  - `docs/integration.md`
  - refreshed `README.md` for signed package consumption
  - bundled deploy assets for published packages
- Validated real signed-package publish in a shared library root:
  - both packages build, sign, smoke, and publish in a single run
  - publish works alongside unrelated packages such as `net-tls`
  - no shared-root workarounds required after upstream compiler/deploy fixes through `0.27.62`
- Consumer model is now pinned and documented:
  - `driftc 0.27.59+` required initially; shared-root deploy validation completed on `0.27.62`
  - consumers use `--package-root <library-root>` plus exact `--dep web-jwt@0.1.0` / `--dep web-rest@0.1.0`

## 2026-03-17

- Advanced `web.client` to a session-first outbound HTTP/HTTPS client:
  - `Session` is now the primary public client abstraction
  - Arc-backed shared session state landed in `packages/web-client/src/session.drift`
  - one-shot request sending was retained only as secondary `send_once(...)` sugar
- Added first-pass session-backed cookie support to `web.client`:
  - `Set-Cookie` parsing and storage in `packages/web-client/src/cookie.drift`
  - host-only, domain, path, `Secure`, overwrite, and `Max-Age=0` handling
  - integrated request/response cookie flow through the session send path
- Tightened session concurrency shape after upstream stdlib fixes:
  - restored `&Session` public API once `Mutex.lock(&self)` became available in Drift `0.27.68`
  - reduced cookie locking scope so request I/O no longer holds a session-wide lock
- Added supporting REST response-header support for cookie e2e coverage:
  - `with_response_header(...)` on `web.rest.Response`
  - HTTP response serialization now emits custom response headers
- Expanded client validation:
  - session-first HTTP and HTTPS e2e coverage
  - integrated cookie e2e coverage for roundtrip, secure-on-HTTP rejection, path scoping, overwrite, deletion, and host/domain safety cases
- Downstream TLS/package floor advanced:
  - `net-tls@0.3.2` is the pinned external TLS dependency for `web-client`
  - recommended minimum downstream Drift toolchain is now `0.27.71` / runtime ABI `6`
  - `net-tls` consumption uses compressed signed package artifacts (`.zdmp` + `.sig`) under the standard package-root flow
- Bumped published `drift-web` package versions to `0.2.1`:
  - `web-jwt@0.2.1`
  - `web-rest@0.2.1`
  - `web-client@0.2.1`

## 2026-03-20

- Added session-backed connection pooling to `web.client`:
  - TCP and TLS pool state in `packages/web-client/src/pool.drift`
  - pooled send/remainder tracking in `packages/web-client/src/transport.drift`
  - session-level pooled request flow in `packages/web-client/src/session.drift`
- Hardened pooling correctness after review:
  - pooled retries are now limited to idempotent methods plus narrow stale-connection signals
  - caller-specified `Connection` headers are preserved without duplicate `Connection: keep-alive` injection
  - cookie/session state remains compatible with pooled request flow
- Expanded client validation:
  - HTTP pool reuse e2e coverage in `packages/web-client/tests/e2e/pool_reuse_test.drift`
  - HTTPS same-session repeated-request validation in `packages/web-client/tests/e2e/https_e2e_test.drift`
  - pooled client perf harness added in `packages/web-client/tests/perf/pool_perf_test.drift`
- Aligned downstream package-root handling with staged certification flows:
  - client `justfile` recipes now read package roots from environment instead of hardcoding `~/opt/drift/libs`
  - resolution order supports staged overrides before falling back to the local interactive default
- Advanced downstream TLS dependency/toolchain alignment:
  - `web-client` now consumes `net-tls@0.3.10`
  - repository/toolchain work tracks current compiler releases through the opaque-pointer and codegen hygiene fixes
- Bumped published `drift-web` package versions to `0.2.7`:
  - `web-jwt@0.2.7`
  - `web-rest@0.2.7`
  - `web-client@0.2.7`

## 2026-03-21

- Standardized `drift-web` around the new public certification surface:
  - `just test` is now the correctness gate and runs the full suite under:
    - plain
    - `DRIFT_ASAN=1`
    - `DRIFT_MEMCHECK=1`
  - `just perf` is now a machine-keyed pass/fail anomaly gate:
    - baselines live in `perf-baselines.json`
    - unknown hosts fail closed
    - baseline sampling is driven by `tools/perf_baseline_sample.sh`
  - `just stress` is now the repo-owned stability/state gate:
    - REST concurrency/state stress via `packages/web-rest/tests/stress/stress_test.drift`
    - TLS negative-path contamination stress via `packages/web-client/tests/stress/tls_contamination_test.drift`
    - stale pooled-connection recovery stress via `packages/web-client/tests/stress/pool_stale_test.drift`
- Hardened the client HTTPS harness and stress tooling:
  - replaced the old bind-close-rebind / fake-READY flow with server-owned `:0` binding and atomic JSON port publication
  - added dedicated client stress harness support in `tools/run-stress-client.sh`
  - added `/health-drop` / forced stale-socket coverage so pool stress now exercises real dead-socket recovery instead of only orderly close handling
- Advanced downstream client/toolchain alignment:
  - `web-client` now consumes `net-tls@0.3.11`
  - current downstream/runtime guidance tracks the `0.27.99` SIGPIPE runtime fix for network failure paths
- Bumped published `drift-web` package versions to `0.2.9`:
  - `web-jwt@0.2.9`
  - `web-rest@0.2.9`
  - `web-client@0.2.9`

- Tightened certification/release toolchain alignment:
  - public certification gates are being aligned to the strict `DRIFT_TOOLCHAIN_ROOT` contract
  - orchestrator-facing flows no longer treat ambient `PATH` as an acceptable source of `drift` / `driftc`
- Advanced downstream TLS dependency again:
  - `web-client` now consumes `net-tls@0.3.13`
- Bumped published `drift-web` package versions to `0.2.10`:
  - `web-jwt@0.2.10`
  - `web-rest@0.2.10`
  - `web-client@0.2.10`

- Strengthened the `web.rest` certification floor with new REST-owned e2e baselines:
  - `packages/web-rest/tests/e2e/startup_test.drift` now pins the minimal `rest.start()` -> `rest.shutdown()` lifecycle
  - `packages/web-rest/tests/e2e/serve_test.drift` now proves the smallest real boot + serve one request + shutdown path
  - both are wired into `just test` via `rest-e2e-par`, so toolchain regressions in the public `rest.start()` path fail certification earlier
- Bumped published `drift-web` package versions to `0.2.11`:
  - `web-jwt@0.2.11`
  - `web-rest@0.2.11`
  - `web-client@0.2.11`

- Added package-consumer regression coverage to the default test surface:
  - `tools/run-consumer-tests.sh` now compiles tiny downstream-style programs against published packages via `--package-root` + `--dep`
  - initial consumer-path coverage includes:
    - `web-jwt` minimal consumer compile
    - `web-rest` startup consumer compile
    - `web-rest` tiny serve consumer compile/run
    - `web-client` minimal consumer compile
  - this closes a missing coverage class where package consumption can fail even when in-repo source-built tests pass
- Bumped published `drift-web` package versions to `0.2.12`:
  - `web-jwt@0.2.12`
  - `web-rest@0.2.12`
  - `web-client@0.2.12`
