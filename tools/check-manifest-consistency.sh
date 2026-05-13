#!/usr/bin/env bash
# Pre-prepare consistency check: internal co-artifact dep versions must
# accept the declared artifact version in the same manifest, per v2 manifest
# semantics.
#
# v2 rule: package_dep versions are owner-declared acceptable ranges in
# `M` (any M.x.x) or `M.N` (any M.N.x) form. The declared artifact version
# is a concrete `M.N.P`. A dep version `R` is accepted iff `R` is a prefix
# of the declared concrete version when split on dots — e.g. "0.4" matches
# "0.4.0" but not "0.5.0"; "0" matches both.
set -euo pipefail

MANIFEST="${1:-drift/manifest.json}"

if [[ ! -f "${MANIFEST}" ]]; then
    echo "error: manifest not found: ${MANIFEST}" >&2
    exit 1
fi

RESULT=$(jq -r '
  (.artifacts | map({(.name): .version}) | add) as $versions |
  [.artifacts[] |
    .name as $from |
    .version as $from_ver |
    (.package_deps // [])[] |
    select($versions[.name] != null) |
    . as $dep |
    $versions[.name] as $declared |
    ($dep.version | split(".")) as $rseg |
    ($declared | split(".")) as $dseg |
    select(
      ($rseg | length) > ($dseg | length)
      or
      ([range(0; $rseg | length)] | map($rseg[.] == $dseg[.]) | all | not)
    ) |
    "error: \($from)@\($from_ver) depends on \(.name)@\(.version) but \(.name) is declared as \($declared); v2 dep version must be `M` or `M.N` and prefix the declared concrete version"
  ] | .[]
' "${MANIFEST}" 2>/dev/null)

if [[ -n "${RESULT}" ]]; then
    echo "manifest consistency check failed:" >&2
    echo "${RESULT}" >&2
    exit 1
fi
