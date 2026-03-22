# Toolchain resolution.
# Certification gates (test, stress, perf) require DRIFT_TOOLCHAIN_ROOT.
# Local dev targets fall back to DRIFTC/DRIFT env vars or PATH.
export DRIFTC := `if [ -n "${DRIFT_TOOLCHAIN_ROOT:-}" ]; then echo "${DRIFT_TOOLCHAIN_ROOT}/bin/driftc"; else echo "${DRIFTC:-driftc}"; fi`
export DRIFT  := `if [ -n "${DRIFT_TOOLCHAIN_ROOT:-}" ]; then echo "${DRIFT_TOOLCHAIN_ROOT}/bin/drift"; else echo "${DRIFT:-drift}"; fi`

PKG_ROOT := env("DRIFT_PKG_ROOT", env("DRIFT_PACKAGE_ROOT", "~/opt/drift/libs"))

# Guard: certification gates must have DRIFT_TOOLCHAIN_ROOT set.
_require-toolchain-root:
    #!/usr/bin/env bash
    if [[ -z "${DRIFT_TOOLCHAIN_ROOT:-}" ]]; then
        echo "error: DRIFT_TOOLCHAIN_ROOT is required for certification gates" >&2
        echo "  set it to the toolchain root, e.g.: export DRIFT_TOOLCHAIN_ROOT=\$HOME/opt/drift/current" >&2
        exit 1
    fi

# Certification gate: correctness + safety instrumentation.
# Runs the full suite under plain, ASAN, and memcheck sequentially.
test: _require-toolchain-root
    #!/usr/bin/env bash
    set -euo pipefail
    echo "=== test pass: plain ==="
    just _test-suite
    echo "=== test pass: plain — PASS ==="

    echo "=== test pass: asan ==="
    DRIFT_ASAN=1 just _test-suite
    echo "=== test pass: asan — PASS ==="

    echo "=== test pass: memcheck ==="
    DRIFT_MEMCHECK=1 just _test-suite
    echo "=== test pass: memcheck — PASS ==="

    echo "=== all test passes complete ==="

# Internal: full test suite (single pass).
_test-suite:
    @just jwt-check-par
    @just jwt-e2e-par
    @just rest-check-par
    @just client-check-par
    @just client-e2e-par
    @just client-https-e2e

# All JWT unit tests (parallel compile, serial run).
jwt-check-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift-manifest.json --artifact web-jwt \
      --test-root packages/web-jwt/tests/unit \
      --target-word-bits 64

# Single JWT unit test.
jwt-check-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-jwt \
      --test-file "{{FILE}}" \
      --target-word-bits 64

# JWT e2e-style tests (no external services).
jwt-e2e-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift-manifest.json --artifact web-jwt \
      --test-root packages/web-jwt/tests/e2e \
      --target-word-bits 64

# Compile-only check (no execution).
jwt-compile-check FILE="packages/web-jwt/src/lib.drift":
    @tools/drift_test_parallel_runner.sh compile \
      --manifest drift-manifest.json --artifact web-jwt \
      --file "{{FILE}}" \
      --target-word-bits 64

# Compile all unit tests without running.
jwt-compile-check-par:
    @tools/drift_test_parallel_runner.sh compile \
      --manifest drift-manifest.json --artifact web-jwt \
      --test-root packages/web-jwt/tests/unit \
      --target-word-bits 64

# All REST unit tests (parallel compile, serial run).
rest-check-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift-manifest.json --artifact web-rest \
      --test-root packages/web-rest/tests/unit \
      --target-word-bits 64

# Single REST unit test.
rest-check-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-rest \
      --test-file "{{FILE}}" \
      --target-word-bits 64

# Certification gate: stability/state stress shaped around real defect classes.
# Scenario A: REST concurrency/state (concurrent clients, mixed request types,
#             guards, JSON caching, keep-alive, malformed recovery, lifecycle).
# Scenario B: Client TLS negative-path → valid-path contamination.
# Scenario C: Pool reuse / stale-connection / forced-reconnect stress.
stress: _require-toolchain-root
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
      --manifest drift-manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/stress/stress_test.drift \
      --target-word-bits 64

# Internal: Client TLS/pool stress (scenarios B + C).
_stress-client:
    @tools/run-stress-client.sh

# Certification gate: performance anomaly detection.
# Machine-keyed pass/fail against baselines in perf-baselines.json.
# Requires: go in PATH, DRIFT_TOOLCHAIN_ROOT set, DRIFT_PYTHON set, jq.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
perf: _require-toolchain-root
    @tools/perf_gate_runner.sh

# Performance smoke (informational, hardcoded thresholds).
perf-smoke:
    @tools/perf_smoke_runner.sh

# Build optimized perf binary to a stable path for strace/perf profiling.
perf-build:
    @mkdir -p work/rest/bench/bin
    @DRIFT_OPTIMIZED=1 tools/drift_test_parallel_runner.sh compile \
      --manifest drift-manifest.json --artifact web-rest \
      --file packages/web-rest/tests/perf/perf_test.drift \
      --target-word-bits 64
    @DRIFT_OPTIMIZED=1 "${DRIFTC}" --target-word-bits 64 --optimized \
      --entry "web.rest.tests.perf.perf_test::main" \
      packages/web-jwt/src/*.drift packages/web-rest/src/*.drift \
      packages/web-rest/tests/perf/perf_test.drift \
      -o work/rest/bench/bin/perf_test
    @echo "Binary: work/rest/bench/bin/perf_test"

# Performance benchmarks: Go + Drift side-by-side (optimized).
# Runs Go raw-TCP, Go net/http, Drift raw-TCP, Drift REST.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
perf-test:
    @echo "=== Go baselines ==="
    @go run benchmarks/go/raw_tcp_bench.go
    @go run benchmarks/go/net_http_bench.go
    @echo ""
    @echo "=== Drift (optimized) ==="
    @DRIFT_OPTIMIZED=1 tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/perf_test.drift \
      --target-word-bits 64
# Raw TCP with TCP_NODELAY — compare against baseline-vt in perf-test.
perf-nodelay:
    @DRIFT_OPTIMIZED=1 tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/nodelay_test.drift \
      --target-word-bits 64

# REST probes: timeout sensitivity, read-call count, raw ping-pong.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
rest-probe:
    tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/probe_test.drift \
      --target-word-bits 64

# REST instrumented keep-alive: per-phase server + client timing.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
rest-instrument:
    tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/instrument_test.drift \
      --target-word-bits 64

# REST decomposition benchmarks: parse, dispatch, serialize isolation.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
rest-decompose:
    tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-rest \
      --test-file packages/web-rest/tests/perf/decompose_test.drift \
      --target-word-bits 64

# Compile-only check for REST (no execution).
rest-compile-check FILE="packages/web-rest/src/lib.drift":
    @tools/drift_test_parallel_runner.sh compile \
      --manifest drift-manifest.json --artifact web-rest \
      --file "{{FILE}}" \
      --target-word-bits 64

# All client unit tests (parallel compile, serial run).
client-check-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift-manifest.json --artifact web-client \
      --test-root packages/web-client/tests/unit \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Single client unit test.
client-check-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-client \
      --test-file "{{FILE}}" \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Client e2e tests (HTTP + HTTPS against local servers).
client-e2e-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --manifest drift-manifest.json --artifact web-client \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-root packages/web-client/tests/e2e \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Single client e2e test.
client-e2e-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-client \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file "{{FILE}}" \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Client pool perf benchmark.
client-perf:
    @tools/drift_test_parallel_runner.sh run-one \
      --manifest drift-manifest.json --artifact web-client \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-client/tests/perf/pool_perf_test.drift \
      --package-root {{PKG_ROOT}} \
      --target-word-bits 64

# Client HTTPS e2e test (local Python HTTPS server + net-tls).
client-https-e2e:
	#!/usr/bin/env bash
	set -euo pipefail
	TMPDIR="$(mktemp -d)"
	trap 'rm -rf "${TMPDIR}"' EXIT
	# Compile test binary.
	"${DRIFTC}" --target-word-bits 64 \
	  --package-root {{PKG_ROOT}} \
	  --dep "$(jq -r '.artifacts[] | select(.name=="web-client") | .package_deps[] | select(.name=="net-tls") | "\(.name)@\(.version)"' drift-manifest.json)" \
	  --entry "web.client.tests.https.https_e2e_test::main" \
	  packages/web-jwt/src/*.drift packages/web-rest/src/*.drift packages/web-client/src/*.drift \
	  packages/web-client/tests/https/https_e2e_test.drift \
	  -o "${TMPDIR}/https_e2e_test"
	# Run with HTTPS test server.
	packages/web-client/tools/run-https-e2e.sh "${TMPDIR}/https_e2e_test"

# Compile-only check for client (no execution).
client-compile-check FILE="packages/web-client/src/lib.drift":
    @tools/drift_test_parallel_runner.sh compile \
      --manifest drift-manifest.json --artifact web-client \
      --package-root {{PKG_ROOT}} \
      --file "{{FILE}}" \
      --target-word-bits 64

# Build package artifact locally (manifest-driven).
build ARTIFACT="":
    {{DRIFT}} build {{ARTIFACT}} --driftc "${DRIFTC}"

# Prepare lockfile (resolve dependencies against dest).
prepare: _require-toolchain-root
    {{DRIFT}} prepare --dest ~/opt/drift/libs

# Deploy (build, sign, smoke, publish).
deploy *ARGS:
    {{DRIFT}} deploy --dest ~/opt/drift/libs --driftc "${DRIFTC}" {{ARGS}}

# Show driftc version info.
driftc-help:
    @${DRIFTC} --help 2>&1 | head -5 || true
