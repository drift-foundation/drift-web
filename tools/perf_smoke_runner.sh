#!/usr/bin/env bash
# Perf smoke: Go baselines + Drift smoke, throughput ratios.
#
# Follows docs/certifiable-test-gates.md. A PARALLEL compile phase builds every
# measured binary up front under the flocker pool — the Go baselines (just build
# jobs with their own command) and the Drift workload. Then a SERIAL run phase
# measures them on an idle host, one at a time, under a `-j 1` measurement mutex
# with no concurrent compilation. Parallel compilation does NOT disturb
# measurement isolation — only the runs must be serial.
#
# Stdout carries only the measured `req_per_sec` / `[perf-smoke]` lines (the
# caller parses them); compile output goes to per-job logs. Requires: go, DRIFTC,
# DRIFT_PYTHON.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
: "${DRIFT_TEST_JOBS:=$(( $(nproc) / 2 ))}"
export DRIFT_TEST_JOBS

WORK="$(mktemp -d -t drift-web-perf-XXXXXX)"
cleanup() {
	if [[ -n "${WORK:-}" && "${WORK}" == */drift-web-perf-* && -d "${WORK}" ]]; then rm -rf "${WORK}"; fi
}
trap cleanup EXIT

# flocker wrappers: a shared parallel pool for compiles, a -j1 mutex for the
# measurement runs (idle-host isolation). Empty (direct exec) if flocker absent.
COMPILE_WRAP=(); MEASURE_WRAP=()
if [[ -n "${DRIFT_TOOLCHAIN_ROOT:-}" && -x "${DRIFT_TOOLCHAIN_ROOT}/bin/flocker" ]]; then
	COMPILE_WRAP=("${DRIFT_TOOLCHAIN_ROOT}/bin/flocker" -k drift-jobs -j "${DRIFT_TEST_JOBS}" --)
	MEASURE_WRAP=("${DRIFT_TOOLCHAIN_ROOT}/bin/flocker" -k perf-measure -j 1 --)
fi

# --- Phase 1: compile all measured binaries in parallel ---
( "${COMPILE_WRAP[@]}" go build -o "${WORK}/raw_tcp_bench"  "${PROJECT_ROOT}/benchmarks/go/raw_tcp_bench.go" ) >"${WORK}/c-raw.log"  2>&1 & p_raw=$!
( "${COMPILE_WRAP[@]}" go build -o "${WORK}/net_http_bench" "${PROJECT_ROOT}/benchmarks/go/net_http_bench.go" ) >"${WORK}/c-http.log" 2>&1 & p_http=$!
( "${SCRIPT_DIR}/drift_test_parallel_runner.sh" build-one \
	--src-root packages/web-jwt/src \
	--src-root packages/web-rest/src \
	--test-file packages/web-rest/tests/perf/perf_smoke_test.drift \
	--target-word-bits 64 --out-dir "${WORK}/drift" ) >"${WORK}/c-drift.log" 2>&1 & p_drift=$!

fail=0
for pv in "raw:${p_raw}" "http:${p_http}" "drift:${p_drift}"; do
	if ! wait "${pv#*:}"; then
		echo "error: perf compile failed (${pv%%:*}):" >&2
		cat "${WORK}/c-${pv%%:*}.log" >&2
		fail=1
	fi
done
[[ "${fail}" -eq 0 ]] || exit 1

DRIFT_SMOKE="${WORK}/drift/bins/perf_smoke_test"

# --- Phase 2: serial measurement on an idle host (one at a time) ---
go_raw_output="$( "${MEASURE_WRAP[@]}" "${WORK}/raw_tcp_bench" 2>&1 )"
go_raw_rps="$(echo "${go_raw_output}" | sed -n 's/.*req_per_sec=\([0-9]*\).*/\1/p')"
if [[ -z "${go_raw_rps}" ]]; then
	echo "error: failed to parse go-raw-tcp req_per_sec" >&2
	echo "output: ${go_raw_output}" >&2
	exit 1
fi

go_http_output="$( "${MEASURE_WRAP[@]}" "${WORK}/net_http_bench" 2>&1 )"
go_http_rps="$(echo "${go_http_output}" | sed -n 's/.*req_per_sec=\([0-9]*\).*/\1/p')"
if [[ -z "${go_http_rps}" ]]; then
	echo "error: failed to parse go-net-http req_per_sec" >&2
	echo "output: ${go_http_output}" >&2
	exit 1
fi

export GO_RAW_REQ_PER_SEC="${go_raw_rps}"
export GO_HTTP_REQ_PER_SEC="${go_http_rps}"
"${MEASURE_WRAP[@]}" "${DRIFT_SMOKE}"
