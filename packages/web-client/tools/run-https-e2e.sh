#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FIXTURE_DIR="${SCRIPT_DIR}/../tests/fixtures"
TOOLS_DIR="${SCRIPT_DIR}"

# Generate certs if missing.
if [[ ! -f "${FIXTURE_DIR}/server.crt" ]]; then
    "${TOOLS_DIR}/gen-test-certs.sh"
fi

# Pick free ports.
HTTPS_PORT=$(python3 -c "import socket; s=socket.socket(); s.bind(('127.0.0.1',0)); print(s.getsockname()[1]); s.close()")
WRONG_HOST_PORT=$(python3 -c "import socket; s=socket.socket(); s.bind(('127.0.0.1',0)); print(s.getsockname()[1]); s.close()")

# Start HTTPS test servers.
python3 "${TOOLS_DIR}/https_test_server.py" \
    --port "${HTTPS_PORT}" \
    --cert "${FIXTURE_DIR}/server.crt" \
    --key "${FIXTURE_DIR}/server.key" \
    --wrong-host-port "${WRONG_HOST_PORT}" \
    --wrong-host-cert "${FIXTURE_DIR}/wrong-host.crt" \
    --wrong-host-key "${FIXTURE_DIR}/wrong-host.key" &
SERVER_PID=$!

# Wait for READY.
timeout 10 bash -c 'while ! grep -q READY /proc/'"${SERVER_PID}"'/fd/1 2>/dev/null; do sleep 0.1; done' 2>/dev/null || sleep 1

cleanup() {
    kill "${SERVER_PID}" 2>/dev/null || true
    wait "${SERVER_PID}" 2>/dev/null || true
}
trap cleanup EXIT

# Export ports for the test binary.
export HTTPS_TEST_PORT="${HTTPS_PORT}"
export HTTPS_WRONG_HOST_PORT="${WRONG_HOST_PORT}"
export HTTPS_CA_CERT="${FIXTURE_DIR}/ca.crt"

echo "HTTPS test servers: port=${HTTPS_PORT} wrong-host=${WRONG_HOST_PORT}"
echo "CA cert: ${HTTPS_CA_CERT}"

# Run the test binary (passed as args).
"$@"
