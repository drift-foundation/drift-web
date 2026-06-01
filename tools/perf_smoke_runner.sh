#!/usr/bin/env bash
# Perf smoke: Go baselines + Drift smoke, throughput ratios.
#
# Follows docs/certifiable-test-gates.md. The PARALLEL compile phase runs through
# the shared toolchain executor (lib/tools/drift_test_run.py) from a plan emitted
# by tools/emit_test_plan.py — the Go baselines and the Drift workload are just
# build jobs. Then a SERIAL measurement phase runs them on an idle host, one at a
# time under a -j1 flocker mutex; this rps->env->Drift threading is harness glue
# the executor deliberately doesn't own. Parallel compile does not disturb
# measurement isolation — only the runs are serial.
#
# Stdout carries only the measured `req_per_sec` / `[perf-smoke]` lines (the
# caller parses them); the build phase goes to stderr. Requires: go, the staged
# toolchain (DRIFT_TOOLCHAIN_ROOT), DRIFT_PYTHON.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
: "${DRIFT_TOOLCHAIN_ROOT:?DRIFT_TOOLCHAIN_ROOT must be set}"
RUNNER="${DRIFT_TOOLCHAIN_ROOT}/lib/tools/drift_test_run.py"
[[ -f "${RUNNER}" ]] || { echo "error: shared runner not found at ${RUNNER}" >&2; exit 1; }

WORK="$(mktemp -d -t drift-web-perf-XXXXXX)"
cleanup() {
	if [[ -n "${WORK:-}" && "${WORK}" == */drift-web-perf-* && -d "${WORK}" ]]; then rm -rf "${WORK}"; fi
}
trap cleanup EXIT

# --- Phase 1: parallel compile (Go baselines + Drift smoke) via the executor ---
# Build output to stderr so stdout stays clean for the parsed ratio lines.
PLAN="${WORK}/perf-plan.json"
python3 "${PROJECT_ROOT}/tools/emit_test_plan.py" perf --out "${PLAN}" >&2
python3 "${RUNNER}" --plan "${PLAN}" --work-dir "${WORK}" >&2

# --- Phase 2: serial measurement on an idle host (harness; -j1 measure mutex) ---
MEASURE=()
[[ -x "${DRIFT_TOOLCHAIN_ROOT}/bin/flocker" ]] && MEASURE=("${DRIFT_TOOLCHAIN_ROOT}/bin/flocker" -k perf-measure -j 1 --)

go_raw_output="$( "${MEASURE[@]}" "${WORK}/raw_tcp_bench" 2>&1 )"
go_raw_rps="$(echo "${go_raw_output}" | sed -n 's/.*req_per_sec=\([0-9]*\).*/\1/p')"
[[ -n "${go_raw_rps}" ]] || { echo "error: parse go-raw-tcp req_per_sec" >&2; echo "${go_raw_output}" >&2; exit 1; }

go_http_output="$( "${MEASURE[@]}" "${WORK}/net_http_bench" 2>&1 )"
go_http_rps="$(echo "${go_http_output}" | sed -n 's/.*req_per_sec=\([0-9]*\).*/\1/p')"
[[ -n "${go_http_rps}" ]] || { echo "error: parse go-net-http req_per_sec" >&2; echo "${go_http_output}" >&2; exit 1; }

export GO_RAW_REQ_PER_SEC="${go_raw_rps}"
export GO_HTTP_REQ_PER_SEC="${go_http_rps}"
"${MEASURE[@]}" "${WORK}/perf_smoke_test"
