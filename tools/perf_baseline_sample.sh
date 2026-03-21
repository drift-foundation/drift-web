#!/usr/bin/env bash
# Sample the perf workload N times and output a candidate baseline entry
# for perf-baselines.json.
#
# Usage: tools/perf_baseline_sample.sh [N]    (default: 20)
# Requires: go, DRIFTC, jq, /etc/machine-id
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
N="${1:-20}"

MACHINE_KEY="$(bash "${SCRIPT_DIR}/machine_key.sh")"

echo "Sampling ${N} runs on machine ${MACHINE_KEY}..."
echo "CPU: $(grep 'model name' /proc/cpuinfo | head -1 | sed 's/.*: //')"
echo ""

RAW_VALS=()
REST_VALS=()
FW_VALS=()

COLLECTED=0
ATTEMPT=0
MAX_ATTEMPTS=$((N + 5))

while [[ "${COLLECTED}" -lt "${N}" && "${ATTEMPT}" -lt "${MAX_ATTEMPTS}" ]]; do
    ATTEMPT=$((ATTEMPT + 1))

    # Ignore the binary's own exit code — it enforces hardcoded thresholds;
    # we only need the measured ratios from its output.
    OUTPUT="$(bash "${SCRIPT_DIR}/perf_smoke_runner.sh" 2>&1)" || true

    RAW=$(echo "${OUTPUT}" | sed -n 's/.*drift_raw_ratio=\([0-9]*\.[0-9]*\).*/\1/p' | head -1)
    REST=$(echo "${OUTPUT}" | sed -n 's/.*drift_rest_ratio=\([0-9]*\.[0-9]*\).*/\1/p' | head -1)
    FW=$(echo "${OUTPUT}" | sed -n 's/.*drift_framework_ratio=\([0-9]*\.[0-9]*\).*/\1/p' | head -1)

    if [[ -z "${RAW}" || -z "${REST}" || -z "${FW}" ]]; then
        echo "  attempt ${ATTEMPT}: could not parse ratios, retrying..." >&2
        continue
    fi

    COLLECTED=$((COLLECTED + 1))
    # Invert throughput ratios to cost ratios (higher = worse).
    RAW_COST=$(awk "BEGIN { printf \"%.4f\", 1/${RAW} }")
    REST_COST=$(awk "BEGIN { printf \"%.4f\", 1/${REST} }")
    FW_COST=$(awk "BEGIN { printf \"%.4f\", 1/${FW} }")

    RAW_VALS+=("${RAW_COST}")
    REST_VALS+=("${REST_COST}")
    FW_VALS+=("${FW_COST}")

    echo "  run ${COLLECTED}/${N}: raw_cost=${RAW_COST} rest_cost=${REST_COST} fw_cost=${FW_COST}  (throughput: raw=${RAW} rest=${REST} fw=${FW})"
done

if [[ "${COLLECTED}" -lt "${N}" ]]; then
    echo "error: only collected ${COLLECTED}/${N} samples after ${MAX_ATTEMPTS} attempts" >&2
    exit 1
fi

echo ""

# Compute stats using awk.
compute_stats() {
    local name="$1"
    shift
    local vals=("$@")
    printf '%s\n' "${vals[@]}" | awk -v name="${name}" '
    BEGIN { n=0; sum=0; min=999999; max=0 }
    {
        v = $1 + 0;
        vals[n] = v;
        sum += v;
        if (v < min) min = v;
        if (v > max) max = v;
        n++;
    }
    END {
        mean = sum / n;
        # Sort for median and p95.
        for (i = 0; i < n; i++)
            for (j = i+1; j < n; j++)
                if (vals[i] > vals[j]) { t=vals[i]; vals[i]=vals[j]; vals[j]=t; }
        median = vals[int(n/2)];
        p95_idx = int(n * 0.95);
        if (p95_idx >= n) p95_idx = n - 1;
        p95 = vals[p95_idx];
        printf "%s: min=%.2f mean=%.2f median=%.2f p95=%.2f max=%.2f\n", name, min, mean, median, p95, max;
        # Output JSON fragment for threshold derivation.
        # Threshold = max with 15% slack above worst observed (upper bound).
        # Gate fails when cost exceeds this (regression detected).
        threshold = max * 1.15;
        printf "%s_json: {\"min\": %.2f, \"mean\": %.2f, \"median\": %.2f, \"p95\": %.2f, \"max\": %.2f, \"threshold\": %.2f}\n", name, min, mean, median, p95, max, threshold;
    }'
}

echo "=== Cost ratio distribution (higher = worse) ==="
RAW_STATS=$(compute_stats "raw_tcp_cost" "${RAW_VALS[@]}")
REST_STATS=$(compute_stats "rest_cost" "${REST_VALS[@]}")
FW_STATS=$(compute_stats "framework_cost" "${FW_VALS[@]}")

echo "${RAW_STATS}" | grep -v _json
echo "${REST_STATS}" | grep -v _json
echo "${FW_STATS}" | grep -v _json

# Extract JSON fragments.
RAW_JSON=$(echo "${RAW_STATS}" | sed -n 's/.*_json: //p')
REST_JSON=$(echo "${REST_STATS}" | sed -n 's/.*_json: //p')
FW_JSON=$(echo "${FW_STATS}" | sed -n 's/.*_json: //p')

DATE=$(date +%Y-%m-%d)
CPU=$(grep 'model name' /proc/cpuinfo | head -1 | sed 's/.*: //')

echo ""
echo "=== Candidate baseline entry ==="
echo "Add to perf-baselines.json under key \"${MACHINE_KEY}\":"
echo ""
cat <<EOF
{
  "cpu": "${CPU}",
  "sampled_at": "${DATE}",
  "sample_count": ${N},
  "raw_tcp_cost": ${RAW_JSON},
  "rest_cost": ${REST_JSON},
  "framework_cost": ${FW_JSON}
}
EOF
