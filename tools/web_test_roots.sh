#!/usr/bin/env bash
# Single source of truth for the unit/e2e test roots that `just test` compiles
# (phase 1) and runs (phase 2). Emitting them from one place keeps the two
# phases from disagreeing on which roots/flags exist.
#
# Output: one root per line, TAB-separated fields:
#   ARTIFACT <TAB> TEST_ROOT <TAB> EXTRA_DRIFTC_FLAGS
# EXTRA may be empty. It carries per-artifact --package-root / --src-root flags
# exactly as the legacy per-recipe `run-all` invocations passed them.
#
# Consumers also derive each root's binary-cache key from TEST_ROOT via
# `web_test_root_key` below (slashes -> dashes), so build-all and run-prebuilt
# address the same OUT_DIR.
set -euo pipefail

PR="${DRIFT_PKG_ROOT:-${DRIFT_PACKAGE_ROOT:-}}"

# Derive a filesystem-safe cache key from a test root path.
web_test_root_key() {
	printf '%s' "$1" | tr '/' '-'
}

# Print the root table. Tab-delimited; third field may be empty.
web_test_roots() {
	printf '%s\t%s\t%s\n' web-jwt    packages/web-jwt/tests/unit   ''
	printf '%s\t%s\t%s\n' web-jwt    packages/web-jwt/tests/e2e    ''
	printf '%s\t%s\t%s\n' web-rest   packages/web-rest/tests/unit  ''
	printf '%s\t%s\t%s\n' web-rest   packages/web-rest/tests/e2e   ''
	printf '%s\t%s\t%s\n' web-client packages/web-client/tests/unit "--package-root ${PR}"
	printf '%s\t%s\t%s\n' web-client packages/web-client/tests/e2e  "--package-root ${PR} --src-root packages/web-jwt/src --src-root packages/web-rest/src"
}
