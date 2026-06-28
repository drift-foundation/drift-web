#!/usr/bin/env python3
"""Emit a drift_test_run.py plan for a drift-web gate or a single dev test.

drift-web's PLAN EMITTER — the small per-project piece we keep when the shared
`lib/tools/drift_test_run.py` executor owns the plumbing. It owns only POLICY
(which files / deps / lanes); the executor owns mechanism (parallel compile under
flocker, run scheduling, dedup, valgrind, heartbeat, budget).

Gates:
  test   — every unit/e2e test x {plain,asan} build, then plain/memcheck/asan run.
  perf   — BUILD-ONLY: the Go baselines + the Drift smoke binary, compiled in
           parallel. The serial idle-host measurement (Go rps -> env -> Drift)
           is harness glue in perf_smoke_runner.sh that brackets the executor.
  stress — BUILD-ONLY: the 3 scenario binaries. The run phase (REST scenario +
           the HTTPS-server-bracketed client scenarios + memcheck) is harness.
Dev:
  one --file F      — build+run one test (plain), for fast iteration.
  compile --file F  — compile-check one file (no run).

Naming: build `out` names are namespaced and DOT-FREE. driftc derives its scratch
.ll from -o; pre-0.33.16 a dotted -o collapsed scratch paths and clobbered under
parallelism. Fixed compiler-side in 0.33.16; we keep dashes as a portability habit.
"""
import argparse
import json
import os
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "drift" / "manifest.json"
LOCK = ROOT / "drift" / "lock.json"
TWB = "64"
PKG_ROOT = os.environ.get("DRIFT_PKG_ROOT", os.environ.get("DRIFT_PACKAGE_ROOT", ""))

# web-client compiles need the jwt+rest sources + the net-tls package dep.
CLIENT_EXTRA = ["--package-root", PKG_ROOT,
                "--src-root", "packages/web-jwt/src", "--src-root", "packages/web-rest/src"]

# (artifact, test_root, extra_flags) — coverage for the `test` gate.
TEST_ROOTS = [
    ("web-jwt",    "packages/web-jwt/tests/unit",    []),
    ("web-jwt",    "packages/web-jwt/tests/e2e",     []),
    ("web-rest",   "packages/web-rest/tests/unit",   []),
    ("web-rest",   "packages/web-rest/tests/e2e",    []),
    ("web-client", "packages/web-client/tests/unit", ["--package-root", PKG_ROOT]),
    ("web-client", "packages/web-client/tests/e2e",  CLIENT_EXTRA),
]


def resolve_artifact(artifact):
    manifest = json.loads(MANIFEST.read_text())
    arts = {a["name"]: a for a in manifest.get("artifacts", [])}
    target = arts.get(artifact)
    if not target:
        sys.exit(f"error: artifact {artifact!r} not in manifest")
    resolved = {}
    if LOCK.exists():
        lock = json.loads(LOCK.read_text())
        resolved = (lock.get("artifacts", {}).get(artifact, {}) or {}).get("resolved", {}) or {}
    src_dirs, deps = set(), []
    for mod in target.get("modules", []):
        src_dirs.add(os.path.dirname(mod))
    for dep in target.get("package_deps", []):
        name, ver = dep["name"], dep["version"]
        co = arts.get(name)
        if co:
            for mod in co.get("modules", []):
                src_dirs.add(os.path.dirname(mod))
        else:
            rv = resolved.get(name, {}).get("version") or ver
            deps.append(f"{name}@{rv}")
    return src_dirs, deps


def parse_extra(extra):
    pkg_roots, src_roots, i = [], [], 0
    while i < len(extra):
        if extra[i] == "--package-root":
            pkg_roots.append(extra[i + 1]); i += 2
        elif extra[i] == "--src-root":
            src_roots.append(extra[i + 1]); i += 2
        else:
            i += 1
    return pkg_roots, src_roots


def src_files(src_roots):
    files = []
    for r in src_roots:
        p = ROOT / r
        if p.is_dir():
            files += sorted(str(f.relative_to(ROOT)) for f in p.glob("*.drift"))
    return files


def build_context(artifact, extra):
    """Return (srcs:list, pkg_flags:list) for compiling against `artifact`."""
    pkg_roots, extra_src = parse_extra(extra)
    manifest_src, deps = resolve_artifact(artifact)
    srcs = src_files(extra_src + sorted(manifest_src))
    pkg_flags = []
    for pr in pkg_roots:
        pkg_flags += ["--package-root", pr]
    for d in deps:
        pkg_flags += ["--dep", d]
    return srcs, pkg_flags


def is_test_entry(rel):
    txt = (ROOT / rel).read_text(errors="ignore")
    return bool(re.search(r"^module\s+", txt, re.M)) and bool(re.search(r"^fn\s+main\(", txt, re.M))


def module_of(rel):
    m = re.search(r"^module\s+(.+?);?\s*$", (ROOT / rel).read_text(errors="ignore"), re.M)
    return m.group(1).strip().rstrip(";") if m else None


def driftc_build(out_name, srcs, pkg_flags, entry, test_rel, sanitize=False):
    """A build job that compiles test_rel to {work}/<out_name>."""
    san = ["--sanitize", "address"] if sanitize else []
    out = f"{{work}}/{out_name}"
    cmd = ["{driftc}", "--target-word-bits", TWB] + pkg_flags + san + \
          ["--entry", entry] + srcs + [test_rel, "-o", out]
    return {"id": out_name, "out": out, "cmd": cmd}


def infer_context(rel):
    """(artifact, extra) for an arbitrary file path under packages/<pkg>/..."""
    if rel.startswith("packages/web-jwt/"):
        return "web-jwt", []
    if rel.startswith("packages/web-rest/"):
        return "web-rest", []
    if rel.startswith("packages/web-client/"):
        return "web-client", CLIENT_EXTRA
    sys.exit(f"error: cannot infer artifact for {rel}")


# ---------------------------------------------------------------- gate: test
def emit_test():
    build, check = [], []
    for artifact, test_root, extra in TEST_ROOTS:
        srcs, pkg_flags = build_context(artifact, extra)
        leaf = os.path.basename(test_root)
        troot = ROOT / test_root
        for tf in sorted(troot.glob("*.drift")) if troot.is_dir() else []:
            rel = str(tf.relative_to(ROOT))
            if not is_test_entry(rel):
                continue
            qual = f"{artifact}-{leaf}-{tf.stem}"   # unique across roots; dot-free
            entry = f"{module_of(rel)}::main"
            build.append(driftc_build(f"{qual}#plain", srcs, pkg_flags, entry, rel))
            build.append(driftc_build(f"{qual}#asan", srcs, pkg_flags, entry, rel, sanitize=True))
            check.append({"id": f"{qual}#run-plain", "cmd": [f"{{work}}/{qual}#plain"], "needs": [f"{qual}#plain"]})
            check.append({"id": f"{qual}#run-memcheck", "cmd": [f"{{work}}/{qual}#plain"], "needs": [f"{qual}#plain"], "wrap": "memcheck"})
            check.append({"id": f"{qual}#run-asan", "cmd": [f"{{work}}/{qual}#asan"], "needs": [f"{qual}#asan"]})
    return {"name": "test", "phases": [{"name": "build", "jobs": build}, {"name": "check", "jobs": check}]}


# ---------------------------------------------------------------- gate: perf (build-only)
GO_BENCHES = [("raw_tcp_bench", "benchmarks/go/raw_tcp_bench.go"),
              ("net_http_bench", "benchmarks/go/net_http_bench.go")]
PERF_SMOKE = "packages/web-rest/tests/perf/perf_smoke_test.drift"


def emit_perf():
    jobs = [{"id": name, "out": f"{{work}}/{name}",
             "cmd": ["go", "build", "-o", f"{{work}}/{name}", path]} for name, path in GO_BENCHES]
    srcs, pkg_flags = build_context("web-rest", [])
    jobs.append(driftc_build("perf_smoke_test", srcs, pkg_flags, f"{module_of(PERF_SMOKE)}::main", PERF_SMOKE))
    return {"name": "perf-build", "phases": [{"name": "build", "jobs": jobs}]}


# ---------------------------------------------------------------- gate: stress (build-only)
STRESS_BINS = [
    ("stress_test",            "web-rest",   [],           "packages/web-rest/tests/stress/stress_test.drift"),
    ("tls_contamination_test", "web-client", CLIENT_EXTRA, "packages/web-client/tests/stress/tls_contamination_test.drift"),
    ("pool_stale_test",        "web-client", CLIENT_EXTRA, "packages/web-client/tests/stress/pool_stale_test.drift"),
]


def emit_stress():
    jobs = []
    for out_name, artifact, extra, rel in STRESS_BINS:
        srcs, pkg_flags = build_context(artifact, extra)
        jobs.append(driftc_build(out_name, srcs, pkg_flags, f"{module_of(rel)}::main", rel))
    return {"name": "stress-build", "phases": [{"name": "build", "jobs": jobs}]}


# ---------------------------------------------------------------- gate: consumer (build-parallel)
# Downstream consumer programs compiled against the STAGED .zdmp packages (no
# package source compiled in). The harness (run-consumer-tests.sh) does the
# `drift deploy` staging, then this plan parallelizes the per-program compiles
# (previously a serial raw-driftc loop — every compile now uses the flocker pool).
# (name, entry, src, needs_ext_pkgs, [dep package names])
CONSUMER_TESTS = [
    ("jwt_compile_test",              "consumer.jwt_compile_test::main",              "tests/consumer/jwt_compile_test.drift",              False, ["web-jwt"]),
    ("rest_startup_test",             "consumer.rest_startup_test::main",             "tests/consumer/rest_startup_test.drift",             False, ["web-rest", "web-jwt"]),
    ("rest_serve_test",               "consumer.rest_serve_test::main",               "tests/consumer/rest_serve_test.drift",               False, ["web-rest", "web-jwt"]),
    ("rest_sequential_test",          "consumer.rest_sequential_test::main",          "tests/consumer/rest_sequential_test.drift",          False, ["web-rest", "web-jwt"]),
    ("rest_throws_test",              "consumer.rest_throws_test::main",              "tests/consumer/rest_throws_test.drift",              False, ["web-rest", "web-jwt"]),
    ("rest_throws_implicit_wrap_test", "consumer.rest_throws_implicit_wrap_test::main", "tests/consumer/rest_throws_implicit_wrap_test.drift", False, ["web-rest", "web-jwt"]),
    ("rest_or_throw_test",            "consumer.rest_or_throw_test::main",            "tests/consumer/rest_or_throw_test.drift",            False, ["web-rest", "web-jwt"]),
    ("rest_middleware_test",          "consumer.rest_middleware_test::main",          "tests/consumer/rest_middleware_test.drift",          False, ["web-rest", "web-jwt"]),
    ("rest_ctx_test",                 "consumer.rest_ctx_test::main",                 "tests/consumer/rest_ctx_test.drift",                 False, ["web-rest", "web-jwt"]),
    ("client_compile_test",           "consumer.client_compile_test::main",           "tests/consumer/client_compile_test.drift",           True,  ["web-client", "net-tls"]),
]


def emit_consumer(pkg_staging):
    man = json.loads(MANIFEST.read_text())
    ver = {a["name"]: a["version"] for a in man.get("artifacts", [])}
    if LOCK.exists():
        lock = json.loads(LOCK.read_text())
        nt = (lock.get("artifacts", {}).get("web-client", {}).get("resolved", {}) or {}).get("net-tls", {})
        if nt.get("version"):
            ver["net-tls"] = nt["version"]
    build, run = [], []
    for name, entry, src, ext, deps in CONSUMER_TESTS:
        pkg = ["--package-root", pkg_staging] + (["--package-root", PKG_ROOT] if ext else [])
        depflags = []
        for d in deps:
            depflags += ["--dep", f"{d}@{ver[d]}"]
        out = f"{{work}}/{name}"
        build.append({"id": name, "out": out,
                      "cmd": ["{driftc}", "--target-word-bits", TWB] + pkg + depflags + ["--entry", entry, src, "-o", out]})
        # Build once, run both lanes (memcheck reuses the same binary via needs).
        run.append({"id": f"{name}#run-plain", "cmd": [out], "needs": [name]})
        run.append({"id": f"{name}#run-memcheck", "cmd": [out], "needs": [name], "wrap": "memcheck"})
    return {"name": "consumer", "phases": [{"name": "build", "jobs": build}, {"name": "run", "jobs": run}]}


# ---------------------------------------------------------------- dev: one / compile
def emit_one(rel):
    """Build + run a single test (plain) for fast dev iteration."""
    if not is_test_entry(rel):
        sys.exit(f"error: {rel} is not an executable test entry (module + fn main)")
    artifact, extra = infer_context(rel)
    srcs, pkg_flags = build_context(artifact, extra)
    name = Path(rel).stem
    build = [driftc_build(name, srcs, pkg_flags, f"{module_of(rel)}::main", rel)]
    run = [{"id": f"{name}#run", "cmd": [f"{{work}}/{name}"], "needs": [name]}]
    return {"name": "one", "phases": [{"name": "build", "jobs": build}, {"name": "run", "jobs": run}]}


def emit_compile(rel):
    """Type-check a file against its artifact's sources — no entry, no output, no run.
    Works for a src file (e.g. lib.drift) or a test file."""
    artifact, extra = infer_context(rel)
    srcs, pkg_flags = build_context(artifact, extra)
    extra_file = [] if rel in srcs else [rel]   # avoid passing a src file twice
    cmd = ["{driftc}", "--target-word-bits", TWB] + pkg_flags + srcs + extra_file
    return {"name": "compile", "phases": [{"name": "compile", "jobs": [{"id": "compile-check", "cmd": cmd}]}]}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("gate", choices=["test", "perf", "stress", "consumer", "one", "compile"])
    ap.add_argument("--file", help="test file (for one|compile)")
    ap.add_argument("--pkg-staging", help="staged-package dir (for consumer)")
    ap.add_argument("--out", default="-")
    args = ap.parse_args()
    if args.gate in ("one", "compile"):
        if not args.file:
            sys.exit("error: --file required for one|compile")
        plan = emit_one(args.file) if args.gate == "one" else emit_compile(args.file)
    elif args.gate == "consumer":
        if not args.pkg_staging:
            sys.exit("error: --pkg-staging required for consumer")
        plan = emit_consumer(args.pkg_staging)
    else:
        plan = {"test": emit_test, "perf": emit_perf, "stress": emit_stress}[args.gate]()
    text = json.dumps(plan, indent=2)
    if args.out == "-":
        print(text)
    else:
        Path(args.out).write_text(text)
        n = sum(len(p["jobs"]) for p in plan["phases"])
        print(f"wrote {args.out}: {plan['name']} plan, {n} jobs across {len(plan['phases'])} phase(s)", file=sys.stderr)


if __name__ == "__main__":
    main()
