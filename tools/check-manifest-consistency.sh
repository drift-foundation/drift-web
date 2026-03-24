#!/usr/bin/env bash
# Pre-prepare consistency check: internal co-artifact dep versions must match
# the declared artifact version in the same manifest.
#
# Rule: if artifact A has a package_dep on artifact B, and B is also declared
# in this manifest, then the dep version must equal B's artifact version.
set -euo pipefail

MANIFEST="${1:-drift-manifest.json}"

if [[ ! -f "${MANIFEST}" ]]; then
    echo "error: manifest not found: ${MANIFEST}" >&2
    exit 1
fi

# Build a map of artifact name -> version, then check all internal deps.
RESULT=$(jq -r '
  # Build lookup: {name: version} for all artifacts
  (.artifacts | map({(.name): .version}) | add) as $versions |
  # For each artifact, check its package_deps against the lookup
  [.artifacts[] |
    .name as $from |
    .version as $from_ver |
    (.package_deps // [])[] |
    select($versions[.name] != null) |
    select(.version != $versions[.name]) |
    "error: \($from)@\($from_ver) depends on \(.name)@\(.version) but \(.name) is declared as \($versions[.name])"
  ] | .[]
' "${MANIFEST}" 2>/dev/null)

if [[ -n "${RESULT}" ]]; then
    echo "manifest consistency check failed:" >&2
    echo "${RESULT}" >&2
    exit 1
fi
