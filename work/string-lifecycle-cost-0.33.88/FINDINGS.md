# String lifecycle cost regression — drift 0.33.87 → 0.33.88 (ABI 22 RcBytes)

> **RESOLVED in staged 0.33.89 (`affaae95`).** drift-lang `6921f01a` root-caused it
> independently: a per-call `getenv("DRIFT_STR_TRACE")` in `drift_string_release`
> (~18–20 ns × 27 releases per parsed request); the flag is now read once at init.
> drift-web validation on 0.33.89 (same benches as below): materialize 32 ms — exact
> 0.33.87 parity; parse 0.60×, route 0.44×, serialize 0.79× vs certified; REST health
> 185,185 rps vs certified 172,413; perf gate framework_cost 1.61 (threshold 2.11);
> the informational rest_ratio ≥ 1.40 passes for the first time on record. Asks 1 and 3
> are moot; ask 2 (alloc/drop-heavy carrier in the §8.6 regression fleet) still stands.

**From:** drift-web · **Date:** 2026-07-26 · **Repro:** all numbers on the cert host
(AMD Ryzen 9 9950X3D, machine 8bb9310c), drift-web `be5bc5c`, identical source both sides.
Certified = driftc 0.33.87/abi21 (`3d48b7f0`). Staged = driftc 0.33.88/abi22 (`32d676bb`).

## Summary

drift-web's perf certification gate failed on the 0.33.88 candidate
(run 20260726-124202: `framework_cost 2.13 > 2.11`). Attribution work isolated the
regression to **String lifecycle cost** — construct, move into struct/array, drop —
under the ABI-22 RcBytes representation (`205a0120`). Per-byte *read* paths got
dramatically faster (nice); per-*object* costs roughly doubled.

We are re-aligning drift-web to the new idiom (offset scanning, materialize only at
escape boundaries) per STRING-VIEW-PERFORMANCE-CHECKPOINT guidance, and that recovers
most of our gate headroom. This report is the compiler-side half: the per-object cost
increase is real, measured, and will tax any String-carrying code that cannot avoid
materialization (struct fields, arrays of String, API boundaries).

## Evidence

### 1. Orchestrator trend (drift-web perf gate, `baseline-health` REST path)

| toolchain | baseline-health rps | framework_cost |
|---|---|---|
| 0.33.84 (99a68ee), 2 runs | 161,290 / 161,290 | 1.96 / 1.96 |
| 79bbad3 | 166,666 | 1.89 |
| 0.33.87 (3d48b7f, certified) | 166,666 | 1.79 |
| **0.33.88 (32d676b), 3 runs** | **142,857 / 147,058 / 147,058** | **2.08 / 2.04 / 2.13** |

`baseline-vt` (raw io.buffer/Array<Byte> server, no String traffic) and both Go
baselines are flat across all runs — only the String-heavy REST path moved.

### 2. Interleaved local A/B, same host, 8 runs per side

Certified 0.33.87: health = 166,666 rps on **every** run.
Staged 0.33.88: health = 156,250–161,290 rps on **every** run. Raw-VT identical both sides.

### 3. Component microbenches (`packages/web-rest/tests/perf/pin_bench_test.drift`, 3 runs/side, spread <5%)

| block | 0.33.87 | 0.33.88 | delta |
|---|---|---|---|
| `http.parse_request` ×300k | ~240 ms | ~373 ms | **+56% (+450 ns/req)** |
| `router.split_path`+`match_route` ×1M | ~150 ms | ~257 ms | **+73% (+107 ns/call)** |
| `serialize_response` ×500k (string_builder) | ~258 ms | ~256 ms | flat |
| **7-byte String construct+drop ×2M** | **16 ns/op** | **34.5 ns/op** | **+18.5 ns (2.2×)** |
| String `==` ×2M | ~1.7 ns | ~2 ns | ~flat |
| `core.string_byte_at` scan (82 B ×200k) | 12 ms | 2 ms | **6× faster** |
| `Array<Byte>` scan (control) | 1 ms | 1 ms | flat |

### 4. The gap beyond materialization

Pure construct+drop (+18.5 ns) explains only ~40% of the parse/route regressions.
The route block contains exactly one 6-byte materialization yet regressed +107 ns/call;
parse regressed +450 ns against ~10 materializations. The remainder is broader
String *lifecycle* traffic: moves into struct fields (`Request`), `Array<String>`
push/element-drop, retain/release pairs. All of it appears to carry the new
per-object overhead (atomic u64 refcount RMWs, observation-validation on len/data,
contract checks active in release).

## Asks

1. Confirm whether the ~2.2× construct+drop cost is expected-and-accepted for B5, or
   has recoverable margin (e.g. non-atomic fast path for provably-unshared strings,
   cheaper constructor validation, drop-glue streamlining for fresh unshared strings).
2. The §8.6 before/after STOP gate measured byte-scan carriers (which improved).
   Suggest adding an **alloc/drop-heavy carrier** (materialization per token, arrays
   of String, struct-field churn) to the regression fleet — that's the shape that
   slipped through.
3. If the cost is accepted, please publish the per-object numbers so downstream
   perf baselines can re-attribute on facts (drift-web will re-baseline its
   framework_cost threshold accordingly).

## Repro

```
# both sides build the same plan; run pin_bench_test from each work dir
tools/emit_test_plan.py one --file packages/web-rest/tests/perf/pin_bench_test.drift
```
A/B driver scripts used for this report: ab_perf.sh / ab_pin.sh (session scratchpad;
trivially reconstructable — build with each toolchain, alternate runs).
