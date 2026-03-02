# Baseline Performance Tests — Plan

## Goal

Establish a repeatable baseline for `web.rest` end-to-end request handling
before adding more ergonomics or protocol features. The objective is to
measure current cost, not to enforce hard pass/fail thresholds yet.

This suite is for:
- latency baselines
- throughput baselines
- relative overhead comparisons between server paths
- regression tracking over time

This suite is **not** for:
- correctness validation (covered by unit/integration/stress suites)
- memory checking
- ASAN / Valgrind execution
- cross-framework comparisons yet

## Execution policy

Performance numbers must be collected without diagnostics that distort timing.

Rules:
- run with normal runtime only
- do **not** run under `DRIFT_MEMCHECK=1`
- do **not** run under `DRIFT_ASAN=1`
- do **not** combine with stress/unit suites in the same recipe

Required dedicated recipe:

```just
rest-perf:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/perf/perf_test.drift \
      --target-word-bits 64
```

This recipe stays separate from:
- `just test`
- `just rest-check-par`
- `just rest-stress`

## Test file

Single file:
- `packages/web-rest/tests/perf/perf_test.drift`

Single-process benchmark harness using real TCP against `serve()`.

The perf file should duplicate only the minimal helpers it needs from
`server_test.drift` / `stress_test.drift`:
- server lifecycle helper
- raw HTTP roundtrip helper
- byte/string helpers

No shared test imports are assumed.

## Measurement philosophy

Initial perf suite should emit stable comparative numbers, not hard limits.

For each benchmark:
1. warm up briefly
2. run fixed-count measured iterations
3. record elapsed wall-clock millis
4. derive:
   - total millis
   - avg millis/request
   - req/sec (integer approximation is fine)

Output should be human-readable and deterministic enough to compare runs.

Example output shape:

```text
perf: baseline-health total_ms=120 avg_us=240 req_per_sec=4166
perf: jwt-guard total_ms=410 avg_us=820 req_per_sec=1219
```

Do not fail on absolute timing yet. Fail only on:
- server error
- malformed benchmark result
- missing response
- unexpected HTTP status/body

## Runtime constraints to respect

- Current server is single-connection-at-a-time in the accept loop.
- HTTP behavior is `Connection: close`, one request per TCP connection.
- No keep-alive, no chunked encoding, no TLS.
- Results are machine-dependent; comparisons matter more than raw values.

Because the server is sequential today, concurrency benchmarks should be
treated as backlog/queue pressure observations, not throughput scaling claims.

## Benchmark scenarios

### 1. Baseline health roundtrip

**Name:** `baseline-health`

**What:**
- real TCP
- `GET /health`
- no filters
- no guards
- tiny JSON response

**Why:**
- establishes the minimum end-to-end server cost:
  - accept
  - read
  - parse
  - dispatch
  - serialize
  - write
  - close

**Method:**
- warmup: 20 requests
- measured: 500 requests sequentially

**Record:**
- total millis
- avg per request
- req/sec

### 2. Static route vs path-param route

**Names:**
- `route-static`
- `route-path-param`

**What:**
- compare `GET /health`
- vs `GET /users/{id}`

**Why:**
- isolates router/path extraction overhead relative to pure static match

**Method:**
- same request count and warmup for both
- handler work kept equally trivial

**Record:**
- both timings
- delta summary

### 3. Filter overhead

**Names:**
- `no-filter`
- `one-filter`
- `two-filters`

**What:**
- same route/response
- compare 0, 1, and 2 cheap filters

**Why:**
- quantify middleware chain overhead

**Filter shape:**
- lightweight context or request-observing filter
- no heavy string building or JSON parsing

### 4. Guard overhead

**Names:**
- `no-guard`
- `trivial-guard`
- `jwt-guard`

**What:**
- compare:
  - no guard
  - guard that immediately returns `Ok`
  - JWT HS256 guard with valid token

**Why:**
- quantify the cost of auth path over baseline

**JWT benchmark notes:**
- use one valid token shape
- keep secret/policy fixed
- avoid mixing expired/invalid/error cases into the perf path

### 5. Request-shape parser cost

**Names:**
- `req-minimal`
- `req-query`
- `req-json-body`
- `req-many-headers`

**What:**
- same health/echo-style server path
- vary request complexity:
  - minimal GET
  - GET with query params
  - POST with JSON body
  - GET with moderate header count

**Why:**
- identify parser/input-shape sensitivity

### 6. Response-size cost

**Names:**
- `resp-small`
- `resp-medium`
- `resp-large`

**What:**
- small: tiny JSON body
- medium: ~1KB body
- large: ~12KB body

**Why:**
- quantify serialization/write cost growth

**Notes:**
- large response should reuse the same handler style already proven in stress

### 7. Error-path cost

**Names:**
- `not-found`
- `bad-request-malformed`
- `unauthorized-jwt`

**What:**
- benchmark representative non-happy paths

**Why:**
- error envelopes are part of real workload
- gives baseline for failure handling cost

**Scope:**
- one routing miss
- one malformed request path
- one JWT unauthorized path

Keep this smaller than happy-path loops if needed, but still measured.

## Non-goals for initial perf suite

Do not include yet:
- cross-framework comparison
- flamegraph/profiler integration
- CPU pinning or advanced benchmark harness
- multi-process load generation
- parallel-client throughput claims
- latency percentile tracking

Those can come later after the first baseline is stable.

## Output requirements

At end of run, print one line per benchmark plus a short summary section.

Include:
- benchmark name
- iterations
- total ms
- avg us or ms/request
- req/sec

Optional:
- relative multiplier vs `baseline-health`

## Stability guidance

To reduce noise:
- use fixed iteration counts
- avoid sleeping in benchmark path
- avoid logging per request
- warm up before timing
- keep benchmark server setup deterministic

Prefer measuring steady-state request loops over repeated bind/start/stop.
Lifecycle cost is useful, but separate from steady-state request cost.

## Verification

Required gates:
1. `just rest-perf` — runs and prints benchmark table
2. `just test` — remains green and unchanged
3. `just rest-stress` — remains green and unchanged

Explicitly not required:
- `DRIFT_MEMCHECK=1 just rest-perf`
- `DRIFT_ASAN=1 just rest-perf`

## Deliverable order

Implement in this sequence:
1. `perf_test.drift` harness + `baseline-health`
2. route comparison (`route-static`, `route-path-param`)
3. middleware/auth comparisons
4. parser/response/error-path comparisons
5. output cleanup and documentation of how to read the numbers

Stop after step 1 for review before growing the benchmark matrix.
