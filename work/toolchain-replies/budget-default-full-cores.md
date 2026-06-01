# Re: `drift_pytest_jobs` returning `ceil(physical/2)` — yes, fixed (0.33.17)

**From:** toolchain team
**To:** drift-web
**Re:** "are we going to fix the half-cores default?"

**Yes. Landing in 0.33.17: the default is now the full physical core count, not
`ceil(physical/2)`.** On a 16-physical / 32-logical box the default `pytest -n`
width goes 8 → 16.

## Why we flipped it (you were right)

The half-default existed to hedge against *un-coordinated* concurrent lanes
summing past the host. But that's exactly the scenario `flocker` prevents by
construction: lanes wrapped under a shared flocker key run **one at a time**, so
a second lane can't start while the first holds the slot. And the dev-loop
(`just test`) runs lanes sequentially anyway. So in every world except
"orchestrator fans lanes out *without* a shared flocker key," the half-default
was just leaving half the box idle for nothing.

The clincher: the toolchain now flocker-manages its own lanes (the consolidation
pilot — our uniform pytest lanes run through `drift_test_run` as serial flocker
jobs), so full-cores is safe *by construction* here. We're not going to tax every
box with a half default to protect a coordination gap that proper flocker usage
closes.

## Where the burden now sits

Two cases own their own trimming — not the global default:
- **An orchestrator running lanes concurrently without a shared flocker key** —
  that caller must trim (`DRIFT_TEST_JOBS`) or, better, flocker-wrap its lanes
  under one key so the cap composes. (Note: the cap only composes across a
  **shared** key — two lanes on different keys each get a full slot.)
- **A RAM-heavy lane that OOMs at full cores** (e.g. valgrind on a small host) —
  mark it `mode: serial` in its plan, or set `DRIFT_TEST_JOBS`.

`DRIFT_TEST_JOBS` still overrides the default and always wins, so nobody is
blocked or surprised without an escape hatch.

## What this means for you

- Your gate gets full-core lane width for free on 0.33.17 — the half-idle-box
  problem from your report (#5b) is gone, and **without** a per-phase budget
  field (which we declined): serialize RAM-bound phases with `mode: serial`, let
  CPU-bound compile lanes run at full cores.
- If any specific lane OOMs on a constrained CI box, that lane sets
  `DRIFT_TEST_JOBS` or goes `serial` — it's a per-lane decision, not a reason to
  re-cap the whole default.
- Until you're on 0.33.17 you can get the same effect today by setting
  `DRIFT_TEST_JOBS=<physical-core-count>` on your gate.

## Shipping

- `pytest_jobs.py` / bundled `lib/tools/drift_pytest_jobs.py` default →
  full physical cores. DRIFTC 0.33.16 → 0.33.17 (bundled artifact change; no
  compiler/ABI change, ABI stays 15).
- Pairs with the runner-consolidation pilot landing the same day (toolchain
  dogfoods `drift_test_run`), which is what makes full-cores safe by construction.

— toolchain team (0.33.17)
