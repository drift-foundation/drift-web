# Re: your reference-migration report — decisions + what's landing

**From:** toolchain team
**To:** drift-web
**Re:** the 5 findings from your `drift_test_run` adoption, and what we're doing about each

Your reference migration did exactly what a reference migration should: it
proved the runner works at scale (170 jobs, 0 failed, parity, fork retired) and
surfaced the real friction for team #2. Here's our disposition of each finding,
plus a decision of our own that came out of working through them.

## The headline decision: the toolchain will dogfood the runner

The most convincing proof for mariadb/net isn't docs — it's the toolchain running
**its own** test gate through `drift_test_run`. So we're migrating our justfile's
uniform pytest lanes onto the runner, as a pilot:

- 12 byte-identical `lang-<suite>-test` recipes (stage1–4, parser, core, llvm,
  borrow, type_checker, method_registry, packages, traits) — each carrying a
  duplicated pytest/xdist preamble — collapse to **one data-driven emitter**
  (`tools/emit_test_plan.py`) + **one `drift_test_run` invocation**.
- Each lane is a `mode: serial` job on a shared flocker key: **one pytest lane at
  a time host-wide, each fanning out internally** to the budgeted xdist width.
  (See "concurrency model" below — this is the resolution of your #5b.)
- The two non-uniform shard-1 lanes (`driver`, with its own `DRIVER_JOBS`
  override; `gdb`, single-process and env-gated) stay as recipes this round and
  join in a later phase.

Two motivations: (1) prove the model end-to-end on a real, heavy gate; (2) our
justfile is too fat and there are too many ways to slice tests today — this
consolidates them onto one mechanism. If it's good enough for the toolchain's own
gate, that's the adoption argument for everyone else.

## Concurrency model (resolves #5b — per-phase budget)

We're **not** adding a per-phase `phase.jobs` budget. Instead:

- **pytest/e2e lanes are black boxes that multiprocess internally.** flocker treats
  each as a single **serial** job (the slot is held for the whole lane); the
  lane's *internal* width comes from our budget env var. This is the same
  treatment a daemon-like or internally-parallel compiler job gets — flocker
  counts the lane, not its children.
- Because lanes are flocker-serialized (one at a time), each lane can safely use a
  **higher internal core count** without two lanes summing past the host. That
  removes the "single pool leaves half the box idle" problem you hit, without a
  new plan-format field.
- The RAM-bound case you raised (memcheck) is handled by the *existing* `serial`
  group, not a new budget axis: mark RAM-heavy jobs `mode: serial` on a shared
  group and they won't stack — no global budget reduction needed.
- `DRIFT_TEST_JOBS` remains the single override knob and always wins.

(Note: the default budget value — `ceil(physical/2)` vs full physical cores — is a
separate change we're treating on its own; the consolidation above lands first and
is independent of it. We did not bundle a default-flip into the pilot.)

## Disposition of the other findings

**#1 — ship a reference plan emitter: YES (as an example, not a `drift` subcommand).**
You're right that the emitter is the real adoption cost. We're shipping
`tools/emit_test_plan.py` as the toolchain's own reference emitter — it's the one
driving the dogfood above, so it's a *worked, exercised* example, not a toy. We
are **not** adding a `drift emit-plan` subcommand: baking manifest→argv resolution
into `drift` would couple the executor to manifest semantics, the exact thing we
kept it ignorant of. The emitter stays a per-context script; ours is the template.

**#2 — warn on same-`out`/different-`id` collision: YES, accepted.**
A colliding `out` mis-dedupes silently today. We'll have the runner WARN when two
jobs with **different `id`s** resolve to the **same `out`** (same-id or genuinely
shared build stays quiet). Cheap; turns a silent wrong-result into a visible
signal. Landing with the next runner change.

**#3 — document "harness brackets execute" (perf/stress): YES, doc.**
The executor runs jobs; it can't pipe one job's stdout into another's env or own a
server lifecycle. We'll add a worked example to `doc/test-run.md` showing the
perf rps→env and stress server-lifecycle cases as harness-bracketed (executor owns
the parallel compile phase; the team harness brackets measurement/server).

**#4 — dev-loop ergonomics (`check-one`, compile-check): YES, doc + pattern.**
We'll document the `check-one FILE` (emit a one-test plan, run it) and
compile-check patterns so "drop the fork entirely" is actually achievable, not
just gate-level. Our own pilot collapses recipes the same way, so we'll standardize
what we use.

**#5 — `out` parent-dir creation: YES, runner fix.**
The runner mkdirs `work/` + `logs/` but not `out`'s parent, so the doc's own
`{work}/bins/...` example would fail. We'll mkdir each `out`'s parent in the
runner. Landing with #2.

## What lands, and when

- **Now (this pilot):** `emit_test_plan.py` (reference emitter) + the toolchain's
  uniform pytest lanes migrated to it; justfile shrinks; `doc/test-run.md` notes
  the toolchain dogfoods the runner. No compiler/ABI change — pure test tooling.
- **Next runner change:** #2 (collision warning) + #5 (mkdir out parent) — small,
  bundled.
- **Doc pass:** #3 (harness-brackets-execute worked examples) + #4 (dev-loop
  patterns).
- **Deferred / separate:** budget default value (`ceil/2` vs full cores); the
  remaining bespoke lanes (driver/gdb/e2e/ownership/memcheck) onto the runner;
  any `drift`-subcommand emitter (not planned).

## Thanks

Going first paid off twice over: your run already drove the 0.33.16 dotted-`-o`
parallel-safety fix and two plan-authoring rules, and now it's shaping how the
toolchain consolidates its own gates. mariadb/net inherit `emit_test_plan.py` +
your `tools/emit_test_plan.py` as worked starting points instead of rediscovering
the friction. Happy to take any of the doc items as PRs if you'd rather write
them from the adopter's seat.

— toolchain team
