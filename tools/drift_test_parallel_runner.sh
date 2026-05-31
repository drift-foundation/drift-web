#!/usr/bin/env bash
set -euo pipefail

usage() {
	echo "usage: $0 <run-all|run-one|build-all|build-one|run-prebuilt|compile|compile-one> [--manifest FILE --artifact NAME] [--src-root DIR] [--test-root DIR] [--test-file FILE] [--file FILE] [--out-dir DIR] [--target-word-bits N] [--jobs N]" >&2
	echo "  build-all:    compile every executable test in --test-root to --out-dir/bins (parallel). Sanitizer via --sanitize. No execution." >&2
	echo "  build-one:    compile a single --test-file to --out-dir/bins/<name> (persistent). No execution." >&2
	echo "  run-prebuilt: run binaries from a prior build-all/build-one --out-dir (parallel). Wraps valgrind when DRIFT_MEMCHECK=1. No compilation." >&2
	exit 2
}

MODE="${1:-}"
[[ -n "${MODE}" ]] || usage
shift || true

MANIFEST=""
ARTIFACT=""
SRC_ROOTS=()
SRC_ROOTS_OVERRIDDEN=0
TEST_ROOT=""
TEST_FILE=""
CHECK_FILE=""
OUT_DIR=""
TARGET_WORD_BITS="64"
PACKAGE_ROOTS=()
DEP_PINS=()
EXTRA_DRIFTC_FLAGS=()
DEFAULT_JOBS="4"
if command -v nproc >/dev/null 2>&1; then
	DEFAULT_JOBS="$(nproc)"
fi
# Job count precedence: --jobs flag > DRIFT_TEST_JOBS (shared cert contract) >
# DRIFT_BUILD_JOBS (legacy) > nproc. DRIFT_TEST_JOBS is orthogonal to lane
# selection (DRIFT_DEBUG) and applies identically to normal and debug lanes.
JOBS="${DRIFT_TEST_JOBS:-${DRIFT_BUILD_JOBS:-${DEFAULT_JOBS}}}"

while [[ $# -gt 0 ]]; do
	case "$1" in
		--manifest)
			MANIFEST="${2:-}"
			shift 2
			;;
		--artifact)
			ARTIFACT="${2:-}"
			shift 2
			;;
		--src-root)
			if [[ "${SRC_ROOTS_OVERRIDDEN}" == "0" ]]; then
				SRC_ROOTS=()
				SRC_ROOTS_OVERRIDDEN=1
			fi
			SRC_ROOTS+=("${2:-}")
			shift 2
			;;
		--test-root)
			TEST_ROOT="${2:-}"
			shift 2
			;;
		--test-file)
			TEST_FILE="${2:-}"
			shift 2
			;;
		--file)
			CHECK_FILE="${2:-}"
			shift 2
			;;
		--out-dir)
			OUT_DIR="${2:-}"
			shift 2
			;;
		--target-word-bits)
			TARGET_WORD_BITS="${2:-}"
			shift 2
			;;
		--jobs)
			JOBS="${2:-}"
			shift 2
			;;
		--package-root)
			PACKAGE_ROOTS+=("${2:-}")
			shift 2
			;;
		--dep)
			DEP_PINS+=("${2:-}")
			shift 2
			;;
		--allow-unsigned-from)
			EXTRA_DRIFTC_FLAGS+=("--allow-unsigned-from" "${2:-}")
			shift 2
			;;
		--link-search)
			EXTRA_DRIFTC_FLAGS+=("--link-search" "${2:-}")
			shift 2
			;;
		--sanitize)
			# Explicit sanitizer selection (driftc 0.33.12+). Authoritative
			# over DRIFT_ASAN/DRIFT_UBSAN and selects the matching runtime
			# archive itself, so a sanitized build is a plain driftc call.
			EXTRA_DRIFTC_FLAGS+=("--sanitize=${2:-}")
			shift 2
			;;
		*)
			echo "error: unknown arg '$1'" >&2
			usage
			;;
	esac
done

resolve_manifest() {
	[[ -f "${MANIFEST}" ]] || { echo "error: manifest not found: ${MANIFEST}" >&2; exit 2; }
	[[ -n "${ARTIFACT}" ]] || { echo "error: --artifact is required with --manifest" >&2; exit 2; }
	local manifest_dir
	manifest_dir="$(cd "$(dirname "${MANIFEST}")" && pwd)"
	local py="${DRIFT_PYTHON:-python3}"
	local output
	output="$("${py}" -c '
import json, os, sys

manifest_path, artifact_name = sys.argv[1], sys.argv[2]
manifest_dir = os.path.dirname(os.path.abspath(manifest_path))

with open(manifest_path) as f:
    manifest = json.load(f)

arts = {a["name"]: a for a in manifest.get("artifacts", [])}
target = arts.get(artifact_name)
if not target:
    print(f"error: artifact {artifact_name!r} not found in manifest", file=sys.stderr)
    sys.exit(2)

lock_path = os.path.join(manifest_dir, "lock.json")
resolved = {}
if os.path.exists(lock_path):
    with open(lock_path) as f:
        lock = json.load(f)
    resolved = (lock.get("artifacts", {}).get(artifact_name, {}) or {}).get("resolved", {}) or {}

# Collect src dirs from this artifact and any co-artifact deps.
src_dirs = set()
for mod in target.get("modules", []):
    src_dirs.add(os.path.dirname(mod))

deps = []
for dep in target.get("package_deps", []):
    name, ver = dep["name"], dep["version"]
    co = arts.get(name)
    if co:
        # Co-artifact: include its src roots, no external --dep needed.
        for mod in co.get("modules", []):
            src_dirs.add(os.path.dirname(mod))
    else:
        # Under schema v2, manifest carries a range ("0.4") but driftc
        # wants the exact resolved version from the lock ("0.4.0").
        resolved_ver = resolved.get(name, {}).get("version") or ver
        deps.append(f"{name}@{resolved_ver}")

for d in sorted(src_dirs):
    print(f"SRC:{d}")
for dep in deps:
    print(f"DEP:{dep}")
' "${MANIFEST}" "${ARTIFACT}")" || exit $?

	local line
	while IFS= read -r line; do
		case "${line}" in
			SRC:*)
				if [[ "${SRC_ROOTS_OVERRIDDEN}" == "0" ]]; then
					SRC_ROOTS=()
					SRC_ROOTS_OVERRIDDEN=1
				fi
				SRC_ROOTS+=("${line#SRC:}")
				;;
			DEP:*)
				DEP_PINS+=("${line#DEP:}")
				;;
		esac
	done <<< "${output}"

	# Use DRIFT_PACKAGE_ROOT if no explicit --package-root and we have deps.
	if [[ "${#PACKAGE_ROOTS[@]}" -eq 0 && "${#DEP_PINS[@]}" -gt 0 && -n "${DRIFT_PACKAGE_ROOT:-}" ]]; then
		PACKAGE_ROOTS+=("${DRIFT_PACKAGE_ROOT}")
	fi
}

# Resolve manifest if provided (before any src/dep usage).
if [[ -n "${MANIFEST}" ]]; then
	resolve_manifest
fi

require_driftc() {
	: "${DRIFTC:?set DRIFTC to your driftc path}"
}

# Resolve the toolchain's `flocker` wrapper for global compile-slot capping.
# Sets FLOCKER_WRAP to an argv prefix that, when prepended to a command, caps
# total concurrent invocations across all callers sharing the same key on this
# host. Only engages when DRIFT_TEST_JOBS is explicitly set (the `just test`
# certification gate) — in that mode the 3 lanes (plain/asan/memcheck) share
# one slot pool, preventing 3× DRIFT_TEST_JOBS driftc from OOMing the box.
# No-op for standalone single-lane runs that leave DRIFT_TEST_JOBS unset.
resolve_flocker_wrap() {
	FLOCKER_WRAP=()
	[[ -z "${DRIFT_TEST_JOBS:-}" ]] && return 0
	local flocker=""
	if [[ -n "${DRIFT_TOOLCHAIN_ROOT:-}" && -x "${DRIFT_TOOLCHAIN_ROOT}/bin/flocker" ]]; then
		flocker="${DRIFT_TOOLCHAIN_ROOT}/bin/flocker"
	elif command -v flocker >/dev/null 2>&1; then
		flocker="$(command -v flocker)"
	else
		return 0
	fi
	FLOCKER_WRAP=("${flocker}" --key drift-jobs -j "${DRIFT_TEST_JOBS}" --)
}

guard_jobs() {
	if [[ ! "${JOBS}" =~ ^[0-9]+$ ]] || [[ "${JOBS}" -lt 1 ]]; then
		echo "error: --jobs must be a positive integer (got '${JOBS}')" >&2
		exit 2
	fi
}

guard_incompat() {
	if [[ "${DRIFT_ASAN:-0}" == "1" && ( "${DRIFT_MEMCHECK:-0}" == "1" || "${DRIFT_MASSIF:-0}" == "1" ) ]]; then
		echo "error: DRIFT_ASAN is incompatible with DRIFT_MEMCHECK/DRIFT_MASSIF in the same run" >&2
		exit 2
	fi
}

guard_compile_only_flags() {
	if [[ "${DRIFT_MEMCHECK:-0}" == "1" || "${DRIFT_MASSIF:-0}" == "1" ]]; then
		echo "error: compile-only mode does not accept DRIFT_MEMCHECK/DRIFT_MASSIF; use run-all/run-one" >&2
		exit 2
	fi
}

set_asan_defaults_for_run() {
	if [[ "${DRIFT_ASAN:-0}" == "1" && -z "${ASAN_OPTIONS:-}" ]]; then
		export ASAN_OPTIONS="detect_leaks=0:halt_on_error=1"
	fi
}

collect_src_files() {
	SRC_FILES=()
	local root
	for root in "${SRC_ROOTS[@]}"; do
		if [[ -d "${root}" ]]; then
			while IFS= read -r f; do
				SRC_FILES+=("${f}")
			done < <(find "${root}" -type f -name "*.drift" | sort)
		fi
	done
	if [[ "${#SRC_FILES[@]}" -eq 0 ]]; then
		echo "error: no source files found under src roots: ${SRC_ROOTS[*]}" >&2
		exit 2
	fi
}

is_executable_test_entry() {
	local file="$1"
	rg -n "^module[[:space:]]+" "${file}" >/dev/null 2>&1 && rg -n "^fn[[:space:]]+main\\(" "${file}" >/dev/null 2>&1
}

test_module_of() {
	local file="$1"
	sed -n "s/^module[[:space:]]\\+\\(.*\\);\\{0,1\\}$/\\1/p" "${file}" | sed 's/;$//' | head -n1
}

build_pkg_flags() {
	PKG_FLAGS=()
	local pr
	for pr in "${PACKAGE_ROOTS[@]}"; do
		PKG_FLAGS+=("--package-root" "${pr}")
	done
	local dp
	for dp in "${DEP_PINS[@]}"; do
		PKG_FLAGS+=("--dep" "${dp}")
	done
	PKG_FLAGS+=("${EXTRA_DRIFTC_FLAGS[@]}")
}

compile_only_file() {
	local file="$1"
	[[ -f "${file}" ]] || { echo "error: missing file ${file}" >&2; exit 2; }
	build_pkg_flags
	"${FLOCKER_WRAP[@]}" env -u DRIFT_MEMCHECK -u DRIFT_MASSIF "${DRIFTC}" --target-word-bits "${TARGET_WORD_BITS}" "${PKG_FLAGS[@]}" "${SRC_FILES[@]}" "${file}"
}

compile_test_binary() {
	local test_file="$1"
	local bin_path="$2"
	local test_module
	test_module="$(test_module_of "${test_file}")"
	[[ -n "${test_module}" ]] || { echo "error: missing module declaration in ${test_file}" >&2; exit 2; }
	local entry_symbol="${test_module}::main"
	build_pkg_flags
	"${FLOCKER_WRAP[@]}" env -u DRIFT_MEMCHECK -u DRIFT_MASSIF "${DRIFTC}" --target-word-bits "${TARGET_WORD_BITS}" "${PKG_FLAGS[@]}" --entry "${entry_symbol}" "${SRC_FILES[@]}" "${test_file}" -o "${bin_path}"
}

run_binary() {
	local bin_path="$1"
	# Route runs through the same global flocker pool as compiles (FLOCKER_WRAP
	# is empty unless DRIFT_TEST_JOBS is set), so concurrent test processes —
	# including heavy valgrind runs across all three lanes — stay bounded by the
	# one host-wide slot count instead of 3×JOBS. No --heartbeat here: run output
	# is captured to per-job logs, and flocker's heartbeat must not pollute
	# captured data (it's fed at the gate level instead).
	if [[ "${DRIFT_MEMCHECK:-0}" == "1" ]]; then
		"${FLOCKER_WRAP[@]}" valgrind --tool=memcheck --error-exitcode=97 --leak-check=full "${bin_path}"
	elif [[ "${DRIFT_MASSIF:-0}" == "1" ]]; then
		"${FLOCKER_WRAP[@]}" valgrind --tool=massif --error-exitcode=97 "${bin_path}"
	else
		"${FLOCKER_WRAP[@]}" "${bin_path}"
	fi
}

wait_for_slot() {
	local running
	while true; do
		running="$(jobs -rp | wc -l | tr -d ' ')"
		if [[ "${running}" -lt "${JOBS}" ]]; then
			return
		fi
		sleep 0.05
	done
}

compile_all_parallel() {
	local out_dir="$1"
	COMPILE_PIDS=()
	COMPILE_NAMES=()
	COMPILE_LOGS=()
	COMPILE_BINS=()
	local test_file
	for test_file in "${TEST_FILES[@]}"; do
		local test_name
		test_name="$(basename "${test_file}" .drift)"
		local bin_path="${out_dir}/bins/${test_name}"
		local log_path="${out_dir}/logs/${test_name}.log"
		wait_for_slot
		echo "compile ${test_name}"
		( compile_test_binary "${test_file}" "${bin_path}" ) >"${log_path}" 2>&1 &
		COMPILE_PIDS+=("$!")
		COMPILE_NAMES+=("${test_name}")
		COMPILE_LOGS+=("${log_path}")
		COMPILE_BINS+=("${bin_path}")
	done
	local failed=0
	local i
	for i in "${!COMPILE_PIDS[@]}"; do
		if ! wait "${COMPILE_PIDS[$i]}"; then
			failed=1
			echo "error: compile failed for ${COMPILE_NAMES[$i]}" >&2
			sed -n '1,200p' "${COMPILE_LOGS[$i]}" >&2 || true
		fi
	done
	if [[ "${failed}" -ne 0 ]]; then
		exit 1
	fi
}

run_compiled_serial() {
	local i
	for i in "${!COMPILE_BINS[@]}"; do
		echo "run ${COMPILE_NAMES[$i]}"
		run_binary "${COMPILE_BINS[$i]}"
	done
}

# Parallel test execution. Each test logs to its own file; failures print
# the captured log. Honors JOBS.
run_compiled_parallel() {
	local out_dir="$1"
	mkdir -p "${out_dir}/run-logs"
	RUN_PIDS=()
	RUN_NAMES=()
	RUN_LOGS=()
	local i
	for i in "${!COMPILE_BINS[@]}"; do
		local name="${COMPILE_NAMES[$i]}"
		local bin="${COMPILE_BINS[$i]}"
		local log="${out_dir}/run-logs/${name}.log"
		wait_for_slot
		echo "run ${name}"
		( run_binary "${bin}" ) >"${log}" 2>&1 &
		RUN_PIDS+=("$!")
		RUN_NAMES+=("${name}")
		RUN_LOGS+=("${log}")
	done
	local failed=0
	for i in "${!RUN_PIDS[@]}"; do
		if ! wait "${RUN_PIDS[$i]}"; then
			failed=1
			echo "error: test failed: ${RUN_NAMES[$i]}" >&2
			sed -n '1,400p' "${RUN_LOGS[$i]}" >&2 || true
		fi
	done
	if [[ "${failed}" -ne 0 ]]; then
		exit 1
	fi
}

run_all_tests() {
	collect_test_files
	local out_dir
	out_dir="$(mktemp -d /tmp/drift-test-par-runner.XXXXXX)"
	trap "rm -rf '${out_dir}'" EXIT
	mkdir -p "${out_dir}/bins" "${out_dir}/logs"
	echo "parallel compile: ${#TEST_FILES[@]} tests with jobs=${JOBS}"
	compile_all_parallel "${out_dir}"
	echo "parallel run: ${#TEST_FILES[@]} tests with jobs=${JOBS}"
	run_compiled_parallel "${out_dir}"
}

# Shared: enumerate executable test entries under TEST_ROOT into TEST_FILES.
# Selection logic is identical to run_all_tests so build-all and run-prebuilt
# agree on which tests exist and what their binary names are.
collect_test_files() {
	mapfile -t CANDIDATE_TEST_FILES < <(find "${TEST_ROOT}" -type f -name "*.drift" | sort)
	TEST_FILES=()
	local f
	for f in "${CANDIDATE_TEST_FILES[@]}"; do
		if is_executable_test_entry "${f}"; then
			TEST_FILES+=("${f}")
		fi
	done
	if [[ "${#TEST_FILES[@]}" -eq 0 ]]; then
		echo "error: no executable test entry files found under ${TEST_ROOT}" >&2
		exit 2
	fi
}

# build-all: compile every executable test in TEST_ROOT to a PERSISTENT
# OUT_DIR/bins (no trap-cleanup — run-prebuilt consumes it in a later phase).
# Variant (plain vs asan) follows DRIFT_ASAN, which driftc reads at compile.
build_all_tests() {
	[[ -n "${TEST_ROOT}" ]] || { echo "error: build-all requires --test-root" >&2; exit 2; }
	[[ -n "${OUT_DIR}" ]] || { echo "error: build-all requires --out-dir" >&2; exit 2; }
	collect_test_files
	mkdir -p "${OUT_DIR}/bins" "${OUT_DIR}/logs"
	echo "build-all: ${#TEST_FILES[@]} tests with jobs=${JOBS} -> ${OUT_DIR}/bins"
	compile_all_parallel "${OUT_DIR}"
}

# run-prebuilt: execute binaries built by a prior build-all into OUT_DIR/bins.
# Re-enumerates TEST_ROOT to recover the same name->binary mapping, then runs
# them via the shared parallel runner (which honors DRIFT_MEMCHECK/valgrind).
run_prebuilt_tests() {
	[[ -n "${TEST_ROOT}" ]] || { echo "error: run-prebuilt requires --test-root" >&2; exit 2; }
	[[ -n "${OUT_DIR}" ]] || { echo "error: run-prebuilt requires --out-dir" >&2; exit 2; }
	collect_test_files
	COMPILE_NAMES=()
	COMPILE_BINS=()
	local test_file name
	for test_file in "${TEST_FILES[@]}"; do
		name="$(basename "${test_file}" .drift)"
		COMPILE_NAMES+=("${name}")
		COMPILE_BINS+=("${OUT_DIR}/bins/${name}")
	done
	local missing=0 b
	for b in "${COMPILE_BINS[@]}"; do
		[[ -x "${b}" ]] || { echo "error: prebuilt binary missing (build-all not run?): ${b}" >&2; missing=1; }
	done
	[[ "${missing}" -eq 0 ]] || exit 1
	echo "run-prebuilt: ${#COMPILE_BINS[@]} tests with jobs=${JOBS} <- ${OUT_DIR}/bins"
	run_compiled_parallel "${OUT_DIR}"
}

# build-one: compile a single --test-file to a PERSISTENT --out-dir/bins/<name>
# (no run, no trap-cleanup). The single-file analog of build-all, for gates that
# build one specific binary (e.g. a perf workload) rather than a whole root.
build_one_test() {
	[[ -n "${TEST_FILE}" ]] || { echo "error: build-one requires --test-file" >&2; exit 2; }
	[[ -n "${OUT_DIR}" ]] || { echo "error: build-one requires --out-dir" >&2; exit 2; }
	[[ -f "${TEST_FILE}" ]] || { echo "error: missing test file ${TEST_FILE}" >&2; exit 2; }
	is_executable_test_entry "${TEST_FILE}" || { echo "error: ${TEST_FILE} is not an executable test entry (requires module + fn main)" >&2; exit 2; }
	mkdir -p "${OUT_DIR}/bins"
	local name; name="$(basename "${TEST_FILE}" .drift)"
	echo "compile ${name}"
	compile_test_binary "${TEST_FILE}" "${OUT_DIR}/bins/${name}"
}

run_one_test() {
	[[ -f "${TEST_FILE}" ]] || { echo "error: missing test file ${TEST_FILE}" >&2; exit 2; }
	is_executable_test_entry "${TEST_FILE}" || { echo "error: ${TEST_FILE} is not an executable test entry (requires module + fn main)" >&2; exit 2; }
	local out_dir
	out_dir="$(mktemp -d /tmp/drift-test-par-runner-one.XXXXXX)"
	trap "rm -rf '${out_dir}'" EXIT
	local bin_path="${out_dir}/unit-test"
	echo "compile $(basename "${TEST_FILE}")"
	compile_test_binary "${TEST_FILE}" "${bin_path}"
	echo "run $(basename "${TEST_FILE}")"
	run_binary "${bin_path}"
}

require_driftc
resolve_flocker_wrap
guard_jobs
guard_incompat
# run-prebuilt executes pre-built binaries; it neither compiles nor needs the
# source/manifest resolution every other mode depends on.
if [[ "${MODE}" != "run-prebuilt" ]]; then
	collect_src_files
fi

case "${MODE}" in
	compile)
	guard_compile_only_flags
	[[ -n "${CHECK_FILE}" ]] || { echo "error: --file is required for compile mode" >&2; exit 2; }
	compile_only_file "${CHECK_FILE}"
	;;
	compile-one)
	guard_compile_only_flags
	[[ -n "${CHECK_FILE}" ]] || { echo "error: --file is required for compile-one mode" >&2; exit 2; }
	compile_only_file "${CHECK_FILE}"
	;;
	run-all)
	set_asan_defaults_for_run
	run_all_tests
	;;
	build-all)
	build_all_tests
	;;
	build-one)
	build_one_test
	;;
	run-prebuilt)
	set_asan_defaults_for_run
	run_prebuilt_tests
	;;
	run-one)
	[[ -n "${TEST_FILE}" ]] || { echo "error: --test-file is required for run-one mode" >&2; exit 2; }
	set_asan_defaults_for_run
	run_one_test
	;;
	*)
	usage
	;;
esac

