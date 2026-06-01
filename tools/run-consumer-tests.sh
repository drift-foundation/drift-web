#!/usr/bin/env bash
# Consumer-path test runner: builds + signs our packages into a local staging
# root (harness), then compiles + runs tiny downstream programs against them —
# in PARALLEL through the shared executor, so every consumer compile uses the
# flocker pool instead of the old serial raw-driftc loop.
#
# These tests do NOT compile package source into the test binary. They consume
# signed .zdmp artifacts built from the current repo, exactly as a downstream
# consumer would. External deps (net-tls) come from $DRIFT_PKG_ROOT.
# Each program is built ONCE (parallel) and run both plain and under memcheck —
# both lanes in one plan, one deploy. No serial loop, no double-build.
set -euo pipefail

: "${DRIFTC:?DRIFTC not set}"
: "${DRIFT:?DRIFT not set}"
: "${DRIFT_PKG_ROOT:?DRIFT_PKG_ROOT not set}"
: "${DRIFT_TOOLCHAIN_ROOT:?DRIFT_TOOLCHAIN_ROOT not set}"
RUNNER="${DRIFT_TOOLCHAIN_ROOT}/lib/tools/drift_test_run.py"
[[ -f "${RUNNER}" ]] || { echo "error: shared runner not found at ${RUNNER}" >&2; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "${TMPDIR}"' EXIT

# --- Harness: stage our packages locally (one-time, sequential) ---
LOCAL_PKG="${TMPDIR}/libs"
echo "=== staging local packages ==="
"${DRIFT}" deploy \
    --dest "${LOCAL_PKG}" \
    --package-root "${LOCAL_PKG}" \
    --package-root "${DRIFT_PKG_ROOT}" \
    --driftc "${DRIFTC}" \
    --cert-suite-id drift-web/dev \
    --cert-suite-no-evidence \
    --skip-smoke \
    2>&1
echo ""

# --- Compile + run the consumer programs in parallel via the executor ---
# The emitter resolves package versions and emits per-program build+run jobs
# against the staged packages; DRIFT_MEMCHECK (inherited) selects the valgrind
# wrap on run jobs. Builds fan out under the flocker pool — no serial loop.
echo "=== consumer tests (parallel build + run via executor) ==="
PLAN="${TMPDIR}/consumer-plan.json"
python3 "${ROOT_DIR}/tools/emit_test_plan.py" consumer --pkg-staging "${LOCAL_PKG}" --out "${PLAN}"
exec python3 "${RUNNER}" --plan "${PLAN}" --work-dir "${TMPDIR}/run"
