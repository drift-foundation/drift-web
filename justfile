# Toolchain resolution from DRIFT_TOOLCHAIN_ROOT.
# All recipes resolve tools from $DRIFT_TOOLCHAIN_ROOT/bin/{driftc,drift} and the
# shared test executor from $DRIFT_TOOLCHAIN_ROOT/lib/tools/drift_test_run.py.
export DRIFTC := env("DRIFT_TOOLCHAIN_ROOT", "") / "bin" / "driftc"
export DRIFT  := env("DRIFT_TOOLCHAIN_ROOT", "") / "bin" / "drift"

PKG_ROOT := env("DRIFT_PKG_ROOT", env("DRIFT_PACKAGE_ROOT", ""))
RUNNER   := env("DRIFT_TOOLCHAIN_ROOT", "") / "lib" / "tools" / "drift_test_run.py"

# Compile/run pool budget comes from the toolchain's drift_pytest_jobs default
# (full physical cores as of 0.33.17). No per-team override — auto-detect is the
# single source of truth. An operator can still export DRIFT_TEST_JOBS to override
# (e.g. trim a RAM-constrained CI box); it always wins.

# Guard: all recipes require DRIFT_TOOLCHAIN_ROOT and DRIFT_PKG_ROOT.
_require-env:
    #!/usr/bin/env bash
    fail=0
    if [[ -z "${DRIFT_TOOLCHAIN_ROOT:-}" ]]; then
        echo "error: DRIFT_TOOLCHAIN_ROOT is required" >&2
        fail=1
    fi
    if [[ -z "${DRIFT_PKG_ROOT:-}" ]]; then
        echo "error: DRIFT_PKG_ROOT is required" >&2
        fail=1
    fi
    if [[ "${fail}" -ne 0 ]]; then
        echo "  example:" >&2
        echo "    export DRIFT_TOOLCHAIN_ROOT=\$HOME/opt/drift/certified/current/toolchain" >&2
        echo "    export DRIFT_PKG_ROOT=\$HOME/opt/drift/certified/current/libs" >&2
        exit 1
    fi

# Lock guard: fail fast if drift/lock.json is stale vs manifest + package roots.
lock-check: _require-env
    @{{DRIFT}} prepare --check --package-root "${DRIFT_PKG_ROOT}"

# --- Certification gates (run on the shared toolchain executor) ---
# Each gate emits a plan (tools/emit_test_plan.py) and runs it through the shared
# executor ($DRIFT_TOOLCHAIN_ROOT/lib/tools/drift_test_run.py). The executor owns
# the mechanism — parallel compile under the flocker pool (budget from the
# pytest_jobs protocol), dedup, valgrind wrap, heartbeat. The emitter owns policy
# (which files/deps/lanes). Resource harness (HTTPS server, published-artifact
# consumer build, perf rps→env threading) brackets the executor here in the gate.

# Correctness + memory safety: every unit/e2e test x {plain, asan} compiled once
# (memcheck reuses the plain binary via `out` dedup), run under plain/memcheck/asan.
# Then the harness suites the executor can't express: client-https-e2e (inline
# net-tls compile) and consumer-check (published .zdmp), run plain + memcheck.
test: _require-env lock-check
    #!/usr/bin/env bash
    set -uo pipefail
    WORK="$(mktemp -d -t drift-web-test-XXXXXX)"
    HB_PID=""; status=0
    cleanup() {
        [[ -n "${HB_PID}" ]] && kill "${HB_PID}" 2>/dev/null
        if [[ -n "${WORK:-}" && "${WORK}" == */drift-web-test-* && -d "${WORK}" ]]; then rm -rf "${WORK}"; fi
    }
    trap cleanup EXIT
    # One flocker --heartbeat monitor (dedicated key, no work slot) feeds the orch
    # ≤60s stdout-inactivity watchdog across the whole gate (executor + harness).
    FLOCKER="${DRIFT_TOOLCHAIN_ROOT}/bin/flocker"
    [[ -x "${FLOCKER}" ]] && { "${FLOCKER}" -k drift-web-hb -j 1 --heartbeat 20 -- sleep 86400 & HB_PID=$!; }

    echo "=== test: unit/e2e via shared executor (plain + memcheck + asan) ==="
    PLAN="${WORK}/test-plan.json"
    python3 tools/emit_test_plan.py test --out "${PLAN}"
    python3 "{{RUNNER}}" --plan "${PLAN}" --work-dir "${WORK}" || status=1

    if [[ "${status}" -eq 0 ]]; then
        # Harness suites the executor can't express (inline net-tls compile /
        # published-artifact deploy). Each now builds once and runs BOTH lanes
        # (plain + memcheck) internally — every compile on the flocker budget.
        echo "=== test: harness suites (https-e2e, consumer-check) — build once, plain + memcheck ==="
        ( just client-https-e2e && just consumer-check ) || status=1
    fi
    [[ "${status}" -eq 0 ]] && echo "=== test: PASS ===" || echo "=== test: FAIL ==="
    exit "${status}"

# Stability/state stress. Scenario A: REST concurrency/state. B: TLS
# negative→valid contamination. C: pool stale-connection recovery. The executor
# builds all three binaries in parallel; the run phase is harness — A (own server)
# runs alongside the B→C chain, which share one HTTPS server (run-stress-client.sh
# serializes them on a flocker -j1 resource key). Then a memcheck pass over B+C
# (failed-handshake / dead-socket teardown — leak/UAF paths the unit gate misses;
# the REST scenario isn't memchecked — valgrind serializes its threads).
stress: _require-env lock-check
    #!/usr/bin/env bash
    set -uo pipefail
    WORK="$(mktemp -d -t drift-web-stress-XXXXXX)"
    LOG="${WORK}/harness-logs"; mkdir -p "${LOG}"
    HB_PID=""; status=0
    cleanup() {
        [[ -n "${HB_PID}" ]] && kill "${HB_PID}" 2>/dev/null
        if [[ -n "${WORK:-}" && "${WORK}" == */drift-web-stress-* && -d "${WORK}" ]]; then rm -rf "${WORK}"; fi
    }
    trap cleanup EXIT
    FLOCKER="${DRIFT_TOOLCHAIN_ROOT}/bin/flocker"
    [[ -x "${FLOCKER}" ]] && { "${FLOCKER}" -k drift-web-hb -j 1 --heartbeat 20 -- sleep 86400 & HB_PID=$!; }
    report() {
        local name="$1" pid="$2" log="$3"
        if wait "${pid}"; then echo "=== ${name} — PASS ==="
        else echo "=== ${name} — FAIL ==="; sed 's/^/['"${name}"'] /' "${log}"; status=1; fi
    }

    echo "=== stress phase 1: build scenario binaries (shared executor) ==="
    PLAN="${WORK}/stress-plan.json"
    python3 tools/emit_test_plan.py stress --out "${PLAN}"
    python3 "{{RUNNER}}" --plan "${PLAN}" --work-dir "${WORK}" || { echo "=== stress build FAILED ==="; exit 1; }

    echo "=== stress phase 2: run plain (A ∥ B→C) ==="
    ( "${WORK}/stress_test" > "${LOG}/run-A.log" 2>&1 ) & r_a=$!
    ( tools/run-stress-client.sh "${WORK}" > "${LOG}/run-BC.log" 2>&1 ) & r_bc=$!
    report stress-A-rest    "${r_a}"  "${LOG}/run-A.log"
    report stress-BC-client "${r_bc}" "${LOG}/run-BC.log"
    if [[ "${status}" -ne 0 ]]; then echo "=== stress (plain) FAILED ==="; exit "${status}"; fi

    echo "=== stress phase 3: client scenarios under memcheck (tls_contamination + pool_stale) ==="
    ( DRIFT_MEMCHECK=1 tools/run-stress-client.sh "${WORK}" > "${LOG}/run-BC-memcheck.log" 2>&1 ) & r_mc=$!
    report stress-BC-memcheck "${r_mc}" "${LOG}/run-BC-memcheck.log"
    [[ "${status}" -eq 0 ]] && echo "=== all stress scenarios complete ==="
    exit "${status}"

# Performance anomaly detection (machine-keyed baselines). The executor builds
# the Go baselines + Drift smoke binary in parallel; perf_smoke_runner.sh does
# the serial idle-host measurement. Do not run under DRIFT_MEMCHECK/DRIFT_ASAN.
perf: _require-env
    @tools/perf_gate_runner.sh

# Performance smoke (informational thresholds).
perf-smoke: _require-env lock-check
    @tools/perf_smoke_runner.sh

# --- Dev loop (generic, executor-backed; replace the old per-suite recipes) ---

# Build + run a single test (plain), for fast iteration.
#   just check-one packages/web-rest/tests/unit/middleware_test.drift
check-one FILE: _require-env
    #!/usr/bin/env bash
    set -euo pipefail
    WORK="$(mktemp -d -t drift-web-one-XXXXXX)"; trap 'rm -rf "${WORK}"' EXIT
    python3 tools/emit_test_plan.py one --file "{{FILE}}" --out "${WORK}/plan.json"
    python3 "{{RUNNER}}" --plan "${WORK}/plan.json" --work-dir "${WORK}"

# Type-check a single file (src or test) against its artifact — no run.
#   just compile-check packages/web-rest/src/lib.drift
compile-check FILE: _require-env
    #!/usr/bin/env bash
    set -euo pipefail
    WORK="$(mktemp -d -t drift-web-cc-XXXXXX)"; trap 'rm -rf "${WORK}"' EXIT
    python3 tools/emit_test_plan.py compile --file "{{FILE}}" --out "${WORK}/plan.json"
    python3 "{{RUNNER}}" --plan "${WORK}/plan.json" --work-dir "${WORK}"

# --- Harness suites used by `test` (not executor-expressible) ---

# Client HTTPS e2e test (local Python HTTPS server + net-tls). Build the binary
# ONCE — on the shared flocker budget like every other compile — then run it
# plain AND under memcheck (one build, two runs; no redundant recompile).
client-https-e2e: _require-env
    #!/usr/bin/env bash
    set -euo pipefail
    TMPDIR="$(mktemp -d)"
    trap 'rm -rf "${TMPDIR}"' EXIT
    BIN="${TMPDIR}/https_e2e_test"
    # Compile under flocker on the drift-jobs pool (sized by the same protocol as
    # the executor) so even this single bespoke compile counts against the budget.
    FLOCKER="${DRIFT_TOOLCHAIN_ROOT}/bin/flocker"
    JOBS="$(python3 "${DRIFT_TOOLCHAIN_ROOT}/lib/tools/drift_pytest_jobs.py" 2>/dev/null || echo 1)"
    WRAP=(); [[ -x "${FLOCKER}" ]] && WRAP=("${FLOCKER}" --key drift-jobs -j "${JOBS}" --)
    "${WRAP[@]}" "${DRIFTC}" --target-word-bits 64 \
      --package-root {{PKG_ROOT}} \
      --dep "net-tls@$(jq -r '.artifacts["web-client"].resolved["net-tls"].version' drift/lock.json)" \
      --entry "web.client.tests.https.https_e2e_test::main" \
      packages/web-jwt/src/*.drift packages/web-rest/src/*.drift packages/web-client/src/*.drift \
      packages/web-client/tests/https/https_e2e_test.drift \
      -o "${BIN}"
    # One build, both lanes: plain then memcheck (each starts its own HTTPS server).
    packages/web-client/tools/run-https-e2e.sh "${BIN}"
    DRIFT_MEMCHECK=1 packages/web-client/tools/run-https-e2e.sh "${BIN}"

# Consumer-path package tests: compile + run against published .zdmp artifacts.
consumer-check: _require-env
    @tools/run-consumer-tests.sh

# --- Package lifecycle ---

# Build package artifact locally (manifest-driven).
build ARTIFACT="": _require-env
    {{DRIFT}} build {{ARTIFACT}} --driftc "${DRIFTC}"

# Re-mint drift/<artifact>.author-claim under the Foundation author key against
# the current manifest. With no ARTIFACT, mints all four artifacts.
#   DRIFT_LANG_ROOT (default ~/src/drift-lang); DRIFT_SIGN_KEY_FILE (default seed).
author-claim ARTIFACT="":
    #!/usr/bin/env bash
    set -euo pipefail
    DRIFT_LANG_ROOT="${DRIFT_LANG_ROOT:-${HOME}/src/drift-lang}"
    KEY_FILE="${DRIFT_SIGN_KEY_FILE:-${HOME}/.config/drift/keys/default.seed}"
    [[ -d "${DRIFT_LANG_ROOT}/tools/drift_author" ]] || { echo "error: tools.drift_author not found at ${DRIFT_LANG_ROOT}" >&2; exit 1; }
    [[ -f "${KEY_FILE}" ]] || { echo "error: signing key not found: ${KEY_FILE}" >&2; exit 1; }
    if [[ -n "{{ARTIFACT}}" ]]; then
        ARTS=("{{ARTIFACT}}")
    else
        ARTS=(web-jwt web-rest web-client or-throw-probe)
    fi
    for ART in "${ARTS[@]}"; do
        echo "[author-claim] minting drift/${ART}.author-claim"
        PYTHONPATH="${DRIFT_LANG_ROOT}" python3 -m tools.drift_author publish \
            --manifest "$(pwd)/drift/manifest.json" \
            --artifact "${ART}" \
            --key-file "${KEY_FILE}" \
            --overwrite
    done

# Prepare lockfile (resolve dependencies against package root).
prepare: _require-env
    @tools/check-manifest-consistency.sh
    {{DRIFT}} prepare --dest "${DRIFT_PKG_ROOT:?set DRIFT_PKG_ROOT to the package root}"

# Deploy to staging (build, sign, smoke, publish). Orchestrated certification
# overrides --cert-suite-id and binds real evidence; the flags here are a local
# dev fallback only.
deploy *ARGS: _require-env lock-check
    {{DRIFT}} deploy --dest "${DRIFT_PKG_ROOT:?set DRIFT_PKG_ROOT to the package root}" --driftc "${DRIFTC}" --cert-suite-id drift-web/dev --cert-suite-no-evidence {{ARGS}}

# Read-only trust preflight (author-claims, SCI equality, trust grants).
trust-check: _require-env
    @{{DRIFT}} trust check

# Author ceremony for a version bump: re-mint author-claims, re-resolve the lock,
# trust-check. Safe to over-run. reseal does not test — run `just test` first.
reseal ARTIFACT="":
    @just author-claim {{ARTIFACT}}
    @just prepare
    @just trust-check
    @echo "[reseal] done — review & commit: drift/manifest.json, drift/lock.json, drift/*.author-claim"

# Show driftc version info.
driftc-help: _require-env
    @${DRIFTC} --help 2>&1 | head -5 || true
