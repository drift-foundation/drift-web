#!/usr/bin/env bash
# Stress gate harness for client-side TLS/pool scenarios (B and C).
#
# Starts the HTTPS test server, compiles both stress test binaries,
# then runs them sequentially against the same server.
#
# Usage: tools/run-stress-client.sh
set -euo pipefail

: "${DRIFTC:?set DRIFTC to your driftc path}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
CLIENT_TOOLS="${ROOT_DIR}/packages/web-client/tools"
FIXTURE_DIR="${ROOT_DIR}/packages/web-client/tests/fixtures"
PKG_ROOT="${DRIFT_PKG_ROOT:-${DRIFT_PACKAGE_ROOT:?set DRIFT_PKG_ROOT or DRIFT_PACKAGE_ROOT to the package root}}"

# Generate certs if missing.
if [[ ! -f "${FIXTURE_DIR}/server.crt" ]]; then
    "${CLIENT_TOOLS}/gen-test-certs.sh"
fi

TMPDIR="$(mktemp -d)"
PORT_FILE="${TMPDIR}/ports.json"

cleanup() {
    kill "${SERVER_PID}" 2>/dev/null || true
    wait "${SERVER_PID}" 2>/dev/null || true
    rm -rf "${TMPDIR}"
}
trap cleanup EXIT

# Resolve net-tls dependency from lock (manifest has a range, driftc needs exact).
TLS_DEP="net-tls@$(jq -r '.artifacts["web-client"].resolved["net-tls"].version' "${ROOT_DIR}/drift/lock.json")"

# Compile both stress test binaries.
echo "=== compiling tls-contamination test ==="
"${DRIFTC}" --target-word-bits 64 \
    --package-root "${PKG_ROOT}" \
    --dep "${TLS_DEP}" \
    --entry "web.client.tests.stress.tls_contamination_test::main" \
    packages/web-jwt/src/*.drift packages/web-rest/src/*.drift packages/web-client/src/*.drift \
    packages/web-client/tests/stress/tls_contamination_test.drift \
    -o "${TMPDIR}/tls_contamination_test"

echo "=== compiling pool-stale test ==="
"${DRIFTC}" --target-word-bits 64 \
    --package-root "${PKG_ROOT}" \
    --dep "${TLS_DEP}" \
    --entry "web.client.tests.stress.pool_stale_test::main" \
    packages/web-jwt/src/*.drift packages/web-rest/src/*.drift packages/web-client/src/*.drift \
    packages/web-client/tests/stress/pool_stale_test.drift \
    -o "${TMPDIR}/pool_stale_test"

# Start HTTPS test server.
python3 "${CLIENT_TOOLS}/https_test_server.py" \
    --cert "${FIXTURE_DIR}/server.crt" \
    --key "${FIXTURE_DIR}/server.key" \
    --wrong-host-cert "${FIXTURE_DIR}/wrong-host.crt" \
    --wrong-host-key "${FIXTURE_DIR}/wrong-host.key" \
    --port-file "${PORT_FILE}" &
SERVER_PID=$!

# Wait for port file.
for _i in $(seq 1 100); do
    if [[ -f "${PORT_FILE}" ]]; then break; fi
    sleep 0.1
done
if [[ ! -f "${PORT_FILE}" ]]; then
    echo "error: HTTPS server did not produce port file" >&2
    exit 1
fi

HTTPS_PORT="$(jq -r .port "${PORT_FILE}")"
WRONG_HOST_PORT="$(jq -r .wrong_host_port "${PORT_FILE}")"

export HTTPS_TEST_PORT="${HTTPS_PORT}"
export HTTPS_WRONG_HOST_PORT="${WRONG_HOST_PORT}"
export HTTPS_CA_CERT="${FIXTURE_DIR}/ca.crt"

# Run tests sequentially, honoring instrumentation env vars.
run_binary() {
    if [[ "${DRIFT_MEMCHECK:-0}" == "1" ]]; then
        valgrind --tool=memcheck --error-exitcode=97 --leak-check=full "$@"
    else
        "$@"
    fi
}

echo "=== scenario B: tls-contamination ==="
run_binary "${TMPDIR}/tls_contamination_test"
echo "=== scenario B: PASS ==="

echo "=== scenario C: pool-stale ==="
run_binary "${TMPDIR}/pool_stale_test"
echo "=== scenario C: PASS ==="
