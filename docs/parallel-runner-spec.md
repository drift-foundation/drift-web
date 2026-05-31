# Generic phased job runner — plan / execute

Status: **ON HOLD — stand by for the next toolchain release.** (Toolchain memo
2026-05-31.) The `--sanitize` flag is accepted for the next release; this
runner+plan-format promotion is a **separate RFC**, explicitly decoupled from the
flag. Before the engine is built it must reconcile with the toolchain's existing
`pytest_jobs.py` / `tools/pytest_jobs.py` + flocker lane, and resolve who owns the
host-global job budget once jobs invoke `drift build` (driver) rather than `driftc`.
drift-web is the proving ground; `just test`'s two-phase split already ships.

## Principle

There is **one primitive: a job** — a command plus a declaration of *how it
wants to run*. Everything else is generic structure around jobs. Nothing is
special-cased:

- "compile" / "run" are not types — they're just **phases** (ordered stages).
- "test" / "perf" / "stress" are not types — they're just **named plans**
  (bundles of phases/jobs). The name is context for humans, not behavior.
- "driftc" / "go build" / "valgrind" are not types — a job just carries its own
  `cmd`. Tomorrow it's rustc/javac; the engine doesn't care.
- **parallel is not assumed.** A phase is not intrinsically parallel — *each job*
  declares `mode: serial|parallel`. Our compiles happen to be parallel; that's
  data in the plan, not a rule in the engine. A serial compile (daemon, contended
  linker) is just a job with `mode:"serial"`.

The engine is dumb: it executes phases in order; within a phase it runs the
parallel jobs concurrently (bounded by the flocker key) and the serial jobs per
their grouping. It knows nothing about compilers, languages, or gate names.

## Why it scales (private + orchestrator)

Same engine, same plan format, two callers. What composes them is that
**`flocker --key drift-jobs -j N` is a host-global semaphore**: any number of
private runs plus the orchestrator contend on one key, so total concurrent
*parallel jobs* is bounded by N regardless of how many coordinators run. No
central scheduler, no OOM cascade — composition is the default.

## Phases are separable

```
plan     GATE --plan-out PATH         # side-effect-free; writes the job plan to PATH (NOT stdout)
execute  --plan PATH --work-dir DIR    # runs the phases; parallel jobs share the flocker key
```

`plan` writes to a caller-given path (stdout is polluted by tool warnings/link
noise, so it is never the plan channel). Private use: a temp file, then
`execute`. Orchestrator: harvest each gate's plan to its own path, then either
`execute` each, or merge plans and `execute` once for global scheduling.

## Plan format (JSON)

A plan is a name + an ordered list of phases; a phase is a list of jobs. The
invoker chooses the work dir; jobs reference it via the `{work}` placeholder so
plans are relocatable (enables machine-split + recipe isolation).

```json
{
  "name": "test",
  "phases": [
    {
      "name": "build",
      "jobs": [
        {
          "id": "sign_verify_test#plain",
          "cmd": ["{driftc}", "--target-word-bits", "64",
                  "--entry", "web.jwt.tests.unit.sign_verify_test::main",
                  "packages/web-jwt/src/lib.drift", "...srcs...",
                  "packages/web-jwt/tests/unit/sign_verify_test.drift",
                  "-o", "{work}/bins/sign_verify_test#plain"],
          "mode": "parallel"
        },
        {
          "id": "sign_verify_test#asan",
          "cmd": ["{driftc}", "--target-word-bits", "64", "--sanitize", "address",
                  "...", "-o", "{work}/bins/sign_verify_test#asan"],
          "mode": "parallel"
        }
      ]
    },
    {
      "name": "check",
      "jobs": [
        {"id": "run#plain#sign_verify",    "cmd": ["{work}/bins/sign_verify_test#plain"],
         "mode": "parallel", "needs": ["sign_verify_test#plain"]},
        {"id": "run#memcheck#sign_verify", "cmd": ["valgrind","--tool=memcheck","--error-exitcode=97","--leak-check=full","{work}/bins/sign_verify_test#plain"],
         "mode": "parallel", "needs": ["sign_verify_test#plain"]},
        {"id": "run#asan#sign_verify",     "cmd": ["{work}/bins/sign_verify_test#asan"],
         "mode": "parallel", "needs": ["sign_verify_test#asan"]}
      ]
    }
  ]
}
```

### Job fields
- `id` — unique within the plan; targets of `needs`.
- `cmd` — full argv. **All variation lives here as explicit flags** (re 1: no
  reliance on ambient env). Placeholders the engine substitutes: `{work}` (work
  dir), `{driftc}` (compiler — for test-file/ad-hoc compiles), `{drift}` (driver —
  only for manifest-artifact build+deploy), `{jobs}` (the flocker slot N).
- `mode` — `parallel` (eligible for the flocker-bounded concurrent batch) or
  `serial`.
- `group` (serial only) — serial jobs sharing a group run one-at-a-time in
  `order`; distinct groups (and parallel jobs) may run concurrently. A phase
  whose only jobs are one serial group ⇒ nothing else runs during it (the idle-box
  case falls out, no special flag).
- `order` (serial only) — sequence within the group.
- `env` (optional) — explicit per-job env overlay, applied to *that* invocation
  only. Preferred shape is flags in `cmd`; `env` is the explicit escape hatch for
  a tool that only accepts env (still explicit data in the plan, never inherited
  ambient pollution). **Interim ASAN case:** until the next toolchain release
  ships `drift build --sanitize`, the asan build job uses
  `"env":{"DRIFT_ASAN":"1"}` (one-line swap to `--sanitize address` when it lands;
  flag wins over the deprecated env alias).

> **RESOLVED (toolchain): test-file build jobs use `{driftc}` directly.** `driftc`
> and `drift build` are co-equal, split by workflow: ad-hoc / single-file /
> explicit-`--entry` / test-file compiles → `{driftc}`; only manifest-declared
> artifact build+deploy → `{drift} build`. Our test compiles are textbook
> `driftc`, so the asan build job is also a direct `driftc --sanitize=address …`
> call — `--sanitize` selects the matching asan runtime archive itself, so there's
> no `drift build` hop and no `DRIFT_ASAN` env overlay. **(Pending: `--sanitize`
> ships in the next staged release; until then the asan job keeps the
> `DRIFT_ASAN=1` env path.)**
- `needs` (optional) — job ids that must finish first. With phase barriers this
  is advisory; a fine-grained scheduler can start a job the moment its `needs`
  are met, before the whole phase completes.

### Dedup
Dedup is just two jobs sharing an output path / one build job that several run
jobs depend on. memcheck adds **no build job** — its run job's `cmd` invokes
valgrind on the *plain* binary (`needs` the plain build). The plan states the
reuse; the engine doesn't special-case it.

## Gate plans (all expressed with the same primitive)

| Gate (named plan) | build phase jobs | run phase jobs |
|---|---|---|
| **test** | each test × {plain, asan}, all `mode:parallel` | per test: plain-run, memcheck-run (valgrind on plain bin), asan-run — all `mode:parallel` |
| **stress** | 3 binaries, `mode:parallel` | A: `mode:parallel`; B,C: `mode:serial group:"https" order:0,1` |
| **perf** | drift smoke + the go-build jobs, all `mode:parallel` | go-raw, go-http, drift-smoke: `mode:serial group:"measure" order:0,1,2` (sole group in the phase ⇒ idle box) |

Go is not special: its build is a `cmd:["go","build","-o","{work}/bins/raw_tcp_bench",...]`
job in the build phase, and its measurement is a serial run job — same as any
other. Harness glue a plan can't express (start the HTTPS server; capture a Go
binary's stdout rps into the next job's env) is handled by the gate's wrapper
bracketing `execute`, or modeled as a serial job whose `cmd` is a small script.

## Recipe isolation & orchestrator
Each plan execution gets its own `--work-dir`; plans never reuse each other's
artifacts → orchestrator can machine-split gates across boxes. Coarse
integration: orchestrator runs each `just <gate>` (flocker key composes the
global pool, nothing new needed). Fine integration: harvest plans, merge,
`execute` once. Both work because `plan` is separable and side-effect-free.

## Promotion (separate RFC — decoupled from --sanitize)
The toolchain team accepted `--sanitize` on its own and explicitly held the
runner/plan-format promotion as its **own RFC**. That RFC must:
- **Reconcile with what already exists** in the toolchain — `pytest_jobs.py` /
  `tools/pytest_jobs.py` and the existing **flocker lane**. The goal is one
  mechanism, not a parallel one; this may be an extension of those rather than a
  new tool.
- **Resolve the global-budget ownership** now that jobs invoke `drift build`
  (driver): is the primitive still "flocker-wrap each job," or does the driver
  take a host-global job budget and self-schedule (it may already parallelize /
  run as a daemon)? The driver's model decides the engine's.
- Subsume mariadb's `run-batch` (a plan with a parallel build phase + a serial
  run phase — no special mode) and keep each project owning only a small `plan`
  emitter.

Promotion is a drift-lang change requiring re-cert; coordinate, don't drop into
the certified tree. **Do not build the generic engine until the next release
lands and this RFC proceeds.**
```
