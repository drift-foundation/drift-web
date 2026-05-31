# Toolchain resolution from DRIFT_TOOLCHAIN_ROOT.
# All recipes resolve tools from $DRIFT_TOOLCHAIN_ROOT/bin/{driftc,drift}.
# _require-env enforces this at gate entry.
export DRIFTC := env("DRIFT_TOOLCHAIN_ROOT", "") / "bin" / "driftc"
export DRIFT  := env("DRIFT_TOOLCHAIN_ROOT", "") / "bin" / "drift"

PKG_ROOT := env("DRIFT_PKG_ROOT", env("DRIFT_PACKAGE_ROOT", ""))

# Guard: all recipes require DRIFT_TOOLCHAIN_ROOT and DRIFT_PKG_ROOT.
_require-env:
    #!/usr/bin/env bash
    fail=0
    if [[ -z "${DRIFT_TOOLCHAIN_ROOT:-}" ]]; then
        echo "error: DRIFT_TOOLCHAIN_ROOT is required" >&2
        fail=1
    fi
    if [[ -z "${DRIFT_PKG_ROOT:-}" ]]; then
        echo "error: DRIFT_PKG_ROOT is required" >&2
        fail=1
    fi
    if [[ "${fail}" -ne 0 ]]; then
        echo "  example:" >&2
        echo "    export DRIFT_TOOLCHAIN_ROOT=\$HOME/opt/drift/certified/current/toolchain/current" >&2
        echo "    export DRIFT_PKG_ROOT=\$HOME/opt/drift/certified/current/libs" >&2
        exit 1
    fi

# Lock guard: fail fast if drift/lock.json is stale vs manifest + package roots.
# Runs before every cert gate so a forgotten `drift prepare` can't drift silently.
lock-check: _require-env
    @{{DRIFT}} prepare --check --package-root "${DRIFT_PKG_ROOT}"

# Certification gate: correctness + safety instrumentation.
# Plain, ASAN, and memcheck passes run concurrently (32GB RAM headroom).
#   DRIFT_TEST_JOBS is a GLOBAL compile-slot count: the runner wraps each
#   driftc invocation with the toolchain's `flocker --key drift-jobs -j N`,
#   so all 3 lanes share one N-slot pool on this host. Total concurrent
#   driftc processes are bounded by DRIFT_TEST_JOBS regardless of lane count,
#   preventing OOM cascades (driftc 0.32.x peaks ~500-800 MB RSS per process).
#   Defaults to nproc/2 (16 on a 32-core box → ~11 GB peak compile RAM with
#   headroom for memcheck/valgrind). Override via env.
# perf and stress gates stay serial — see their recipes.
# Two-phase split: compile every test ONCE per distinct binary variant, then
# run the instrumentation lanes against the prebuilt binaries.
#
#   Phase 1 (compile, the ~99%-of-wall-clock part): build the plain and asan
#     variants concurrently. memcheck reuses the PLAIN binaries — only ASAN is a
#     distinct binary (built with `driftc --sanitize=address`, which also selects
#     the matching asan runtime archive), so building 2 variants instead of 3
#     removes ~1/3 of all driftc work. Both compile lanes share the one
#     DRIFT_TEST_JOBS flocker slot pool, same global cap as before.
#   Phase 2 (run, cheap — no driftc): plain/memcheck/asan run concurrently, also
#     bounded by the shared flocker pool. plain + memcheck both execute the plain
#     binaries (memcheck under valgrind); asan executes the asan binaries.
#
# Watchdog: a single `flocker --heartbeat` monitor feeds the orch ≤60s
# stdout-inactivity contract — the blessed mechanism, not a hand-rolled loop.
#
# client-https-e2e and consumer-check don't fit the prebuilt model (inline /
# published-artifact compiles) and keep their prior per-lane behavior.
test: _require-env lock-check
    #!/usr/bin/env bash
    set -uo pipefail
    : "${DRIFT_TEST_JOBS:=$(( $(nproc) / 2 ))}"
    export DRIFT_TEST_JOBS
    LOG_DIR="$(mktemp -d -t drift-web-test-XXXXXX)"
    BIN_CACHE="$(mktemp -d -t drift-web-bincache-XXXXXX)"
    export DRIFT_BIN_CACHE="${BIN_CACHE}"
    HB_PID=""
    status=0
    cleanup() {
        [[ -n "${HB_PID}" ]] && kill "${HB_PID}" 2>/dev/null
        rm -rf "${LOG_DIR}" "${BIN_CACHE}"
    }
    trap cleanup EXIT
    # Watchdog heartbeat via flocker's own --heartbeat (driftc 0.33.12+ toolchain),
    # not a hand-rolled sleep loop. One monitor on a DEDICATED key (so it never
    # consumes a drift-jobs compile/run slot) emits a liveness line to the gate's
    # stdout every 20s — comfortably under the orch's ≤60s contract — and covers
    # the whole run incl. the silent compile + memcheck stretches. flocker
    # forwards SIGTERM, so cleanup's kill tears it down and releases the slot.
    FLOCKER="${DRIFT_TOOLCHAIN_ROOT}/bin/flocker"
    if [[ -x "${FLOCKER}" ]]; then
        "${FLOCKER}" -k drift-web-hb -j 1 --heartbeat 20 -- sleep 86400 & HB_PID=$!
    else
        echo "warning: ${FLOCKER} not found — running without watchdog heartbeat" >&2
    fi
    report() {
        local name="$1" pid="$2"
        if wait "${pid}"; then
            echo "=== ${name} — PASS ==="
        else
            echo "=== ${name} — FAIL ==="
            sed 's/^/['"${name}"'] /' "${LOG_DIR}/${name}.log"
            status=1
        fi
    }

    echo "=== phase 1: compile plain + asan (DRIFT_TEST_JOBS=${DRIFT_TEST_JOBS} global flocker slots, cache ${BIN_CACHE}, logs ${LOG_DIR}) ==="
    ( just _compile-suite plain > "${LOG_DIR}/compile-plain.log" 2>&1 ) & pid_cp=$!
    ( just _compile-suite asan  > "${LOG_DIR}/compile-asan.log"  2>&1 ) & pid_ca=$!
    report compile-plain "${pid_cp}"
    report compile-asan  "${pid_ca}"
    if [[ "${status}" -ne 0 ]]; then
        echo "=== phase 1 (compile) FAILED — skipping run phase ==="
        exit 1
    fi

    echo "=== phase 2: run plain + memcheck + asan concurrent (prebuilt binaries, no driftc) ==="
    ( just _run-suite plain    > "${LOG_DIR}/plain.log"    2>&1 ) & pid_plain=$!
    ( just _run-suite memcheck > "${LOG_DIR}/memcheck.log" 2>&1 ) & pid_memcheck=$!
    ( just _run-suite asan     > "${LOG_DIR}/asan.log"     2>&1 ) & pid_asan=$!
    report plain    "${pid_plain}"
    report asan     "${pid_asan}"
    report memcheck "${pid_memcheck}"
    exit "${status}"

# Internal: compile all unit/e2e test roots into the shared binary cache for one
# variant. VARIANT in {plain, asan}; asan adds `--sanitize=address` (driftc
# 0.33.12+), which instruments AND selects the matching asan runtime archive —
# no DRIFT_ASAN env. No run.
_compile-suite VARIANT: _require-env
    #!/usr/bin/env bash
    set -euo pipefail
    source tools/web_test_roots.sh
    SAN=()
    case "{{VARIANT}}" in
        plain) ;;
        asan)  SAN=(--sanitize address) ;;
        *) echo "error: unknown variant '{{VARIANT}}'" >&2; exit 2 ;;
    esac
    while IFS=$'\t' read -r ART ROOT EXTRA; do
        [[ -n "${ROOT}" ]] || continue
        out="${DRIFT_BIN_CACHE}/$(web_test_root_key "${ROOT}")-{{VARIANT}}"
        tools/drift_test_parallel_runner.sh build-all \
          --manifest drift/manifest.json --artifact "${ART}" \
          --test-root "${ROOT}" ${EXTRA} "${SAN[@]}" \
          --target-word-bits 64 --out-dir "${out}"
    done < <(web_test_roots)

# Internal: run one instrumentation lane against the prebuilt binary cache.
# LANE in {plain, memcheck, asan}. plain + memcheck read the plain binaries
# (memcheck wraps valgrind); asan reads the asan binaries.
_run-suite LANE: _require-env
    #!/usr/bin/env bash
    set -euo pipefail
    source tools/web_test_roots.sh
    case "{{LANE}}" in
        plain)    binvar=plain ;;
        memcheck) binvar=plain; export DRIFT_MEMCHECK=1 ;;
        # asan binaries are built with --sanitize=address; at run time libasan
        # only needs its options (no DRIFT_ASAN — that was the old compile knob).
        asan)     binvar=asan;  export ASAN_OPTIONS="${ASAN_OPTIONS:-detect_leaks=0:halt_on_error=1}" ;;
        *) echo "error: unknown lane '{{LANE}}'" >&2; exit 2 ;;
    esac
    while IFS=$'\t' read -r ART ROOT EXTRA; do
        [[ -n "${ROOT}" ]] || continue
        out="${DRIFT_BIN_CACHE}/$(web_test_root_key "${ROOT}")-${binvar}"
        tools/drift_test_parallel_runner.sh run-prebuilt \
          --test-root "${ROOT}" --target-word-bits 64 --out-dir "${out}"
    done < <(web_test_roots)
    # Non-prebuilt suites keep their prior per-lane behavior (they compile
    # inline / against published artifacts; they inherit the lane's DRIFT_*).
    just client-https-e2e
    just consumer-check

# Internal: full test suite, single lane, compile+run interleaved per root.
# Retained for ad-hoc single-lane runs; `just test` uses the two-phase split.
_test-suite:
    @just jwt-check-par
    @just jwt-e2e-par
    @just rest-check-par
    @just rest-e2e-par
    @just client-check-par
    @just client-e2e-par
    @just client-https-e2e
    @just consumer-check

# All JWT unit tests (parallel compile, serial run).
jwt-check-par: _require-env
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift/manifest.json --artifact web-jwt \
      --test-root packages/web-jwt/tests/unit \
      --target-word-bits 64

# Single JWT unit test.
jwt-check-unit FILE: _require-env
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-jwt \
      --test-file "{{FILE}}" \
      --target-word-bits 64

# JWT e2e-style tests (no external services).
jwt-e2e-par: _require-env
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift/manifest.json --artifact web-jwt \
      --test-root packages/web-jwt/tests/e2e \
      --target-word-bits 64

# Compile-only check (no execution).
jwt-compile-check FILE="packages/web-jwt/src/lib.drift": _require-env
    @tools/drift_test_parallel_runner.sh compile \
      --manifest drift/manifest.json --artifact web-jwt \
      --file "{{FILE}}" \
      --target-word-bits 64

# Compile all unit tests without running.
jwt-compile-check-par: _require-env
    @tools/drift_test_parallel_runner.sh compile \
      --manifest drift/manifest.json --artifact web-jwt \
      --test-root packages/web-jwt/tests/unit \
      --target-word-bits 64

# All REST unit tests (parallel compile, serial run).
rest-check-par: _require-env
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift/manifest.json --artifact web-rest \
      --test-root packages/web-rest/tests/unit \
      --target-word-bits 64

# REST e2e tests (startup path, integration-level coverage).
rest-e2e-par: _require-env
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift/manifest.json --artifact web-rest \
      --test-root packages/web-rest/tests/e2e \
      --target-word-bits 64

# Single REST unit test.
rest-check-unit FILE: _require-env
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-rest \
      --test-file "{{FILE}}" \
      --target-word-bits 64

# Certification gate: stability/state stress shaped around real defect classes.
# Scenario A: REST concurrency/state (concurrent clients, mixed request types,
#             guards, JSON caching, keep-alive, malformed recovery, lifecycle).
# Scenario B: Client TLS negative-path → valid-path contamination.
# Scenario C: Pool reuse / stale-connection / forced-reconnect stress.
#
# Follows docs/certifiable-test-gates.md: a parallel COMPILE phase builds all
# three scenario binaries at once (flocker pool), then a RUN phase where A
# (independent REST server) runs in PARALLEL with the B→C chain, while B and C
# (which share one HTTPS server) run SERIALLY on that exclusive resource.
stress: _require-env lock-check
    #!/usr/bin/env bash
    set -uo pipefail
    : "${DRIFT_TEST_JOBS:=$(( $(nproc) / 2 ))}"
    export DRIFT_TEST_JOBS
    WORK="$(mktemp -d -t drift-web-stress-XXXXXX)"
    LOG="${WORK}/logs"; mkdir -p "${LOG}"
    HB_PID=""; status=0
    cleanup() {
        [[ -n "${HB_PID}" ]] && kill "${HB_PID}" 2>/dev/null
        if [[ -n "${WORK:-}" && "${WORK}" == */drift-web-stress-* && -d "${WORK}" ]]; then rm -rf "${WORK}"; fi
    }
    trap cleanup EXIT
    FLOCKER="${DRIFT_TOOLCHAIN_ROOT}/bin/flocker"
    [[ -x "${FLOCKER}" ]] && { "${FLOCKER}" -k drift-web-hb -j 1 --heartbeat 20 -- sleep 86400 & HB_PID=$!; }
    report() {
        local name="$1" pid="$2" log="$3"
        if wait "${pid}"; then echo "=== ${name} — PASS ==="
        else echo "=== ${name} — FAIL ==="; sed 's/^/['"${name}"'] /' "${log}"; status=1; fi
    }

    echo "=== stress phase 1: compile all scenario binaries (parallel, flocker pool) ==="
    ( tools/drift_test_parallel_runner.sh build-all --manifest drift/manifest.json --artifact web-rest \
        --test-root packages/web-rest/tests/stress --target-word-bits 64 --out-dir "${WORK}/rest" \
        > "${LOG}/compile-rest.log" 2>&1 ) & c_rest=$!
    ( tools/drift_test_parallel_runner.sh build-all --manifest drift/manifest.json --artifact web-client \
        --test-root packages/web-client/tests/stress --package-root {{PKG_ROOT}} --target-word-bits 64 --out-dir "${WORK}/client" \
        > "${LOG}/compile-client.log" 2>&1 ) & c_client=$!
    report compile-rest   "${c_rest}"   "${LOG}/compile-rest.log"
    report compile-client "${c_client}" "${LOG}/compile-client.log"
    if [[ "${status}" -ne 0 ]]; then echo "=== stress compile FAILED — skipping run phase ==="; exit 1; fi

    echo "=== stress phase 2: run (A ∥ B→C) ==="
    # Scenario A: REST concurrency/state stress — independent resource, parallel.
    ( tools/drift_test_parallel_runner.sh run-prebuilt --test-root packages/web-rest/tests/stress \
        --target-word-bits 64 --out-dir "${WORK}/rest" > "${LOG}/run-A.log" 2>&1 ) & r_a=$!
    # Scenarios B,C: client TLS/pool stress — share one HTTPS server, run serially.
    ( tools/run-stress-client.sh "${WORK}/client/bins" > "${LOG}/run-BC.log" 2>&1 ) & r_bc=$!
    report stress-A-rest    "${r_a}"  "${LOG}/run-A.log"
    report stress-BC-client "${r_bc}" "${LOG}/run-BC.log"
    [[ "${status}" -eq 0 ]] && echo "=== all stress scenarios complete ==="
    exit "${status}"

# Certification gate: performance anomaly detection.
# Machine-keyed pass/fail against baselines in perf-baselines.json.
# Requires: go in PATH, DRIFT_TOOLCHAIN_ROOT set, DRIFT_PYTHON set, jq.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
perf: _require-env
    @tools/perf_gate_runner.sh

# Performance smoke (informational, hardcoded thresholds).
perf-smoke: _require-env lock-check
    @tools/perf_smoke_runner.sh

# Build perf binary to a stable path for strace/perf profiling.
perf-build: _require-env
    @mkdir -p work/rest/bench/bin
    @tools/drift_test_parallel_runner.sh compile \
      --manifest drift/manifest.json --artifact web-rest \
      --file packages/web-rest/tests/perf/perf_test.drift \
      --target-word-bits 64
    @"${DRIFTC}" --target-word-bits 64 \
      --entry "web.rest.tests.perf.perf_test::main" \
      packages/web-jwt/src/*.drift packages/web-rest/src/*.drift \
      packages/web-rest/tests/perf/perf_test.drift \
      -o work/rest/bench/bin/perf_test
    @echo "Binary: work/rest/bench/bin/perf_test"

# Performance benchmarks: Go + Drift side-by-side.
# Runs Go raw-TCP, Go net/http, Drift raw-TCP, Drift REST.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
perf-test: _require-env
    @echo "=== Go baselines ==="
    @go run benchmarks/go/raw_tcp_bench.go
    @go run benchmarks/go/net_http_bench.go
    @echo ""
    @echo "=== Drift ==="
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/perf_test.drift \
      --target-word-bits 64
# Raw TCP with TCP_NODELAY — compare against baseline-vt in perf-test.
perf-nodelay: _require-env
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/nodelay_test.drift \
      --target-word-bits 64

# REST probes: timeout sensitivity, read-call count, raw ping-pong.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
rest-probe: _require-env
    tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/probe_test.drift \
      --target-word-bits 64

# REST instrumented keep-alive: per-phase server + client timing.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
rest-instrument: _require-env
    tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/instrument_test.drift \
      --target-word-bits 64

# REST decomposition benchmarks: parse, dispatch, serialize isolation.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
rest-decompose: _require-env
    tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/decompose_test.drift \
      --target-word-bits 64

# Compile-only check for REST (no execution).
rest-compile-check FILE="packages/web-rest/src/lib.drift": _require-env
    @tools/drift_test_parallel_runner.sh compile \
      --manifest drift/manifest.json --artifact web-rest \
      --file "{{FILE}}" \
      --target-word-bits 64

# All client unit tests (parallel compile, serial run).
client-check-par: _require-env
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift/manifest.json --artifact web-client \
      --test-root packages/web-client/tests/unit \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Single client unit test.
client-check-unit FILE: _require-env
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-client \
      --test-file "{{FILE}}" \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Client e2e tests (HTTP + HTTPS against local servers).
client-e2e-par: _require-env
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift/manifest.json --artifact web-client \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-root packages/web-client/tests/e2e \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Single client e2e test.
client-e2e-unit FILE: _require-env
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-client \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file "{{FILE}}" \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Client pool perf benchmark.
client-perf: _require-env
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-client \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-client/tests/perf/pool_perf_test.drift \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Client HTTPS e2e test (local Python HTTPS server + net-tls).
client-https-e2e: _require-env
	#!/usr/bin/env bash
	set -euo pipefail
	TMPDIR="$(mktemp -d)"
	trap 'rm -rf "${TMPDIR}"' EXIT
	# Compile test binary.
	"${DRIFTC}" --target-word-bits 64 \
	  --package-root {{PKG_ROOT}} \
	  --dep "net-tls@$(jq -r '.artifacts["web-client"].resolved["net-tls"].version' drift/lock.json)" \
	  --entry "web.client.tests.https.https_e2e_test::main" \
	  packages/web-jwt/src/*.drift packages/web-rest/src/*.drift packages/web-client/src/*.drift \
	  packages/web-client/tests/https/https_e2e_test.drift \
	  -o "${TMPDIR}/https_e2e_test"
	# Run with HTTPS test server.
	packages/web-client/tools/run-https-e2e.sh "${TMPDIR}/https_e2e_test"

# Consumer-path package tests: compile + run against published .zdmp artifacts.
consumer-check: _require-env
    @tools/run-consumer-tests.sh

# Compile-only check for client (no execution).
client-compile-check FILE="packages/web-client/src/lib.drift": _require-env
    @tools/drift_test_parallel_runner.sh compile \
      --manifest drift/manifest.json --artifact web-client \
      --package-root {{PKG_ROOT}} \
      --file "{{FILE}}" \
      --target-word-bits 64

# Build package artifact locally (manifest-driven).
build ARTIFACT="": _require-env
    {{DRIFT}} build {{ARTIFACT}} --driftc "${DRIFTC}"

# Re-mint drift/<artifact>.author-claim under the Foundation author key against
# the current manifest. Run after any source change that affects an artifact's
# SCI (version, modules, assets, deps). The author-claim is committed alongside
# source; the cert-claim is emitted by the orchestrator at certification time
# and is NOT committed.
#
# With no ARTIFACT, mints all four drift-web artifacts. Pass a single artifact
# name to limit the mint to that one (avoids signature churn on unchanged
# claims when only one version was bumped).
#
# Overrides:
#   DRIFT_LANG_ROOT      — drift-lang checkout providing tools.drift_author
#                          (default: $HOME/src/drift-lang).
#   DRIFT_SIGN_KEY_FILE  — ed25519 seed used as the author key
#                          (default: $HOME/.config/drift/keys/default.seed).
author-claim ARTIFACT="":
    #!/usr/bin/env bash
    set -euo pipefail
    DRIFT_LANG_ROOT="${DRIFT_LANG_ROOT:-${HOME}/src/drift-lang}"
    KEY_FILE="${DRIFT_SIGN_KEY_FILE:-${HOME}/.config/drift/keys/default.seed}"
    [[ -d "${DRIFT_LANG_ROOT}/tools/drift_author" ]] || { echo "error: tools.drift_author not found at ${DRIFT_LANG_ROOT}" >&2; exit 1; }
    [[ -f "${KEY_FILE}" ]] || { echo "error: signing key not found: ${KEY_FILE}" >&2; exit 1; }
    if [[ -n "{{ARTIFACT}}" ]]; then
        ARTS=("{{ARTIFACT}}")
    else
        ARTS=(web-jwt web-rest web-client or-throw-probe)
    fi
    for ART in "${ARTS[@]}"; do
        echo "[author-claim] minting drift/${ART}.author-claim"
        PYTHONPATH="${DRIFT_LANG_ROOT}" python3 -m tools.drift_author publish \
            --manifest "$(pwd)/drift/manifest.json" \
            --artifact "${ART}" \
            --key-file "${KEY_FILE}" \
            --overwrite
    done

# Prepare lockfile (resolve dependencies against package root).
prepare: _require-env
    @tools/check-manifest-consistency.sh
    {{DRIFT}} prepare --dest "${DRIFT_PKG_ROOT:?set DRIFT_PKG_ROOT to the package root}"

# Deploy to staging (build, sign, smoke, publish).
# Local dev default: --cert-suite-id drift-web/dev --cert-suite-no-evidence.
# Orchestrated certification must override --cert-suite-id (and bind real
# evidence via --cert-suite-evidence-sha256) — these flags only set a local
# fallback for ad-hoc deploys.
deploy *ARGS: _require-env lock-check
    {{DRIFT}} deploy --dest "${DRIFT_PKG_ROOT:?set DRIFT_PKG_ROOT to the package root}" --driftc "${DRIFTC}" --cert-suite-id drift-web/dev --cert-suite-no-evidence {{ARGS}}

# Read-only trust preflight: validates author-claims, SCI equality, and trust
# grants against drift/manifest.json (what `drift deploy` checks). Run it to
# confirm the repo is deploy-ready without actually deploying.
trust-check: _require-env
    @{{DRIFT}} trust check

# Author ceremony for a version bump: re-mint author-claims, re-resolve the
# lockfile, then trust-check. Run this after bumping a version (or any source
# change that affects SCI) and before committing.
#
# Both steps are safe to over-run: `prepare` is a no-op when deps are unchanged
# and `author-claim --overwrite` is deterministic for an unchanged artifact, so
# reseal removes the guesswork. With no ARTIFACT it re-mints all four artifacts;
# pass one to limit the mint (avoids signature churn on unchanged claims).
# reseal does not test — run `just test` separately first.
reseal ARTIFACT="":
    @just author-claim {{ARTIFACT}}
    @just prepare
    @just trust-check
    @echo "[reseal] done — review & commit: drift/manifest.json, drift/lock.json, drift/*.author-claim"

# Show driftc version info.
driftc-help: _require-env
    @${DRIFTC} --help 2>&1 | head -5 || true
