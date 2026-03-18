# Dependency pins (source of truth: drift-package.json).
net_tls_dep := "net-tls@0.3.4"

# Full test suite.
test:
    @just jwt-check-par
    @just jwt-e2e-par
    @just rest-check-par

# All JWT unit tests (parallel compile, serial run).
jwt-check-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --src-root packages/web-jwt/src \
      --test-root packages/web-jwt/tests/unit \
      --target-word-bits 64

# Single JWT unit test.
jwt-check-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --test-file "{{FILE}}" \
      --target-word-bits 64

# JWT e2e-style tests (no external services).
jwt-e2e-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --src-root packages/web-jwt/src \
      --test-root packages/web-jwt/tests/e2e \
      --target-word-bits 64

# Compile-only check (no execution).
jwt-compile-check FILE="packages/web-jwt/src/lib.drift":
    @tools/drift_test_parallel_runner.sh compile \
      --src-root packages/web-jwt/src \
      --file "{{FILE}}" \
      --target-word-bits 64

# Compile all unit tests without running.
jwt-compile-check-par:
    @tools/drift_test_parallel_runner.sh compile \
      --src-root packages/web-jwt/src \
      --test-root packages/web-jwt/tests/unit \
      --target-word-bits 64

# All REST unit tests (parallel compile, serial run).
rest-check-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-root packages/web-rest/tests/unit \
      --target-word-bits 64

# Single REST unit test.
rest-check-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file "{{FILE}}" \
      --target-word-bits 64

# REST stress tests (separate gate, not in default test target).
stress-test:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/stress/stress_test.drift \
      --target-word-bits 64

# Performance smoke guard: ratio-based comparative check vs Go baselines.
# Not part of `just test`. Run as a pre-merge/release quality gate.
# Requires: go in PATH, DRIFTC set, DRIFT_PYTHON set.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
perf-smoke:
    @tools/perf_smoke_runner.sh

# Build optimized perf binary to a stable path for strace/perf profiling.
perf-build:
    @mkdir -p work/rest/bench/bin
    @DRIFT_OPTIMIZED=1 tools/drift_test_parallel_runner.sh compile \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
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
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/perf/perf_test.drift \
      --target-word-bits 64
# Raw TCP with TCP_NODELAY — compare against baseline-vt in perf-test.
perf-nodelay:
    @DRIFT_OPTIMIZED=1 tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/perf/nodelay_test.drift \
      --target-word-bits 64

# REST probes: timeout sensitivity, read-call count, raw ping-pong.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
rest-probe:
    tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/perf/probe_test.drift \
      --target-word-bits 64

# REST instrumented keep-alive: per-phase server + client timing.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
rest-instrument:
    tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/perf/instrument_test.drift \
      --target-word-bits 64

# REST decomposition benchmarks: parse, dispatch, serialize isolation.
# Do not run under DRIFT_MEMCHECK or DRIFT_ASAN.
rest-decompose:
    tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/perf/decompose_test.drift \
      --target-word-bits 64

# Compile-only check for REST (no execution).
rest-compile-check FILE="packages/web-rest/src/lib.drift":
    @tools/drift_test_parallel_runner.sh compile \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --file "{{FILE}}" \
      --target-word-bits 64

# All client unit tests (parallel compile, serial run).
client-check-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --src-root packages/web-client/src \
      --test-root packages/web-client/tests/unit \
      --package-root ~/opt/drift/libs \
      --dep {{net_tls_dep}} \
      --link-search "$HOME/src/drift-net-tls/build/lib" \
      --target-word-bits 64

# Single client unit test.
client-check-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-client/src \
      --test-file "{{FILE}}" \
      --package-root ~/opt/drift/libs \
      --dep {{net_tls_dep}} \
      --link-search "$HOME/src/drift-net-tls/build/lib" \
      --target-word-bits 64

# Client e2e tests (HTTP + HTTPS against local servers).
client-e2e-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --src-root packages/web-client/src \
      --test-root packages/web-client/tests/e2e \
      --package-root ~/opt/drift/libs \
      --dep {{net_tls_dep}} \
      --link-search "$HOME/src/drift-net-tls/build/lib" \
      --target-word-bits 64

# Single client e2e test.
client-e2e-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --src-root packages/web-client/src \
      --test-file "{{FILE}}" \
      --package-root ~/opt/drift/libs \
      --dep {{net_tls_dep}} \
      --link-search "$HOME/src/drift-net-tls/build/lib" \
      --target-word-bits 64

# Client HTTPS e2e test (local Python HTTPS server + net-tls).
client-https-e2e:
	#!/usr/bin/env bash
	set -euo pipefail
	: "${DRIFTC:?set DRIFTC to your driftc path}"
	TMPDIR="$(mktemp -d)"
	trap 'rm -rf "${TMPDIR}"' EXIT
	# Compile test binary.
	"${DRIFTC}" --target-word-bits 64 \
	  --package-root ~/opt/drift/libs \
	  --dep {{net_tls_dep}} \
	  --link-search "$HOME/src/drift-net-tls/build/lib" \
	  --entry "web.client.tests.e2e.https_e2e_test::main" \
	  packages/web-jwt/src/*.drift packages/web-rest/src/*.drift packages/web-client/src/*.drift \
	  packages/web-client/tests/e2e/https_e2e_test.drift \
	  -o "${TMPDIR}/https_e2e_test"
	# Run with HTTPS test server.
	LD_LIBRARY_PATH="${HOME}/src/drift-net-tls/build/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" \
	  packages/web-client/tools/run-https-e2e.sh "${TMPDIR}/https_e2e_test"

# Compile-only check for client (no execution).
client-compile-check FILE="packages/web-client/src/lib.drift":
    @tools/drift_test_parallel_runner.sh compile \
      --src-root packages/web-client/src \
      --package-root ~/opt/drift/libs \
      --dep {{net_tls_dep}} \
      --link-search "$HOME/src/drift-net-tls/build/lib" \
      --file "{{FILE}}" \
      --target-word-bits 64

# Deploy via drift deploy (standardized toolchain release flow).
#
# Usage:
#   just deploy -- --dest=~/opt/drift/libs
#
# Reads drift-package.json for artifact definitions.
# Requires: DRIFTC, DRIFT_SIGN_KEY_FILE.
deploy *ARGS:
	#!/usr/bin/env bash
	set -euo pipefail
	: "${DRIFTC:?set DRIFTC to your driftc path}"
	args=({{ARGS}})
	# Strip leading -- (forwarded from just)
	if [[ ${#args[@]} -gt 0 && "${args[0]}" == "--" ]]; then
		args=("${args[@]:1}")
	fi
	# Expand ~ in --dest= values (just doesn't expand ~ inside quotes)
	expanded=()
	for a in "${args[@]}"; do
		case "$a" in
			--dest=\~/*) expanded+=("--dest=${HOME}/${a#--dest=\~/}") ;;
			--dest=\~)   expanded+=("--dest=${HOME}") ;;
			*)           expanded+=("$a") ;;
		esac
	done
	DRIFT_BIN="$(dirname "${DRIFTC}")/drift"
	"${DRIFT_BIN}" deploy --driftc "${DRIFTC}" "${expanded[@]}"

# Show driftc version info.
driftc-help:
    @${DRIFTC} --help 2>&1 | head -5 || true
