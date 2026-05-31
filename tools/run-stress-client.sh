#!/usr/bin/env bash
# Stress gate, client TLS/pool scenarios (B and C) — RUN phase only.
#
# Per docs/certifiable-test-gates.md: binaries are compiled in the gate's
# parallel compile phase; this script only RUNS the prebuilt binaries. B and C
# share one HTTPS test server (an exclusive external resource), so they run
# SERIALLY — expressed as a flocker `-j 1 --key` mutex on that resource, not as
# an ad-hoc serial loop.
#
# Usage: tools/run-stress-client.sh <prebuilt-bins-dir>
#   <prebuilt-bins-dir> holds tls_contamination_test and pool_stale_test
#   (produced by `build-all` on packages/web-client/tests/stress).
set -euo pipefail

BINS_DIR="${1:?usage: run-stress-client.sh <prebuilt-bins-dir>}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
CLIENT_TOOLS="${ROOT_DIR}/packages/web-client/tools"
FIXTURE_DIR="${ROOT_DIR}/packages/web-client/tests/fixtures"

for b in tls_contamination_test pool_stale_test; do
    [[ -x "${BINS_DIR}/${b}" ]] || { echo "error: prebuilt binary missing: ${BINS_DIR}/${b}" >&2; exit 1; }
done

# Resolve flocker for the exclusive-resource mutex (host-global). Falls back to
# plain sequential exec if unavailable — sequential is still serial.
FLOCKER_WRAP=()
if [[ -n "${DRIFT_TOOLCHAIN_ROOT:-}" && -x "${DRIFT_TOOLCHAIN_ROOT}/bin/flocker" ]]; then
    FLOCKER_WRAP=("${DRIFT_TOOLCHAIN_ROOT}/bin/flocker" --key stress-https-server -j 1 --)
fi

# Generate certs if missing.
if [[ ! -f "${FIXTURE_DIR}/server.crt" ]]; then
    "${CLIENT_TOOLS}/gen-test-certs.sh"
fi

TMPDIR="$(mktemp -d)"
PORT_FILE="${TMPDIR}/ports.json"
SERVER_PID=""
cleanup() {
    [[ -n "${SERVER_PID}" ]] && kill "${SERVER_PID}" 2>/dev/null || true
    wait "${SERVER_PID}" 2>/dev/null || true
    rm -rf "${TMPDIR}"
}
trap cleanup EXIT

# Start the shared HTTPS test server.
python3 "${CLIENT_TOOLS}/https_test_server.py" \
    --cert "${FIXTURE_DIR}/server.crt" \
    --key "${FIXTURE_DIR}/server.key" \
    --wrong-host-cert "${FIXTURE_DIR}/wrong-host.crt" \
    --wrong-host-key "${FIXTURE_DIR}/wrong-host.key" \
    --port-file "${PORT_FILE}" &
SERVER_PID=$!

for _i in $(seq 1 100); do
    [[ -f "${PORT_FILE}" ]] && break
    sleep 0.1
done
[[ -f "${PORT_FILE}" ]] || { echo "error: HTTPS server did not produce port file" >&2; exit 1; }

export HTTPS_TEST_PORT="$(jq -r .port "${PORT_FILE}")"
export HTTPS_WRONG_HOST_PORT="$(jq -r .wrong_host_port "${PORT_FILE}")"
export HTTPS_CA_CERT="${FIXTURE_DIR}/ca.crt"

# Run B then C serially against the shared server. The flocker -j1 key makes the
# serialization host-global (safe even if another caller targets the same
# resource); valgrind honored for the memcheck lane.
run_serial() {
    if [[ "${DRIFT_MEMCHECK:-0}" == "1" ]]; then
        "${FLOCKER_WRAP[@]}" valgrind --tool=memcheck --error-exitcode=97 --leak-check=full "$@"
    else
        "${FLOCKER_WRAP[@]}" "$@"
    fi
}

echo "=== scenario B: tls-contamination ==="
run_serial "${BINS_DIR}/tls_contamination_test"
echo "=== scenario B: PASS ==="

echo "=== scenario C: pool-stale ==="
run_serial "${BINS_DIR}/pool_stale_test"
echo "=== scenario C: PASS ==="
