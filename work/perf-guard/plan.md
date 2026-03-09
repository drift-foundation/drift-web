# Performance Guard — Plan

Status: implemented
Date: 2026-03-09

## Goal

Protect the optimized `web.rest` performance work from major regressions without turning performance testing into a flaky default test gate.

This guard is meant to catch:

1. large framework regressions
2. large transport/runtime regressions
3. accidental benchmark harness regressions

It is not meant to:

1. prove cross-machine benchmark claims
2. replace full `perf-test`
3. fail on normal run-to-run noise

## Design change from v1

v1 used hardcoded absolute req/sec thresholds. That breaks silently when benchmark hardware changes — a faster machine passes trivially, a slower machine fails spuriously.

v2 uses **same-run Go baselines as the reference**. Go exercises the same kernel, scheduler, TCP stack, and loopback path on the same machine at the same time. Drift ratios against Go are hardware-adaptive: if the machine is slower, both Go and Drift slow down proportionally, and the ratio stays stable.

Go availability is **required** for `perf-smoke`.

## What stays

1. `just perf-test`
- full side-by-side benchmark, human-readable
- includes Go baselines + Drift baselines
- used for release-level and investigation-level benchmarking

2. existing perf decomposition/instrumentation tests
- kept for debugging
- not part of the guard gate

## New guard

Add a separate recipe:

- `just perf-smoke`

This recipe:
- runs Go raw-tcp and Go net/http baselines
- runs Drift baseline-vt and baseline-health (optimized)
- computes three ratios
- enforces conservative ratio thresholds
- prints compact pass/fail summary with all measured values

It does not run:
- memcheck
- asan
- decomposition/instrumentation suites

## Measured values

All four benchmarks run on the same machine in the same invocation:

1. `go-raw-tcp` — Go raw TCP loopback, no framework
2. `go-net-http` — Go net/http server, minimal handler
3. `drift-baseline-vt` — Drift raw TCP loopback on VT fiber, no framework
4. `drift-baseline-health` — Drift REST framework, GET /health, keep-alive

## Derived ratios

### 1. `drift_raw_ratio = drift_baseline_vt / go_raw_tcp`

What it measures: Drift's raw TCP/scheduler efficiency vs Go's raw TCP/scheduler efficiency.

Interpretation:
- ~1.0 means Drift and Go are at parity for raw loopback.
- < 1.0 means Drift is slower than Go at the transport layer.
- A drop in this ratio without framework changes means a runtime/scheduler/codegen regression.

### 2. `drift_rest_ratio = drift_baseline_health / go_net_http`

What it measures: Drift REST framework throughput vs Go net/http throughput for an equivalent minimal handler.

Interpretation:
- > 1.0 means Drift REST is faster than Go net/http for this workload.
- A drop in this ratio means the Drift framework lost ground vs Go's framework.
- This is the primary "are we still competitive" signal.

### 3. `drift_framework_ratio = drift_baseline_health / drift_baseline_vt`

What it measures: how much throughput the REST framework consumes relative to the raw transport floor.

Interpretation:
- 0.60 means the framework adds ~40% overhead vs raw TCP.
- A drop in this ratio (without a corresponding drop in drift_raw_ratio) means the framework itself got slower.
- This is Drift-internal only: no Go dependency, pure framework overhead signal.

## Observed ratio ranges

Data from 8 runs on the current benchmark host (driftc 0.27.19-dev, optimized):

| Ratio | Min | Max | Median |
|-------|-----|-----|--------|
| `drift_raw_ratio` | 0.978 | 1.143 | 1.04 |
| `drift_rest_ratio` | 1.902 | 2.118 | 2.02 |
| `drift_framework_ratio` | 0.560 | 0.647 | 0.60 |

## Proposed thresholds

### Pass conditions

All of the following must hold:

1. `drift_raw_ratio >= 0.80`
2. `drift_rest_ratio >= 1.50`
3. `drift_framework_ratio >= 0.45`

### Rationale

**`drift_raw_ratio >= 0.80`** (observed min: 0.978)

- ~20% headroom below the worst observed run.
- A value below 0.80 means Drift's raw TCP loop is 20%+ slower than Go's — this would indicate a significant runtime or codegen regression.
- The threshold is generous because raw TCP variance is low and both runtimes exercise the same kernel path.

**`drift_rest_ratio >= 1.50`** (observed min: 1.902)

- ~21% headroom below the worst observed run.
- Drift REST currently runs at 2x Go net/http. Falling below 1.5x would mean losing a substantial portion of the framework advantage.
- Go net/http has higher run-to-run variance than raw TCP (33K–37K), which inflates ratio variance slightly. The 1.50 floor absorbs this.

**`drift_framework_ratio >= 0.45`** (observed min: 0.560)

- ~20% headroom below the worst observed run.
- A value below 0.45 means the REST framework is consuming more than 55% of raw TCP throughput — that's a major framework regression.
- This ratio is the most Drift-internal signal and the most stable across hardware changes.

### Failure interpretation

1. `drift_raw_ratio` fails, other two healthy
   - runtime/scheduler/codegen regression, not framework
   - investigate Drift runtime or toolchain change

2. `drift_raw_ratio` healthy, `drift_rest_ratio` + `drift_framework_ratio` fail
   - framework regression
   - investigate web.rest dispatch/parse/serialize path

3. `drift_raw_ratio` + `drift_rest_ratio` fail, `drift_framework_ratio` healthy
   - transport-level regression dragging REST down proportionally
   - framework itself is fine, runtime is the issue

4. All three fail badly
   - environment/toolchain issue or broad regression

## Are all three ratios needed?

**`drift_framework_ratio` is partially redundant with the other two.** If `drift_raw_ratio` and `drift_rest_ratio` are both healthy, `drift_framework_ratio` is necessarily in range (you can't have good raw and good REST-vs-Go but bad framework overhead — the math doesn't work out).

However, `drift_framework_ratio` has a unique diagnostic role:

- It is the **only ratio that is purely Drift-internal**. It doesn't depend on Go stability at all.
- If Go has an unusually fast or slow run, `drift_raw_ratio` and `drift_rest_ratio` shift, but `drift_framework_ratio` stays stable.
- It gives the clearest "did the framework itself regress?" signal.

**Recommendation: keep all three.** The redundancy is mild, the diagnostic clarity is worth it, and the implementation cost of one extra integer division is zero.

## Scope of enforcement

This guard is machine-local and requires:

1. Go toolchain available (`go` in PATH)
2. optimized Drift toolchain (DRIFT_OPTIMIZED=1)
3. client/server both on VT fibers

Because of that:
- `perf-smoke` is not part of the default `just test`
- `perf-smoke` is a staging/release/pre-merge quality gate for maintainers

## Output contract

`perf-smoke` prints:

1. All four raw req/sec values (diagnostic, not gating)
2. All three computed ratios
3. Per-ratio pass/fail with threshold
4. Overall PASS or FAIL

Example (passing):

```text
[perf-smoke] go-raw-tcp req_per_sec=113636
[perf-smoke] go-net-http req_per_sec=34722
[perf-smoke] baseline-vt req_per_sec=119047
[perf-smoke] baseline-health req_per_sec=73529
[perf-smoke] drift_raw_ratio=1.04
[perf-smoke] drift_rest_ratio=2.11
[perf-smoke] drift_framework_ratio=0.61
[perf-smoke] PASS
```

Example (failing):

```text
[perf-smoke] go-raw-tcp req_per_sec=113636
[perf-smoke] go-net-http req_per_sec=34722
[perf-smoke] baseline-vt req_per_sec=50000
[perf-smoke] baseline-health req_per_sec=25000
[perf-smoke] drift_raw_ratio=0.44
[perf-smoke] drift_rest_ratio=0.72
[perf-smoke] drift_framework_ratio=0.50
[perf-smoke] FAIL drift_raw_ratio 0.44 < 0.80
[perf-smoke] FAIL drift_rest_ratio 0.72 < 1.50
[perf-smoke] FAIL (2 threshold(s) violated)
```

## Implementation approach

### Recipe shape

```just
perf-smoke:
    @echo "=== Go baselines ==="
    @go run benchmarks/go/raw_tcp_bench.go
    @go run benchmarks/go/net_http_bench.go
    @echo ""
    @echo "=== Drift perf guard (optimized) ==="
    @DRIFT_OPTIMIZED=1 tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/perf/perf_smoke_test.drift \
      --target-word-bits 64
```

Wait — this doesn't work. The Go baselines print to stdout but the Drift test can't read them. Two options:

### Option A: Shell orchestration

Run Go benchmarks, capture their output, parse req/sec values, pass them as arguments or environment variables to the Drift test.

- Pro: Go and Drift are separate processes, clean isolation.
- Con: Requires output parsing or a structured format from Go benchmarks.

### Option B: All-in-Drift with Go subprocess

The Drift test spawns Go benchmarks as subprocesses and reads their output.

- Pro: Single test binary, all logic in one place.
- Con: Drift has no subprocess/exec API.

### Option C (preferred): Shell wrapper script

A small shell script in `tools/` that:
1. Runs Go raw-tcp benchmark, captures req/sec
2. Runs Go net-http benchmark, captures req/sec
3. Passes both values as environment variables to the Drift smoke test
4. Drift smoke test reads env vars, runs its own benchmarks, computes ratios, enforces thresholds

This keeps threshold logic in Drift, keeps Go benchmark execution in shell, and is straightforward.

The Go benchmarks already print `req_per_sec=N` in their output; parsing a single integer from a known line format is not brittle.

### Implementation file list

1. `packages/web-rest/tests/perf/perf_smoke_test.drift` — Drift benchmarks + ratio logic + threshold enforcement. Reads `GO_RAW_REQ_PER_SEC` and `GO_HTTP_REQ_PER_SEC` from environment via `std.env.get()`.
2. `tools/perf_smoke_runner.sh` — Shell wrapper: runs Go, captures req/sec values, exports as env vars, invokes Drift test.
3. Justfile `perf-smoke` recipe calls `tools/perf_smoke_runner.sh`.

### Drift environment variable access

Uses `std.env` (available since driftc 0.27.22-dev, ABI 5):
- `env.get(name: String) -> Optional<String>` — read env var
- `env.has(name: String) -> Bool` — check existence

The Drift smoke test reads `GO_RAW_REQ_PER_SEC` and `GO_HTTP_REQ_PER_SEC` via `env.get()`, parses them with `parse.parse_int()`, and uses the values as Go baseline denominators for ratio computation.

## Validation gates

1. `just perf-smoke`
2. `just perf-test`
3. `just test`
4. `just stress-test`

## Non-goals

1. per-commit mandatory CI on every developer machine
2. dynamic/adaptive thresholds beyond same-run Go comparison
3. cross-machine statistical normalization
4. public benchmark publishing
