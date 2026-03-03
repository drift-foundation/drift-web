# Performance Report: Stdlib Allocation Bottleneck

**Date:** 2026-03-02
**Author:** web.rest team
**Audience:** Stdlib team
**Severity:** Critical — 680x gap between VT floor and framework throughput
**Depends on:** VT runtime optimizations (delivered — see previous report)

## Summary

After the VT runtime optimizations, the raw TCP loopback floor rose from
~4,200 to **~66,000 req/sec** — now competitive with Go/Tokio. However,
the REST framework remains stuck at **~97 req/sec**, unchanged. The gap
widened from 48x to **680x**.

The entire bottleneck is now in **framework-level allocations caused by
missing stdlib primitives**. Every HTTP request/response cycle performs
~35-40 heap allocations through byte-by-byte loops, because the stdlib
lacks bulk data movement operations. The framework cannot work around
these gaps — the primitives don't exist.

## Benchmark results (post VT runtime fix)

**baseline-vt** — zero-allocation TCP echo (VT floor):

| Run | iters | total_ms | avg_us | req/sec |
|-----|-------|----------|--------|---------|
| 1   | 5000  | 77       | 15     | 64,935  |
| 2   | 5000  | 74       | 14     | 67,567  |
| 3   | 5000  | 75       | 15     | 66,666  |

**Median: ~66,000 req/sec, ~15µs per round-trip.**

**baseline-health** — full REST framework, GET /health, `{"ok":true}`:

| Run | iters | total_ms | avg_ms | req/sec |
|-----|-------|----------|--------|---------|
| 1   | 500   | 5131     | 10     | 97      |
| 2   | 500   | 5092     | 10     | 98      |
| 3   | 500   | 5120     | 10     | 97      |

**Median: ~97 req/sec, ~10ms per request.**

**Gap: 680x.** The VT runtime delivers 15µs round-trips. The framework
adds ~10ms of allocation overhead on top.

**Repro:**

```sh
# VT baseline
tools/drift_test_parallel_runner.sh run-one \
  --src-root packages/web-jwt/src --src-root packages/web-rest/src \
  --test-file packages/web-rest/tests/perf/baseline_vt_test.drift \
  --target-word-bits 64

# REST framework
tools/drift_test_parallel_runner.sh run-one \
  --src-root packages/web-jwt/src --src-root packages/web-rest/src \
  --test-file packages/web-rest/tests/perf/perf_test.drift \
  --target-word-bits 64
```

## What the framework does per request

Benchmark workload: `GET /health HTTP/1.1\r\nHost: localhost\r\n\r\n`
→ `HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: 13\r\nConnection: keep-alive\r\n\r\n{"ok":true}`

One request touches ~40 bytes in, ~90 bytes out. The actual data
processing is trivial. The cost is entirely in how data moves between
representations.

## Per-request allocation map

### Phase 1: Read request bytes (`http.drift`, `read_one_request`)

```
io.buffer(4096)                          — 1 heap alloc (read buffer)
conn_buf.push() × ~40                   — ~40 individual push calls
                                           (byte-by-byte from io.buffer → Array<Byte>)
Remainder: var new_buf: Array<Byte> = [] — 1 heap alloc
           new_buf.push() × remaining   — byte-by-byte copy
           *conn_buf = move new_buf      — dealloc old + assign new
```

**Missing primitive: `Array.extend()` to bulk-append buffer contents.**
**Missing primitive: `Array.clear()` to empty without dealloc.**
**Missing primitive: `Array.truncate()` / `Array.remove_range()` to
remove consumed bytes without copying remainder to a new array.**

### Phase 2: Parse HTTP headers (`http.drift`, `_parse_request_full`)

```
_bytes_to_string(raw, 0, 3)             — "GET":  io.buffer(3) + 3 byte copies + string alloc
_bytes_to_string(raw, 4, 11)            — "/health": io.buffer(7) + 7 byte copies + string alloc
_bytes_to_string(raw, hdr_pos, colon)   — "Host": io.buffer(4) + 4 byte copies + string alloc
_bytes_to_string(raw, val_start, end)   — "localhost": io.buffer(9) + 9 byte copies + string alloc
_dup_string(&hdr_value)                 — redundant copy of "localhost" (framework bug, fixable)
```

Content-Length parsing (for requests that have one):
```
_bytes_to_string(raw, start, end)       — string alloc just to call parse_int
_dup_string(&val_str)                   — another redundant copy
parse.parse_int(string)                 — requires String, can't parse from bytes
```

**Missing primitive: `parse_int` variant that accepts byte range
(`Array<Byte>`, start, end), avoiding string allocation entirely.**

### Phase 3: Construct Request object (`request.drift`)

```
var keys: Array<String> = []             — 1 heap alloc (query param keys)
var values: Array<String> = []           — 1 heap alloc (query param values)
var hk: Array<String> = []               — 1 heap alloc (header keys)
var hv: Array<String> = []               — 1 heap alloc (header values)
var ppk: Array<String> = []              — 1 heap alloc (path param keys)
var ppv: Array<String> = []              — 1 heap alloc (path param values)
```

6 empty array allocations. 4 of the 6 are never populated for this
request (no query params, no path params).

### Phase 4: Dispatch (`app.drift`, `server.drift`)

```
mem.replace(&mut p.req, new_request("",""))  — 8 allocs (6 arrays + 2 strings)
                                               for a dummy Request, just to extract
                                               the real one (framework bug, fixable)
var resp_to_write = json_response(500, "")   — 1 alloc for dummy response (fixable)
"evt-" + fmt.format_int(counter)             — 1-2 string allocs (event ID)
router.split_path(&req.path)                 — 1 array alloc + 1 io.buffer (substring)
clear_path_params(req)                       — 2 empty array allocs (even when no params)
```

### Phase 5: Serialize response (`http.drift`, `serialize_response`)

**This is the single largest allocation hotspot.**

```
fmt.format_int(200)                      — 1 string alloc ("200")
fmt.format_int(13)                       — 1 string alloc ("13")
"HTTP/1.1 " + status_str                 — 1 string alloc (12 bytes)
  + " " + reason                         — 1 string alloc (15 bytes)
  + "\r\nContent-Type:...\r\nContent-Length: " — 1 string alloc (63 bytes)
  + body_len_str                         — 1 string alloc (65 bytes)
  + "\r\nConnection: "                   — 1 string alloc (79 bytes)
  + conn_hdr                             — 1 string alloc (89 bytes)
  + "\r\n\r\n"                           — 1 string alloc (93 bytes)
  + resp.body                            — 1 string alloc (106 bytes)
```

**8 intermediate string allocations.** Each `+` allocates a new string
and copies all preceding bytes into it. Total bytes copied across all
intermediates: ~520 bytes to produce a 106-byte result. **O(n²)
complexity.**

```
_string_to_bytes(&line)                  — 1 Array<Byte> alloc + ~106 push() calls
```

**Missing primitive: string builder that accumulates into a mutable
buffer and produces a String (or directly an `io.Buffer`) at the end.**

### Phase 6: Write response (`http.drift`, `write_response`)

```
var buf = io.buffer(remaining)           — 1 heap alloc
byte-by-byte copy from Array<Byte>       — ~106 individual buffer_write() calls
stream.write(&buf, timeout)              — actual I/O
```

**Missing primitive: `io.buffer_write_bytes(buf, offset, arr, start, len)`
and `io.buffer_write_string(buf, offset, str)` to bulk-copy without
byte-by-byte loops.**

## Allocation summary

| Phase | Allocations | Bytes copied | Dominant cost |
|-------|-------------|-------------|---------------|
| Read request | 2-3 | ~80 | push() loop, remainder copy |
| Parse headers | 5-7 | ~50 | _bytes_to_string, redundant _dup_string |
| Construct Request | 6 | 0 | Empty array allocs |
| Dispatch | 12-13 | ~20 | Dummy Request, split_path, clear_params |
| Serialize response | 10-11 | ~520 | String concat chain (O(n²)) |
| Write response | 1 | ~106 | buffer_write loop |

**Total: ~35-40 heap allocations per request, ~780 bytes copied through
byte-by-byte loops.**

For comparison, the zero-allocation baseline does the same TCP I/O
with 0 allocations and achieves 680x the throughput.

## Missing stdlib primitives

Six primitives are needed. Each one removes a category of allocation
from the hot path. They are listed in priority order — the top items
unlock the largest gains.

### 1. String builder (or `io.Buffer` as string accumulator)

**Impact: eliminates ~10 allocations and O(n²) copying per response.**

Current pattern (every HTTP response):
```drift
var line = "HTTP/1.1 " + status + " " + reason
    + "\r\nContent-Type: application/json\r\nContent-Length: "
    + body_len + "\r\nConnection: " + conn_hdr
    + "\r\n\r\n" + body;
```

Each `+` allocates a new String and copies all prior bytes. 8 concat
operations on a ~106-byte result produce ~520 bytes of intermediate
copies.

**What's needed:** a mutable accumulator that appends string fragments
without intermediate allocations, then produces a final String or
`io.Buffer`. Possible forms:

- `StringBuilder` type with `.append(s)` and `.build() -> String`
- Or allow `io.Buffer` to serve this role, with
  `io.buffer_write_string(buf, offset, str) -> Int` to append a
  string's bytes and return the new offset

Either form eliminates all intermediate string allocations and reduces
copying to a single pass.

### 2. `io.buffer_write_string(buf, offset, str)` and `io.buffer_write_bytes(buf, offset, arr, start, len)`

**Impact: eliminates byte-by-byte loops in all buffer construction.**

Current pattern (every response write, every request read-to-buffer):
```drift
var i = 0;
while i < n {
    io.buffer_write(&mut buf, i, core.string_byte_at(s, i));
    i = i + 1;
}
```

This appears in response serialization, request buffer construction,
and TCP write preparation. Each call site loops byte-by-byte.

**What's needed:**
```
io.buffer_write_string(buf: &mut Buffer, offset: Int, s: &String) -> Int
io.buffer_write_bytes(buf: &mut Buffer, offset: Int, src: &Array<Byte>, start: Int, len: Int) -> Int
```

These can be implemented as `memcpy` internally — a single operation
replacing N loop iterations.

### 3. `Array.extend(src)` or `Array.append_from(src, start, len)`

**Impact: eliminates byte-by-byte push loops in socket read accumulation.**

Current pattern (every socket read):
```drift
var j = 0;
while j < n {
    conn_buf.push(io.buffer_read(&mut buf, j));
    j = j + 1;
}
```

Each `.push()` checks capacity, potentially reallocates, and copies one
byte. For a 200-byte request, that's 200 individual push calls.

**What's needed:**
```
fn extend(self: &mut Array<T>, src: &Array<T>) -> Void
```
Or a variant that copies from an `io.Buffer` range into an array.
Internally: one `reserve()` + one `memcpy`.

### 4. `Array.clear()`

**Impact: eliminates dealloc/realloc cycle on keep-alive connection
buffers.**

Current pattern (every keep-alive request, connection buffer reset):
```drift
var empty: Array<Byte> = [];
*conn_buf = move empty;
```

This deallocates `conn_buf`'s backing storage and replaces it with a
new zero-capacity array. The next request re-grows from zero via
repeated push() reallocations.

**What's needed:**
```
fn clear(self: &mut Array<T>) -> Void
```

Sets length to 0 without deallocating. Capacity is preserved for reuse
on the next request.

### 5. `Array.truncate(len)` and/or `Array.remove_range(start, end)`

**Impact: eliminates remainder-copy allocation in keep-alive buffer
management.**

Current pattern (every keep-alive request, remove consumed bytes):
```drift
var new_buf: Array<Byte> = [];
var k = 0;
while k < remaining {
    new_buf.push(conn_buf[consumed + k]);
    k = k + 1;
}
*conn_buf = move new_buf;
```

Allocates a new array, copies the remainder byte-by-byte, deallocates
the old array. For a buffer with 5 remaining bytes, this is 1 alloc +
5 pushes + 1 dealloc.

**What's needed:**
```
fn remove_range(self: &mut Array<T>, start: Int, end: Int) -> Void
```

Shifts elements in-place via `memmove` and adjusts length. No allocation.

Alternatively, `truncate(len)` paired with a drain/shift operation.

### 6. `parse.parse_int_bytes(arr, start, end)`

**Impact: eliminates string allocation for integer parsing from byte
buffers.**

Current pattern (Content-Length header parsing):
```drift
val val_str = _bytes_to_string(raw, val_start, line_end);  // alloc string
match parse.parse_int(_dup_string(&val_str)) {              // alloc dup, then parse
```

Two heap allocations just to parse "13" → 13.

**What's needed:**
```
fn parse_int_bytes(arr: &Array<Byte>, start: Int, end: Int) -> Result<Int, ParseError>
```

Direct digit scanning on the byte array. Zero allocations.

## Framework-side fixes (no stdlib changes needed)

These are bugs in our framework code that we'll fix regardless:

1. **Redundant `_dup_string` calls** — `_bytes_to_string` already returns
   a fresh owned String. Passing it through `_dup_string` before
   `add_header` is a needless copy. (~2 allocs per request)

2. **Dummy Request in `_dispatch_and_write`** — `mem.replace(&mut p.req,
   new_request("",""))` creates a throwaway Request (6 empty arrays)
   just to extract the real one. We can pass `&mut p.req` to dispatch
   directly. (~8 allocs per request)

3. **Unconditional `clear_path_params`** — allocates 2 empty arrays on
   every dispatch, even for routes with no path parameters. (~2 allocs
   per request)

These framework fixes will remove ~12 allocations per request, but the
remaining ~23 allocations are gated on stdlib primitives.

## Expected impact

With all stdlib primitives + framework fixes, we estimate the per-request
allocation count drops from ~35 to ~5-8, and byte-copy volume drops from
~780 to ~200 (single-pass, no O(n²) concat). This should bring the
framework into the 1,000-10,000+ req/sec range — the exact number depends
on the implementation cost of the remaining allocations (Request struct
construction, path splitting).

## Repro and profiling

Both benchmarks are self-contained and run in seconds:

```sh
# VT floor — confirms runtime is fast
tools/drift_test_parallel_runner.sh run-one \
  --src-root packages/web-jwt/src --src-root packages/web-rest/src \
  --test-file packages/web-rest/tests/perf/baseline_vt_test.drift \
  --target-word-bits 64

# REST framework — shows allocation bottleneck
tools/drift_test_parallel_runner.sh run-one \
  --src-root packages/web-jwt/src --src-root packages/web-rest/src \
  --test-file packages/web-rest/tests/perf/perf_test.drift \
  --target-word-bits 64
```

`perf record` on the REST framework binary will show time spent in
array growth, string allocation, and byte-by-byte copy loops.

We're happy to add targeted micro-benchmarks for any specific primitive
if that helps prioritize the stdlib work.
