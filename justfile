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
# Per-pass compile parallelism defaults to nproc/3 to avoid triple-stacking
# the compile storm; override via DRIFT_TEST_JOBS.
# perf and stress gates stay serial — see their recipes.
test: _require-env lock-check
    #!/usr/bin/env bash
    set -uo pipefail
    : "${DRIFT_TEST_JOBS:=$(( $(nproc) / 3 ))}"
    export DRIFT_TEST_JOBS
    LOG_DIR="$(mktemp -d -t drift-web-test-XXXXXX)"
    trap 'rm -rf "${LOG_DIR}"' EXIT
    echo "=== test: plain + asan + memcheck concurrent (DRIFT_TEST_JOBS=${DRIFT_TEST_JOBS} per pass, logs in ${LOG_DIR}) ==="
    ( just _test-suite                    > "${LOG_DIR}/plain.log"    2>&1 ) & pid_plain=$!
    ( DRIFT_ASAN=1     just _test-suite   > "${LOG_DIR}/asan.log"     2>&1 ) & pid_asan=$!
    ( DRIFT_MEMCHECK=1 just _test-suite   > "${LOG_DIR}/memcheck.log" 2>&1 ) & pid_memcheck=$!
    status=0
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
    report plain    "${pid_plain}"
    report asan     "${pid_asan}"
    report memcheck "${pid_memcheck}"
    exit "${status}"

# Internal: full test suite (single pass).
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
stress: _require-env lock-check
    #!/usr/bin/env bash
    set -euo pipefail
    echo "=== scenario A: REST concurrency/state stress ==="
    just _stress-rest
    echo "=== scenario A: PASS ==="
    echo ""
    just _stress-client
    echo ""
    echo "=== all stress scenarios complete ==="

# Internal: REST server stress (scenario A).
_stress-rest:
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift/manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/stress/stress_test.drift \
      --target-word-bits 64

# Internal: Client TLS/pool stress (scenarios B + C).
_stress-client:
    @tools/run-stress-client.sh

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

# Prepare lockfile (resolve dependencies against package root).
prepare: _require-env
    @tools/check-manifest-consistency.sh
    {{DRIFT}} prepare --dest "${DRIFT_PKG_ROOT:?set DRIFT_PKG_ROOT to the package root}"

# Deploy to staging (build, sign, smoke, publish).
deploy *ARGS: _require-env lock-check
    {{DRIFT}} deploy --dest "${DRIFT_PKG_ROOT:?set DRIFT_PKG_ROOT to the package root}" --driftc "${DRIFTC}" {{ARGS}}

# Show driftc version info.
driftc-help: _require-env
    @${DRIFTC} --help 2>&1 | head -5 || true
