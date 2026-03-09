#!/usr/bin/env bash
# Perf smoke guard: runs Go baselines, captures req/sec, passes to Drift smoke test.
# Requires: go in PATH, DRIFTC set, DRIFT_PYTHON set.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# --- Run Go baselines ---

go_raw_output="$(go run "${PROJECT_ROOT}/benchmarks/go/raw_tcp_bench.go" 2>&1)"
go_raw_rps="$(echo "${go_raw_output}" | sed -n 's/.*req_per_sec=\([0-9]*\).*/\1/p')"
if [[ -z "${go_raw_rps}" ]]; then
	echo "error: failed to parse go-raw-tcp req_per_sec" >&2
	echo "output: ${go_raw_output}" >&2
	exit 1
fi

go_http_output="$(go run "${PROJECT_ROOT}/benchmarks/go/net_http_bench.go" 2>&1)"
go_http_rps="$(echo "${go_http_output}" | sed -n 's/.*req_per_sec=\([0-9]*\).*/\1/p')"
if [[ -z "${go_http_rps}" ]]; then
	echo "error: failed to parse go-net-http req_per_sec" >&2
	echo "output: ${go_http_output}" >&2
	exit 1
fi

# --- Run Drift smoke test with Go baselines in env ---

export GO_RAW_REQ_PER_SEC="${go_raw_rps}"
export GO_HTTP_REQ_PER_SEC="${go_http_rps}"

DRIFT_OPTIMIZED=1 "${SCRIPT_DIR}/drift_test_parallel_runner.sh" run-one \
	--src-root packages/web-jwt/src \
	--src-root packages/web-rest/src \
	--test-file packages/web-rest/tests/perf/perf_smoke_test.drift \
	--target-word-bits 64
