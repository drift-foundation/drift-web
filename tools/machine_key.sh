#!/usr/bin/env bash
# Derive a stable machine key for perf baseline lookup.
# Uses /etc/machine-id (stable across reboots, unique per install).
set -euo pipefail

if [[ -f /etc/machine-id ]]; then
    cat /etc/machine-id
else
    echo "error: /etc/machine-id not found" >&2
    exit 1
fi
