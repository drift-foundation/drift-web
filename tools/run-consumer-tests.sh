#!/usr/bin/env bash
# Consumer-path test runner: builds + signs our packages into a local staging
# root, then compiles tiny downstream programs against them via --package-root
# + --dep.
#
# These tests do NOT compile package source into the test binary. They consume
# signed .zdmp artifacts built from the current repo, exactly as a downstream
# consumer would. External deps (net-tls) come from $DRIFT_PKG_ROOT.
set -euo pipefail

: "${DRIFTC:?DRIFTC not set}"
: "${DRIFT:?DRIFT not set}"
: "${DRIFT_PKG_ROOT:?DRIFT_PKG_ROOT not set}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
MANIFEST="${ROOT_DIR}/drift/manifest.json"
LOCK="${ROOT_DIR}/drift/lock.json"
TEST_DIR="${ROOT_DIR}/tests/consumer"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "${TMPDIR}"' EXIT

# Read versions from manifest.
jwt_ver=$(jq -r '.artifacts[] | select(.name=="web-jwt") | .version' "${MANIFEST}")
rest_ver=$(jq -r '.artifacts[] | select(.name=="web-rest") | .version' "${MANIFEST}")
client_ver=$(jq -r '.artifacts[] | select(.name=="web-client") | .version' "${MANIFEST}")
probe_ver=$(jq -r '.artifacts[] | select(.name=="or-throw-probe") | .version' "${MANIFEST}")
tls_ver=$(jq -r '.artifacts["web-client"].resolved["net-tls"].version' "${LOCK}")
tls_dep="net-tls@${tls_ver}"

# --- Stage our packages locally ---
LOCAL_PKG="${TMPDIR}/libs"
echo "=== staging local packages ==="
"${DRIFT}" deploy \
    --dest "${LOCAL_PKG}" \
    --package-root "${LOCAL_PKG}" \
    --package-root "${DRIFT_PKG_ROOT}" \
    --driftc "${DRIFTC}" \
    --skip-smoke \
    2>&1
echo ""

# --- Run consumer tests against staged packages ---
FAILED=0
FAILED_NAMES=()

run_test() {
    local name="$1" entry="$2" src="$3" needs_ext_pkgs="$4"
    shift 4
    local deps=("$@")

    echo "=== consumer: ${name} ==="
    local bin="${TMPDIR}/${name}"

    local pkg_roots=(--package-root "${LOCAL_PKG}")
    if [[ "${needs_ext_pkgs}" == "yes" ]]; then
        pkg_roots+=(--package-root "${DRIFT_PKG_ROOT}")
    fi

    echo "  compile ${name}"
    if ! "${DRIFTC}" --target-word-bits 64 \
        "${pkg_roots[@]}" \
        "${deps[@]}" \
        --entry "${entry}" \
        "${src}" \
        -o "${bin}" 2>&1; then
        echo "  FAIL: compile failed"
        FAILED=$((FAILED + 1))
        FAILED_NAMES+=("${name}")
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
        FAILED_NAMES+=("${name}")
        return
    fi
    echo "  PASS"
}

# 1. web-jwt consumer
run_test "jwt_compile_test" \
    "consumer.jwt_compile_test::main" \
    "${TEST_DIR}/jwt_compile_test.drift" \
    no \
    --dep "web-jwt@${jwt_ver}"

# 2. web-rest startup consumer
run_test "rest_startup_test" \
    "consumer.rest_startup_test::main" \
    "${TEST_DIR}/rest_startup_test.drift" \
    no \
    --dep "web-rest@${rest_ver}" \
    --dep "web-jwt@${jwt_ver}"

# 3. web-rest serve consumer
run_test "rest_serve_test" \
    "consumer.rest_serve_test::main" \
    "${TEST_DIR}/rest_serve_test.drift" \
    no \
    --dep "web-rest@${rest_ver}" \
    --dep "web-jwt@${jwt_ver}"

# 4. web-rest sequential request regression (0.27.125 defect class)
run_test "rest_sequential_test" \
    "consumer.rest_sequential_test::main" \
    "${TEST_DIR}/rest_sequential_test.drift" \
    no \
    --dep "web-rest@${rest_ver}" \
    --dep "web-jwt@${jwt_ver}"

# 5. web-rest throws-route consumer (public API surface regression)
run_test "rest_throws_test" \
    "consumer.rest_throws_test::main" \
    "${TEST_DIR}/rest_throws_test.drift" \
    no \
    --dep "web-rest@${rest_ver}" \
    --dep "web-jwt@${jwt_ver}"

# 5b. web-rest bare-lambda implicit-wrap into add_throws_route /
#     add_route_group_throws_route (0.31.19 LANGUAGE_BUG regression: dispatch
#     selected callback2 instead of callback_throw2 for CallbackThrow*
#     params).  Mirrors pushcoin/bookkeeper's call shape — bare lambdas
#     with untyped params, throwing bodies, and `captures(share arc)`.
run_test "rest_throws_implicit_wrap_test" \
    "consumer.rest_throws_implicit_wrap_test::main" \
    "${TEST_DIR}/rest_throws_implicit_wrap_test.drift" \
    no \
    --dep "web-rest@${rest_ver}" \
    --dep "web-jwt@${jwt_ver}"

# 6. web-rest or_throw consumer (typed Throw path regression)
run_test "rest_or_throw_test" \
    "consumer.rest_or_throw_test::main" \
    "${TEST_DIR}/rest_or_throw_test.drift" \
    no \
    --dep "web-rest@${rest_ver}" \
    --dep "web-jwt@${jwt_ver}"

# 7. K28 probe consumer (package-local ProbeError + stdlib String)
run_test "or_throw_probe_test" \
    "consumer.or_throw_probe_test::main" \
    "${TEST_DIR}/or_throw_probe_test.drift" \
    no \
    --dep "or-throw-probe@${probe_ver}"

# 8. web-client consumer (needs net-tls from external package root)
run_test "client_compile_test" \
    "consumer.client_compile_test::main" \
    "${TEST_DIR}/client_compile_test.drift" \
    yes \
    --dep "web-client@${client_ver}" \
    --dep "${tls_dep}"

if [[ "${FAILED}" -gt 0 ]]; then
    echo "=== consumer tests: ${FAILED} FAILED: ${FAILED_NAMES[*]} ==="
    exit 1
fi
echo "=== consumer tests: all passed ==="
