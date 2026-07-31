# tools/cert_deps.py — one derivation site for `--dep name@version` flags in gate compiles.
#
# drift-web adaptation of drift-workflows' validated reference shape (announce
# 2026-07-31T043815Z: DRIFT_LANG_SRC retired; certify-lane derivation is one exec
# of the run toolchain's `drift lock emit --artifact <name> --source-rebuild`,
# shipped in 0.33.92 per 2026-07-31T042844Z). Imported by tools/emit_test_plan.py
# and invoked as a CLI by the justfile's client-https-e2e recipe.
#
# Two lanes, selected by DRIFT_CERT_MODE (orchestrator exports `certify` for gates):
#
#   - STRICT (default, dev loop): the committed drift/lock.json is the
#     authoritative graph — exact versions read from it. Stdlib-only, no exec.
#   - SOURCE-REBUILD (DRIFT_CERT_MODE=certify): the lock is EVIDENCE, not a gate.
#     Resolution is ONE EXEC of the run toolchain's own binary, which resolves
#     via drift-lang's single source-rebuild authority (run-snapshot identity
#     gating, real range semantics, structural trust gates), honoring
#     DRIFT_RUN_SNAPSHOT + DRIFT_PKG_ROOT from the standard cert env. stdout is
#     exactly the flags; evidence/diagnostics go to stderr; errors fail closed
#     (non-zero exit, empty stdout). A pre-0.33.92 toolchain rejects the flag at
#     argument parsing — that is the intended wrong-toolchain signal; never add
#     a fallback resolver or version sniff here (043815Z).
#
# Two deliberate deltas vs. the drift-workflows reference, both forced by
# drift-web's shape:
#   - empty stdout with exit 0 is a VALID no-deps result, not an error — web-jwt
#     has zero package deps, and exit code already distinguishes error from
#     no-deps (net-tls announce 2026-07-31T044103Z §3);
#   - callers pass `exclude` for co-artifacts: `lock emit` emits EVERY resolved
#     entry including co-artifacts, but gate compiles build web-jwt/web-rest
#     from source (--src-root), so their pins must not reach driftc. In strict
#     lane a missing lock entry is likewise not an error (dep-free artifacts
#     have none; `just lock-check` guards staleness).

from __future__ import annotations

import json
import os
import subprocess
import sys
from pathlib import Path


def _strict_versions(artifact, lock_path, exclude):
    lock_path = Path(lock_path)
    if not lock_path.exists():
        return {}
    with open(lock_path) as f:
        lock = json.load(f)
    resolved = (lock.get("artifacts", {}).get(artifact, {}) or {}).get("resolved", {}) or {}
    return {n: v["version"] for n, v in resolved.items() if n not in exclude}


def _certify_versions(manifest_path, artifact, exclude, env):
    toolchain = Path(env.get("DRIFT_TOOLCHAIN_ROOT") or os.path.expanduser("~/opt/drift/certified/current/toolchain"))
    drift = toolchain / "bin" / "drift"
    if not drift.is_file():
        sys.exit(f"cert-deps: drift CLI not found at {drift} (set DRIFT_TOOLCHAIN_ROOT)")
    proc = subprocess.run(
        [str(drift), "lock", "emit", "--artifact", artifact, "--manifest", str(manifest_path), "--source-rebuild"],
        capture_output=True, text=True, env=dict(env))
    # Evidence + diagnostics are the CLI's stderr contract — surface them verbatim.
    if proc.stderr:
        sys.stderr.write(proc.stderr)
    if proc.returncode != 0:
        sys.exit(f"cert-deps: `drift lock emit --artifact {artifact} --source-rebuild` failed "
                 f"(exit {proc.returncode}; toolchain >= 0.33.92 required)")
    tokens = proc.stdout.split()
    versions = {}
    for i, tok in enumerate(tokens):
        if tok != "--dep":
            continue
        if i + 1 >= len(tokens) or "@" not in tokens[i + 1]:
            sys.exit(f"cert-deps: `drift lock emit` stdout violates the flags contract "
                     f"(dangling --dep): {proc.stdout!r}")
        name, _, ver = tokens[i + 1].partition("@")
        if name not in exclude:
            versions[name] = ver
    # Exit 0 with zero emitted flags is the valid no-deps result (044103Z §3);
    # errors already failed closed above.
    return versions


def resolved_versions(manifest_path, artifact, lock_path, exclude=(), env=None):
    """{dep name: version} for `artifact` — the ONE derivation both the plan
    emitter and build recipes must use. Strict lane: committed lock
    (authoritative). Certify lane (DRIFT_CERT_MODE=certify): the toolchain's
    `drift lock emit --source-rebuild`; lock demoted to evidence on stderr."""
    env = os.environ if env is None else env
    exclude = set(exclude)
    if env.get("DRIFT_CERT_MODE") == "certify":
        return _certify_versions(manifest_path, artifact, exclude, env)
    return _strict_versions(artifact, lock_path, exclude)


def dep_flags(manifest_path, artifact, lock_path, exclude=(), env=None):
    """['--dep', 'name@version', ...] sorted by name — drop-in for compile cmds."""
    versions = resolved_versions(manifest_path, artifact, lock_path, exclude, env)
    flags = []
    for name in sorted(versions):
        flags += ["--dep", f"{name}@{versions[name]}"]
    return flags


def main():
    import argparse
    ap = argparse.ArgumentParser(description="Emit --dep flags for a gate compile (strict lock / certify source-rebuild).")
    ap.add_argument("--manifest", required=True)
    ap.add_argument("--artifact", required=True)
    ap.add_argument("--lock", required=True)
    ap.add_argument("--exclude", action="append", default=[])
    args = ap.parse_args()
    print(" ".join(dep_flags(args.manifest, args.artifact, args.lock, args.exclude)))


if __name__ == "__main__":
    main()
