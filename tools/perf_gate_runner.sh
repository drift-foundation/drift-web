#!/usr/bin/env bash
# Perf certification gate: runs the perf workload, reads machine-keyed
# baselines from perf-baselines.json, and makes a pass/fail decision.
#
# Ratios are cost-based (higher = worse = more overhead relative to baseline).
# Gate fails when a cost ratio exceeds its threshold (regression detected).
#
# Usage: tools/perf_gate_runner.sh
# Requires: go, DRIFTC, jq, awk, /etc/machine-id
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
BASELINES_FILE="${PROJECT_ROOT}/perf-baselines.json"

# --- Machine key ---
MACHINE_KEY="$(bash "${SCRIPT_DIR}/machine_key.sh")"
echo "[perf-gate] machine=${MACHINE_KEY}"

# --- Load baseline ---
if [[ ! -f "${BASELINES_FILE}" ]]; then
    echo "[perf-gate] FAIL: perf-baselines.json not found" >&2
    exit 1
fi

if ! jq -e --arg key "${MACHINE_KEY}" '.[$key]' "${BASELINES_FILE}" >/dev/null 2>&1; then
    echo "[perf-gate] FAIL: no baseline entry for machine ${MACHINE_KEY}" >&2
    echo "[perf-gate] Run 'tools/perf_baseline_sample.sh' to create one." >&2
    exit 1
fi

THRESHOLD_RAW=$(jq -r --arg key "${MACHINE_KEY}" '.[$key].raw_tcp_cost.threshold' "${BASELINES_FILE}")
THRESHOLD_REST=$(jq -r --arg key "${MACHINE_KEY}" '.[$key].rest_cost.threshold' "${BASELINES_FILE}")
THRESHOLD_FW=$(jq -r --arg key "${MACHINE_KEY}" '.[$key].framework_cost.threshold' "${BASELINES_FILE}")

echo "[perf-gate] thresholds (upper bound, higher=worse): raw<=${THRESHOLD_RAW} rest<=${THRESHOLD_REST} fw<=${THRESHOLD_FW}"

# --- Run measurement ---
# Capture perf-smoke output (it prints [perf-smoke] key=value lines).
# Ignore the binary's own exit code — it enforces hardcoded thresholds;
# the gate uses machine-keyed thresholds from perf-baselines.json instead.
OUTPUT="$(bash "${SCRIPT_DIR}/perf_smoke_runner.sh" 2>&1)" || true
echo "${OUTPUT}"

# --- Parse measured throughput ratios and invert to cost ---
parse_ratio() {
    echo "${OUTPUT}" | sed -n "s/.*${1}=\([0-9]*\.[0-9]*\).*/\1/p" | head -1
}

RAW_THROUGHPUT=$(parse_ratio "drift_raw_ratio")
REST_THROUGHPUT=$(parse_ratio "drift_rest_ratio")
FW_THROUGHPUT=$(parse_ratio "drift_framework_ratio")

if [[ -z "${RAW_THROUGHPUT}" || -z "${REST_THROUGHPUT}" || -z "${FW_THROUGHPUT}" ]]; then
    echo "[perf-gate] FAIL: could not parse ratios from perf output" >&2
    exit 1
fi

# Invert to cost ratios (higher = worse).
RAW_COST=$(awk "BEGIN { printf \"%.2f\", 1/${RAW_THROUGHPUT} }")
REST_COST=$(awk "BEGIN { printf \"%.2f\", 1/${REST_THROUGHPUT} }")
FW_COST=$(awk "BEGIN { printf \"%.2f\", 1/${FW_THROUGHPUT} }")

echo "[perf-gate] measured cost (higher=worse): raw=${RAW_COST} rest=${REST_COST} fw=${FW_COST}"

# --- Enforce thresholds (upper bound: fail if cost exceeds threshold) ---
check_threshold() {
    local name="$1" measured="$2" threshold="$3"
    if awk "BEGIN { exit (${measured} <= ${threshold}) ? 0 : 1 }"; then
        echo "[perf-gate] PASS ${name} ${measured} <= ${threshold}"
        return 0
    else
        echo "[perf-gate] FAIL ${name} ${measured} > ${threshold}"
        return 1
    fi
}

FAILED=0
check_threshold "raw_tcp_cost" "${RAW_COST}" "${THRESHOLD_RAW}" || FAILED=$((FAILED + 1))
check_threshold "rest_cost" "${REST_COST}" "${THRESHOLD_REST}" || FAILED=$((FAILED + 1))
check_threshold "framework_cost" "${FW_COST}" "${THRESHOLD_FW}" || FAILED=$((FAILED + 1))

if [[ "${FAILED}" -gt 0 ]]; then
    echo "[perf-gate] FAIL (${FAILED} threshold(s) violated)"
    exit 1
fi

echo "[perf-gate] PASS"
