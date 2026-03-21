#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FIXTURE_DIR="${SCRIPT_DIR}/../tests/fixtures"
TOOLS_DIR="${SCRIPT_DIR}"

# Generate certs if missing.
if [[ ! -f "${FIXTURE_DIR}/server.crt" ]]; then
    "${TOOLS_DIR}/gen-test-certs.sh"
fi

TMPDIR="$(mktemp -d)"
PORT_FILE="${TMPDIR}/ports.json"

cleanup() {
    kill "${SERVER_PID}" 2>/dev/null || true
    wait "${SERVER_PID}" 2>/dev/null || true
    rm -rf "${TMPDIR}"
}
trap cleanup EXIT

# Start HTTPS test servers. Server binds to ephemeral ports and writes
# the actual bound ports to PORT_FILE (atomic rename, no race).
python3 "${TOOLS_DIR}/https_test_server.py" \
    --cert "${FIXTURE_DIR}/server.crt" \
    --key "${FIXTURE_DIR}/server.key" \
    --wrong-host-cert "${FIXTURE_DIR}/wrong-host.crt" \
    --wrong-host-key "${FIXTURE_DIR}/wrong-host.key" \
    --port-file "${PORT_FILE}" &
SERVER_PID=$!

# Wait for port file (server is listening once it appears).
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

echo "HTTPS server on port ${HTTPS_PORT}"
echo "Wrong-host HTTPS server on port ${WRONG_HOST_PORT}"
echo "READY"

# Run the test binary (passed as args).
"$@"
