#!/usr/bin/env bash
# Consumer-path test runner: compiles tiny downstream programs against
# published package artifacts via --package-root + --dep.
#
# These tests do NOT compile package source. They consume .zdmp artifacts
# from $DRIFT_PKG_ROOT, exactly as a downstream consumer would.
set -euo pipefail

: "${DRIFTC:?DRIFTC not set}"
: "${DRIFT_PKG_ROOT:?DRIFT_PKG_ROOT not set}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
MANIFEST="${ROOT_DIR}/drift-manifest.json"
TEST_DIR="${ROOT_DIR}/tests/consumer"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "${TMPDIR}"' EXIT

# Read versions from manifest.
jwt_ver=$(jq -r '.artifacts[] | select(.name=="web-jwt") | .version' "${MANIFEST}")
rest_ver=$(jq -r '.artifacts[] | select(.name=="web-rest") | .version' "${MANIFEST}")
client_ver=$(jq -r '.artifacts[] | select(.name=="web-client") | .version' "${MANIFEST}")
tls_dep=$(jq -r '.artifacts[] | select(.name=="web-client") | .package_deps[] | select(.name=="net-tls") | "\(.name)@\(.version)"' "${MANIFEST}")

FAILED=0

run_test() {
    local name="$1" entry="$2" src="$3"
    shift 3
    # Remaining args are --dep flags.
    local deps=("$@")

    echo "=== consumer: ${name} ==="
    local bin="${TMPDIR}/${name}"

    echo "  compile ${name}"
    if ! "${DRIFTC}" --target-word-bits 64 \
        --package-root "${DRIFT_PKG_ROOT}" \
        "${deps[@]}" \
        --entry "${entry}" \
        "${src}" \
        -o "${bin}" 2>&1; then
        echo "  FAIL: compile failed"
        FAILED=$((FAILED + 1))
        return
    fi

    echo "  run ${name}"
    local run_cmd=("${bin}")
    if [[ "${DRIFT_MEMCHECK:-0}" == "1" ]]; then
        run_cmd=(valgrind --tool=memcheck --error-exitcode=97 --leak-check=full "${bin}")
    fi

    if ! "${run_cmd[@]}" 2>&1; then
        echo "  FAIL: run failed"
        FAILED=$((FAILED + 1))
        return
    fi
    echo "  PASS"
}

# 1. web-jwt consumer
run_test "jwt_compile_test" \
    "consumer.jwt_compile_test::main" \
    "${TEST_DIR}/jwt_compile_test.drift" \
    --dep "web-jwt@${jwt_ver}"

# 2. web-rest startup consumer
run_test "rest_startup_test" \
    "consumer.rest_startup_test::main" \
    "${TEST_DIR}/rest_startup_test.drift" \
    --dep "web-rest@${rest_ver}" \
    --dep "web-jwt@${jwt_ver}"

# 3. web-rest serve consumer
run_test "rest_serve_test" \
    "consumer.rest_serve_test::main" \
    "${TEST_DIR}/rest_serve_test.drift" \
    --dep "web-rest@${rest_ver}" \
    --dep "web-jwt@${jwt_ver}"

# 4. web-client consumer
run_test "client_compile_test" \
    "consumer.client_compile_test::main" \
    "${TEST_DIR}/client_compile_test.drift" \
    --dep "web-client@${client_ver}" \
    --dep "${tls_dep}"

if [[ "${FAILED}" -gt 0 ]]; then
    echo "=== consumer tests: ${FAILED} FAILED ==="
    exit 1
fi
echo "=== consumer tests: all passed ==="
