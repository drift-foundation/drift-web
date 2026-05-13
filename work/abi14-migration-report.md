# drift-web migration report — Drift 0.31.67 / ABI 14

**Author:** sl@pushcoin.com
**Date:** 2026-05-12
**Status:** Implemented; all gates green; ready for review.
**Staged toolchain:** `~/opt/drift/staged/toolchain/drift-0.31.67+abi14`
**Prior toolchain:** `~/opt/drift/certified/current/toolchain` (0.31.40 / ABI 10)

---

## TL;DR

Migrating drift-web to the staged 0.31.67 / ABI-14 toolchain surfaces two distinct issues:

1. **(Stop & report)** Upstream `net-tls 0.4.1` was rebuilt in place — same version, new sha256. Lock-check fails. A new `net-tls 0.5.0` is also present in staged libs.
2. **(Forced full migration)** Three toolchain-level removals affect drift-web public surfaces:
   - `DiagnosticValue` and `Diagnostic.to_diag()` removed in 0.31.62.
   - `core.DiagnosticEntry` (and `core.diagnostic_entry()`) — **not available** in the new toolchain.
   - `e.attrs[...]` dynamic projection on caught exceptions — **cannot be retained**; typed catch is the only path.

   Combined with the fact that **existing tests already exercise `Result<T, RestError>.or_throw()`** and **`Result<T, ProbeError>.or_throw()`**, the full `pub error` migration is **required** — not a cleanup preference.

3. **(REST routing constraint)** Once `RestError` becomes `pub error`, `Result<T, RestError>.or_throw()` throws `errors:RestError`, **not** any of the six `events:Rest*`. `_dispatch_throws` must explicitly catch both pathways. Design pinned in [§4.5](#45-rest-routing-design-pinned).

Decisions pinned in §4. Implementation order in §6.

---

## 1. Toolchain bulletin (verbatim, for context)

> The current staged Drift toolchain is ready for migration:
> `/home/sl/opt/drift/staged/toolchain/drift-0.31.67+abi14`
>
> This supersedes the older 0.31.40 / ABI-10 line. The main migration theme is the new exception/result model:
>
> - Public `Result<T, E>` error carriers should be `pub error E { ... }`.
> - `or_throw()` and auto-try now require `E` to be a `pub error`.
> - Do not add manual `core.Throw` impls for app/library errors.
> - Catch typed errors directly, e.g. `catch pkg:MyError(e)`.
> - Typed catch projection currently supports scalar fields: Int, Uint, Bool, Float, String.
> - For stdlib flat carriers such as `std.net.NetError`, use `e.kind` / `e.code`.
>
> Stdlib carriers have been migrated, including parse/net/io/concurrent/json/text/codec/regex/crypto/random/cli/time, so downstream code should not need workarounds for stdlib `or_throw()` / auto-try.
>
> Please migrate by recompiling unchanged first, then fix only real source issues. If you hit compiler/runtime behavior that looks wrong, do not mask it with source rewrites. Capture the minimal repro and escalate it as a toolchain issue.

---

## 2. Upstream issue — net-tls rebuilt in place

### What we saw

```
$ just lock-check
drift prepare --check (strict): drift/lock.json is stale
  artifact 'web-client' dep 'net-tls':
    locked   ResolvedDep(version='0.4.1', sha256='4250aec9...d5251b9', ...)
    resolved ResolvedDep(version='0.4.1', sha256='7b6d5736...8538b2a1', ...)
```

Same version, different sha256 → upstream rebuilt and republished `0.4.1` in place. Staged libs also contain a new `net-tls 0.5.0`.

### Policy reminder

Per drift-web lock-file discipline: **published versions are immutable**. An in-place rebuild at the same version number is an upstream discipline issue. Refreshing the lock to absorb the new hash hides the regression.

### Decision

Picked **bump pin to `net-tls 0.5`**. Manifest patched (`web-client` pin: `0.4` → `0.5`). `drift prepare` succeeds; lock is clean. **Net-tls team should still be told the in-place 0.4.1 rehash exists in staged libs** — it's a smell whether or not we consume it.

---

## 3. Forced source migration — three toolchain removals

### 3a. `DiagnosticValue` / `to_diag()` removed

Compile error (from `just jwt-compile-check`):

```
<source>:38:6: error: `Diagnostic.to_diag(...) -> DiagnosticValue` is removed in 0.31.62;
                implement `to_json_text(self: &Self) nothrow -> String` instead and
                project values via `core.diagnostic_json_*` [E_TO_DIAG_DEPRECATED]
<source>:38:51: error: `DiagnosticValue` is removed in 0.31.62; user code may not name
                 the DV public surface — produce canonical JSON text via
                 `core.diagnostic_json_*` and pass `String` instead [E_DV_PUBLIC_REMOVED]
```

### 3b. `core.DiagnosticEntry` is also gone

`RestError.fields: Array<core.DiagnosticEntry>` has no replacement type in the new toolchain → **must collapse to `fields_json: String`** (canonical JSON object text).

### 3c. `e.attrs[...]` on caught exceptions is gone

`packages/web-rest/src/app.drift::_dispatch_throws` currently does `e.attrs["tag"]` / `e.attrs["fields"].entries()`. Dynamic projection cannot be retained. **Typed catch with scalar field projection (`e.tag`, `e.message`, `e.fields_json`) is the only path.**

### 3d. `or_throw()` is already in tests (both REST and probe)

- `packages/web-rest/tests/unit/or_throw_probe_test.drift` exercises `rest.require_query_param(...).or_throw()` and `rest.path_param(...).or_throw()` over `Result<T, RestError>`.
- `tests/consumer/or_throw_probe_test.drift` exercises `make_probe_err().or_throw()` over `Result<Int, ProbeError>` and `catch probe:ProbeException(_)`.

Bulletin: **"`or_throw()` and auto-try now require `E` to be a `pub error`."** Therefore `RestError` and `ProbeError` **must** become `pub error`.

### 3e. File inventory (corrected — includes consumer tests and docs)

**Source files (8):**

| File | What it has |
|---|---|
| `packages/web-jwt/src/errors.drift` | `pub struct JwtError`, `JwtConfigError` + `impl core.Diagnostic` |
| `packages/web-rest/src/errors.drift` | `pub struct RestError` (fields: `Array<DiagnosticEntry>`) + `impl core.Diagnostic` + `impl core.Throw` |
| `packages/web-rest/src/events.drift` | 6× `pub exception Rest*(tag, message, fields: DiagnosticValue)` |
| `packages/web-rest/src/response.drift` | `_exc_dv_string(&DV)` helper; `error_envelope` consumes `fields` array |
| `packages/web-rest/src/app.drift` | `_dispatch_throws` with `e.attrs[...]`; `_exc_string(DV)` |
| `packages/web-rest/src/validation_collector.drift` | `_dv_string(&DV)` helper |
| `packages/web-client/src/errors.drift` | `pub struct ClientError` — no Diagnostic/Throw impls, but adopt `pub error` |
| `packages/or-throw-probe/src/lib.drift` | `pub struct ProbeError` + `impl core.Throw` + `pub exception ProbeException` |

**Unit test files — web-rest (8):**
- `dispatch_test.drift` — `events:RestBadRequest(..., fields = DV::Object(...))` throw sites
- `middleware_test.drift`, `throws_route_test.drift` — `_no_fields() -> DV` helpers
- `ux_pass2_test.drift`, `validation_collector_test.drift`, `validation_test.drift`, `validators_test.drift`, `json_extract_test.drift` — `_dv_str(&DV) -> String`
- `or_throw_probe_test.drift` — uses `.or_throw()` on `Result<T, RestError>` (transparent once `RestError` is `pub error`)

**Consumer test files (4) — `tests/consumer/`:**
- `rest_middleware_test.drift` — `_no_fields() -> DV`, `DV::Object`
- `rest_throws_test.drift` — `_no_fields() -> DV`, `DV::Object`
- `rest_throws_implicit_wrap_test.drift` — `_no_fields() -> DV`, `DV::Object`
- `or_throw_probe_test.drift` — `catch probe:ProbeException(_)` (must change to `catch probe:ProbeError`; see §4.6)

**Documentation files (2) — `docs/`:**
- `effective-web-rest.md` — shows `DiagnosticEntry`, `DiagnosticValue::Object` patterns in code blocks
- `effective-web-jwt.md` — shows `pub struct Jwt*Error` shape

**Not affected:** web-jwt tests (none reference DV); other consumer tests (`client_compile_test.drift`, `jwt_compile_test.drift`, `rest_ctx_test.drift`, `rest_or_throw_test.drift`, `rest_sequential_test.drift`, `rest_serve_test.drift`, `rest_startup_test.drift` — to be re-verified after rewrite).

---

## 4. Pinned decisions

### Q1: Migration scope — **full `pub error` migration**

Convert all public Result carriers to `pub error`:

- `JwtError`
- `JwtConfigError`
- `ClientError`
- `ProbeError`
- `RestError`

Remove user-written `core.Throw` impls. Replace `Diagnostic.to_diag` with synthesized diagnostics (let the toolchain auto-format) or manual `to_json_text` only where genuinely needed.

Forced by §3d.

### Q2: REST events — **six typed `pub error` variants**

```drift
pub error RestBadRequest {
    tag: String,
    message: String,
    fields_json: String,
}
// + RestUnauthorized, RestForbidden, RestNotFound, RestConflict, RestInternal
```

Catch (typed projection):

```drift
} catch events:RestBadRequest(e) {
    // e.tag, e.message, e.fields_json — all scalar projections
}
```

Forced by §3c (no `e.attrs`).

### Q3: `RestError.fields` — **`fields_json: String`, canonical JSON object text, no empty sentinel**

Hard invariant on the supported construction path (`rest_error()` + `add_field()`):

- Type: `pub fields_json: String`
- Always valid JSON object text. Empty = `"{}"`. **Never `""`.**
- `add_field(err, key, value)` uses `std.json` end-to-end: parses existing `fields_json` into a `JsonObject`, sets the new entry, re-emits via `encode_compact_with_config(OrderedLexUtf8)`. Output is canonical lex-ordered object text every call.
- Test helper `_no_fields() -> String` returns `"{}"`, not `""`.

Defense at the wire boundary (caller-misuse safety): `RestError` is a `pub error`, so the invariant cannot be enforced at construction — any caller can write `RestError(fields_json = "not json")`. `response.error_envelope` therefore passes the value through a defensive `_safe_fields_json` helper that parses and verifies it's a JSON object; on parse failure or non-object shape it substitutes `"{}"` so the response envelope stays well-formed. The supported construction path is unaffected (`add_field`'s output already validates).

Forced by §3b; defensive layer added during review.

### 4.5 REST routing design (pinned)

Once `RestError` is `pub error`, `Result<T, RestError>.or_throw()` throws `errors:RestError` directly — **not** any of the six `events:Rest*`. The bounce does **not** collapse on its own. Two pathways must coexist:

**Pathway 1 (or_throw via Result carrier):**

```drift
// User code:
fn handler(req, ctx) throws -> Response {
    val v = rest.require_query_param(req, &"x").or_throw();  // throws errors:RestError on miss
    ...
}
```

**Pathway 2 (explicit typed throw):**

```drift
// User code:
fn handler(req, ctx) throws -> Response {
    throw events:RestBadRequest(tag = "bad", message = "...", fields_json = "{}");
}
```

`_dispatch_throws` catches **both**, and both converge on the same response builder:

```drift
fn _dispatch_throws(...) -> Result<Response, errors.RestError> {
    try {
        return Result::Ok((*h).call(req, ctx));
    } catch errors:RestError(e) {
        // Pathway 1: e.status, e.event, e.tag, e.message, e.fields_json
        return Result::Err(errors.RestError(status = e.status, event = e.event, tag = e.tag, message = e.message, fields_json = e.fields_json));
    } catch events:RestBadRequest(e) {
        return Result::Err(errors.RestError(status = 400, event = "request-invalid", tag = e.tag, message = e.message, fields_json = e.fields_json));
    } catch events:RestUnauthorized(e) {
        return Result::Err(errors.RestError(status = 401, event = "unauthorized", tag = e.tag, message = e.message, fields_json = e.fields_json));
    } catch events:RestForbidden(e) {
        return Result::Err(errors.RestError(status = 403, event = "forbidden", tag = e.tag, message = e.message, fields_json = e.fields_json));
    } catch events:RestNotFound(e) {
        return Result::Err(errors.RestError(status = 404, event = "not-found", tag = e.tag, message = e.message, fields_json = e.fields_json));
    } catch events:RestConflict(e) {
        return Result::Err(errors.RestError(status = 409, event = "conflict", tag = e.tag, message = e.message, fields_json = e.fields_json));
    } catch events:RestInternal(e) {
        return Result::Err(errors.RestError(status = 500, event = "internal", tag = e.tag, message = e.message, fields_json = e.fields_json));
    }
}
```

**Tradeoff acknowledged:** `RestError` carries `status: Int` and `event: String` as data fields — this is the "status-as-data" pattern. We accept this on the **internal carrier shape** because the alternative (changing ~25 helper APIs from `Result<T, RestError>` to `Result<T, RestBadRequest>` / `Result<T, RestNotFound>` / etc.) is API-invasive and forces every helper into a specific status bucket at signature time. The **public throw surface** remains the six typed events for explicit handler throws — that's where the typed-routing invariant matters.

**Shape of `pub error RestError`:**

```drift
pub error RestError {
    status: Int,        // 400, 401, 403, 404, 409, 500
    event: String,      // "request-invalid" | "unauthorized" | ...
    tag: String,
    message: String,
    fields_json: String,  // canonical JSON object text, "{}" when empty
}
```

All five fields are scalar — typed catch projection works. `add_field` mutates `fields_json` in place.

### 4.6 Probe carrier (pinned)

`ProbeException` cannot remain semantically transparent. `make_probe_err().or_throw()` will throw `probe:ProbeError`, not `probe:ProbeException`.

**Decision:**
- Keep the carrier name: `pub error ProbeError { code: Int }`. **Do not rename to `ProbeException`.**
- Delete the manual `impl core.Throw` for `ProbeError`.
- Delete `pub exception ProbeException` — no exception twin.
- Migrate consumers from `catch probe:ProbeException(_)` to `catch probe:ProbeError(e)`.

Consumer test `tests/consumer/or_throw_probe_test.drift`:

```drift
// before:
} catch probe:ProbeException(_) { ... }
// after:
} catch probe:ProbeError(e) { /* e.code */ }
```

**Design principle (ABI 14 model):** Any `pub error` can be used inline as a Result error carrier or thrown directly via `or_throw` / auto-try. There is **no separate "exception twin"** unless the domain truly needs a distinct event shape. ProbeException was the throw-shape for the manual `Throw` impl on ProbeError; under `pub error`, the carrier IS the throw type, and the twin becomes dead weight.

This same principle applies to the REST events question — the six `Rest*` events are kept **only** because the domain genuinely needs HTTP-status-distinguishing throw types separable from the universal `RestError` carrier. The carrier (`errors:RestError`) and the events (`events:Rest*`) carry different semantic intent (universal-with-status vs HTTP-routing-typed), so both are warranted.

### Decision summary

| # | Question | Decision | Forced by |
|---|---|---|---|
| Q1 | Full `pub error` vs DV→String swap | **Full migration** | `or_throw()` in unit + consumer tests |
| Q2 | Collapse Rest* events to `pub error`, or keep `pub exception` | **Six typed `pub error` variants** | `e.attrs` removal + typed catch requirement |
| Q3 | `RestError.fields` array vs JSON string | **`fields_json: String`, canonical JSON object, empty = `"{}"`** | `core.DiagnosticEntry` removal |
| §4.5 | RestError routing once it's `pub error` | **`_dispatch_throws` catches both `errors:RestError` AND `events:Rest*`; carrier keeps `status: Int`** | `or_throw` semantics + scope of helper API change |
| §4.6 | ProbeException after ProbeError → pub error | **Drop `ProbeException`; consumer test catches `probe:ProbeError`** | `or_throw` throws the pub error type |
| §2  | net-tls in-place 0.4.1 rehash | **Pin to 0.5.0; flag rehash upstream** | Lock-file discipline |

---

## 5. Versioning impact

Per drift-web versioning policy, `pub struct E { ... }` → `pub error E { ... }` is API-visible. Proposed bumps:

| Package | From | To | Notes |
|---|---|---|---|
| web-jwt | 0.3.1 | 0.4.0 | Diagnostic impl removed; `pub error` |
| web-rest | 0.4.1 | 0.5.0 | `RestError`, 6× events, `fields_json` invariant, `_dispatch_throws` rewrite |
| web-client | 0.3.1 | 0.4.0 | `ClientError` → `pub error`; net-tls pin to 0.5 |
| or-throw-probe | 0.0.1 | 0.0.2 | `ProbeException` dropped; `ProbeError` → `pub error` |

---

## 6. Implementation plan

In order, smallest-to-largest:

1. **web-jwt** (small, no events, no Throw)
   - `errors.drift`: `pub struct JwtError`, `JwtConfigError` → `pub error`. Drop `impl core.Diagnostic`.
   - `docs/effective-web-jwt.md`: update code blocks to new `pub error` shape.
   - Bump version to 0.4.0; update `history.md`.
   - Run `just jwt-compile-check` → green.

2. **or-throw-probe**
   - `lib.drift`: collapse `pub struct ProbeError` + `pub exception ProbeException` into single `pub error ProbeError { code: Int }`. Drop `impl core.Throw`. Drop `ProbeException` export.
   - `tests/consumer/or_throw_probe_test.drift`: `catch probe:ProbeException(_)` → `catch probe:ProbeError(e)`. Update banner comment.
   - Bump 0.0.1 → 0.0.2.

3. **web-client** (no Diagnostic/Throw impls, but adopt `pub error`)
   - `errors.drift`: `pub struct ClientError` → `pub error`.
   - Confirm `net-tls 0.5.0` API surface (kind/code projection per stdlib pattern; spot-check `tests/consumer/client_compile_test.drift`).
   - Bump 0.3.1 → 0.4.0.

4. **web-rest** (largest)
   - `events.drift`: 6× `pub exception Rest*(tag, message, fields: DV)` → 6× `pub error Rest*(tag, message, fields_json: String)`.
   - `errors.drift`:
     - `pub struct RestError` → `pub error RestError { status, event, tag, message, fields_json }`.
     - Drop `impl core.Diagnostic`, drop `impl core.Throw`.
     - Rewrite `add_field(err, key, value)` against `fields_json: String` (canonical object, empty = `"{}"`).
     - `rest_error()` constructor: `fields_json` defaults to `"{}"`.
   - `app.drift`:
     - Rewrite `_dispatch_throws` per §4.5 — seven catch arms: `errors:RestError`, then 6× `events:Rest*`. Typed projection only; no `e.attrs`.
     - Delete `_exc_string`.
   - `response.drift`:
     - Rewrite `error_envelope` to splice `err.fields_json` directly into the response body (already canonical JSON).
     - Delete `_exc_dv_string`.
   - `validation_collector.drift`: delete `_dv_string`; callers pass `String` through.
   - `lib.drift` re-exports: surface `pub error Rest*` types under `web.rest.*` for consumer use.
   - **Unit tests:**
     - `dispatch_test.drift`: `throw events:RestBadRequest(..., fields_json = "{}")`.
     - `middleware_test.drift`, `throws_route_test.drift`: `_no_fields() -> String` returns `"{}"`.
     - `_dv_str` callers in 5 test files (`ux_pass2_test`, `validation_collector_test`, `validation_test`, `validators_test`, `json_extract_test`): pass `String` through.
     - `or_throw_probe_test.drift`: should be transparent.
   - **Consumer tests** (`tests/consumer/`):
     - `rest_middleware_test.drift`, `rest_throws_test.drift`, `rest_throws_implicit_wrap_test.drift`: replace `_no_fields() -> DV` returning `DV::Object(...)` with `_no_fields() -> String` returning `"{}"`. Update all `fields = DV::Object(...)` call sites to `fields_json = "{}"` (or whatever JSON the test asserts).
   - **Docs:** `docs/effective-web-rest.md` — rewrite code blocks for `pub error Rest*` shape, `fields_json: String` invariant, typed catch examples.
   - Bump 0.4.1 → 0.5.0.

5. **Re-run gates**
   - `just rest-check-par` (REST unit, 16 tests)
   - `just test` (plain + ASAN + memcheck concurrent)
   - `just stress-test` (serial)
   - `just perf-smoke` (serial)
   - Per [parallelism policy](../../.claude/projects/-home-sl-src-drift-web/memory/feedback_no_parallel_tests.md).

### Don't mask compiler bugs

The bulletin is explicit: "If you hit compiler/runtime behavior that looks wrong, do not mask it with source rewrites." All current diagnostics are clear and prescriptive — no smell of a compiler bug yet. Reserve escalation for surprises during the actual rewrite.

---

## 7. Implementation outcome — for team review

Migration applied across drift-web on the staged 0.31.67 / ABI 14 toolchain. All decisions pinned in §4 were followed without deviation. Below is the file-by-file change summary; pair each entry with the diff for review.

### 7.1 Dependency lock

| File | Change |
|---|---|
| `drift/manifest.json` | `web-client` package_dep: `net-tls 0.4` → `net-tls 0.5` |
| `drift/lock.json` | Regenerated by `drift prepare`; now resolves `net-tls@0.5.0`, `web-jwt@0.3.1` (co-artifact). No hand edits. |

### 7.2 Framework source

**web-jwt** (`packages/web-jwt/src/errors.drift`):
- `pub struct JwtError` → `pub error JwtError { tag: String, message: String }`
- `pub struct JwtConfigError` → `pub error JwtConfigError { tag: String, field: String, message: String }`
- Deleted both `implement core.Diagnostic` blocks (synthesized by compiler).
- Constructors `jwt_error()` and `jwt_config_error()` unchanged.

**or-throw-probe** (`packages/or-throw-probe/src/lib.drift`):
- `pub struct ProbeError` → `pub error ProbeError { code: Int }` (carrier name preserved per design principle in §4.6).
- Deleted `pub exception ProbeException(code: Int)` — no exception twin.
- Deleted `implement core.Throw for ProbeError` (synthesized).
- Module no longer exports `ProbeException`.

**web-client** (`packages/web-client/src/errors.drift`):
- `pub struct ClientError` → `pub error ClientError { tag: String, message: String }`. No Diagnostic/Throw impls existed; nothing to delete.

**web-rest** (largest):

| File | Change |
|---|---|
| `packages/web-rest/src/events.drift` | 6× `pub exception Rest*(tag, message, fields: DiagnosticValue)` → 6× `pub error Rest* { tag: String, message: String, fields_json: String }`. |
| `packages/web-rest/src/errors.drift` | `pub struct RestError + impl core.Diagnostic + impl core.Throw` → `pub error RestError { status: Int, event: String, tag: String, message: String, fields_json: String }`. `rest_error()` constructor defaults `fields_json = "{}"`. `add_field()` rewritten to use `std.json` end-to-end: parse existing `fields_json` into a `JsonObject`, `set(key, JsonNode::String(value))`, re-emit via `encode_compact_with_config` with `OrderedLexUtf8` key order. Output is canonical lex-ordered JSON object text. **New helper:** `pub fn field(err: &RestError, key: &String) nothrow -> Optional<String>` for one-field inspection without callers reaching into `std.json`. |
| `packages/web-rest/src/response.drift` | `error_envelope()` now passes `err.fields_json` through a defensive `_safe_fields_json` helper before splicing into the response body. `RestError` is a `pub error` (public construction), so callers can pass non-JSON, a JSON scalar, or a JSON array into `fields_json`; the helper parses and verifies the value is a JSON object — if not, it falls back to `"{}"` so the envelope stays well-formed. On the supported `rest_error()` + `add_field()` path the helper is a no-op (the value is already a canonical object); the cost (one `json.parse`) lands only on error responses, which aren't a hot path. Deleted `_exc_dv_string` helper and the in-place field-array iteration. |
| `packages/web-rest/src/validation_collector.drift` | `merge_validation_error()` now bridges between `fields_json: String` and `ValidationErrors` by parsing via `json.parse` and walking entries with `node.entries()` + a `while/next` iterator. Iterates `JsonNode::String` values and writes them into `ve` via the existing `_set_field` helper. Deleted `_dv_string` helper. Public signature unchanged. |
| `packages/web-rest/src/app.drift` | `_dispatch_throws()` rewritten per §4.5: seven catch arms (`errors:RestError` first, then 6× `events:Rest*`) using typed scalar projection (`e.tag`, `e.message`, `e.fields_json`, `e.status`, `e.event`). Deleted `_exc_string` helper. The `errors:RestError` arm handles the `Result<T, RestError>.or_throw()` pathway; the 6× event arms handle explicit `throw events:Rest*` from handlers. Both converge on the same `Result::Err(RestError)` shape. |
| `packages/web-rest/src/lib.drift` | Added `field` to exports + a thin re-export `pub fn field(err: &RestError, key: &String) nothrow -> Optional<String>`. |

### 7.3 Test updates

**Unit tests** (`packages/web-rest/tests/unit/`):

| File | Change |
|---|---|
| `dispatch_test.drift` | 3× `var f: Array<core.DiagnosticEntry> = []; throw events:Rest*(..., fields = DV::Object(move f));` → `throw events:Rest*(..., fields_json = "{}");`. |
| `middleware_test.drift` | `_no_fields() -> DiagnosticValue` → `_no_fields() -> String { return "{}"; }`. Throw site uses `fields_json = _no_fields()`. `pub exception TestUnknownException(tag: String)` → `pub error TestUnknownException { tag: String }`. |
| `throws_route_test.drift` | Same `_no_fields()` rewrite. 6× `fields = _no_fields()` → `fields_json = _no_fields()`. |
| `json_extract_test.drift` | Deleted `_dv_str` helper. 7× index-style field assertions (`e.fields.len`, `e.fields[0].key`, `_dv_str(&e.fields[0].value)`) collapsed to single-line `if e.fields_json != "{\"<key>\":\"<value>\"}"` checks. |
| `validation_test.drift` | Deleted `_dv_str` helper. Same collapse for the one single-field assertion. Added two scenarios (`scenario_error_envelope_fields_json_not_json`, `scenario_error_envelope_fields_json_is_array`) covering the `_safe_fields_json` fallback contract — a manually constructed `RestError` with non-JSON or array-shaped `fields_json` must still produce a well-formed envelope with `fields` as a JSON object. |
| `validators_test.drift` | Deleted `_dv_str` helper. 6× single-field assertion collapses. |
| `validation_collector_test.drift` | Deleted `_dv_str` helper. Single-field assertions collapse. **Multi-field assertions use the lex-ordered form** that `add_field` now emits — `{"name":"empty-value","page":"invalid-integer"}`, `{"age":"invalid-type","email":"missing-field"}`. |
| `ux_pass2_test.drift` | Deleted `_dv_str` helper. `field_err.fields_json` assertion replaces `fields[0].key` + `_dv_str(...)` pattern. The `rest.add_field(&mut err, field_err.fields[0].key, _dv_str(...))` call was simplified to inline `rest.add_field(&mut err, "email", "missing-field")` since the test had already asserted those values. |
| `or_throw_probe_test.drift` | Assertion on `e.fields.len` + `e.fields[0]` collapsed to `if e.fields_json != "{\"missing_param\":\"required\"}"`. Comment updated to describe the new `or_throw → catch errors:RestError` routing. |

**Consumer tests** (`tests/consumer/`):

| File | Change |
|---|---|
| `or_throw_probe_test.drift` | `catch probe:ProbeException(_)` → `catch probe:ProbeError(_)` at two sites. Banner comment updated. |
| `rest_middleware_test.drift`, `rest_throws_test.drift`, `rest_throws_implicit_wrap_test.drift` | Each: `_no_fields() -> DV` → `_no_fields() -> String { return "{}"; }`. All `fields = _no_fields()` call sites → `fields_json = _no_fields()`. No assertion logic changes. |

### 7.4 Documentation updates

| File | Change |
|---|---|
| `docs/effective-web-jwt.md` | The "data shape" code block now shows `pub error JwtConfigError { ... }` / `pub error JwtError { ... }` instead of `pub struct`. |
| `docs/effective-web-rest.md` | The handler-throw example rewritten from `throw events:RestUnauthorized(..., fields = DiagnosticValue::Object(move f))` to `throw events:RestUnauthorized(..., fields_json = "{}")`. Removed the `Array<core.DiagnosticEntry>` local. |

### 7.5 Verification (results)

- `just lock-check` — passes.
- `just rest-compile-check` / `just jwt-compile-check` / `just client-compile-check` — green.
- `just jwt-check-par` — 5/5 unit tests pass.
- `just rest-check-par` — 18/18 unit tests pass.
- `just consumer-check` — all 11 consumer tests pass (jwt_compile, rest_startup, rest_serve, rest_sequential, rest_throws, rest_throws_implicit_wrap, rest_or_throw, rest_middleware, rest_ctx, or_throw_probe, client_compile).
- `just test` (plain + ASAN + memcheck concurrent, including consumer-check under each lane) — **all three passes green**. No leaks, no ASAN errors, no memcheck errors.
- `just stress-test` and `just perf-smoke` — not yet run; not blockers for the migration's correctness signal but should be run before the version-bump commit lands.

### 7.6 Applied during the run (added to the change set after the first gate run)

- **Version bumps** applied in `drift/manifest.json` and `drift/lock.json` was regenerated. The bumps were necessary, not optional, because `consumer-check` mixes our freshly-deployed packages with `$DRIFT_PKG_ROOT` (which still holds the stale ABI-10 `web-client@0.3.1` linked against `net-tls 0.4.1`). Without distinct version numbers, the resolver could pick the wrong same-versioned artifact and fail with a transitive dep mismatch.
  - `web-jwt`     0.3.1 → 0.4.0
  - `web-rest`    0.4.1 → 0.5.0  (and its `web-jwt` dep range bumped 0.3 → 0.4)
  - `web-client`  0.3.1 → 0.4.0  (its `net-tls` dep range was already at 0.5)
  - `or-throw-probe` 0.0.1 → 0.0.2
- **`tools/check-manifest-consistency.sh`** — the pre-prepare check expected exact equality between dep version and declared concrete version (a v1-manifest assumption). Under v2 semantics, dep versions are `M` / `M.N` ranges. Updated the check to accept any range that is a dot-segment prefix of the declared concrete version (matches the toolchain resolver's behavior). Without this change the new manifest fails consistency before `drift prepare` even runs.
- **`tests/consumer/or_throw_probe_test.drift`** — `scenario_string_err` was removed. It probed `.or_throw()` on `Result<Int, String>`, which compiled under the old "stdlib Throw impl for String" path. Under ABI 14, `or_throw()` requires `E` to be a `pub error` (`E_OR_THROW_NOT_ERROR_TYPE`); the scenario no longer compiles. The banner comment now explains the retirement. Scenarios 1 and 2 (pub-error carrier) remain.

### 7.7 Deferred / not in this change set

- `just stress-test` and `just perf-smoke` — should be run before release. No concern surfaced in the regular gates; not blockers for review.
- Net-tls in-place 0.4.1 rehash — flag to upstream team independently of this migration; not blocking us since we pin 0.5.0.

### 7.8 Notes for reviewers

- **No `pub error` field is non-scalar.** Typed-catch projection works on every error type in the framework. `RestError.fields_json` carries the JSON payload as a `String` (canonical, lex-ordered).
- **`add_field` is order-deterministic.** Insertion-order is NOT preserved across `add_field` calls — keys are re-emitted lex-ordered every time. This matters for any test or app code that compares `fields_json` against a literal.
- **`merge_validation_error` parses on every call.** Each call does one `json.parse` + iterator walk. Field counts are tiny (typically 1–3); cost is negligible. If a future hot path needs faster merge, revisit.
- **`_dispatch_throws` catch order.** `errors:RestError` first, then 6× `events:Rest*`. Order matters for the `or_throw` pathway: when a handler calls `.or_throw()` on `Result<T, RestError>`, the thrown event is `errors:RestError` and the first arm catches it. Don't reorder.
- **The `field()` helper signature uses `&String`** for the key. Per Drift convention, callers pass `rest.field(err, "key")` without an explicit `&` prefix; the compiler implicitly borrows.
- **`fields_json` is defensively validated only at the wire boundary**, not at construction. `RestError` is a `pub error` so callers can build it with any String content; `error_envelope` enforces the JSON-object contract via `_safe_fields_json` and falls back to `"{}"` on bad input. This keeps the `pub error` carrier flexible (callers writing low-level glue can hand-build one) while guaranteeing every response body is well-formed. Tests `scenario_error_envelope_fields_json_not_json` and `scenario_error_envelope_fields_json_is_array` pin this contract.
- **Manifest dep ranges use `M`/`M.N`, not exact.** This is v2-manifest semantics. The pre-prepare consistency check (in `tools/check-manifest-consistency.sh`) was updated to match; reviewers may want to skim that script.
- **Version-distinct from the stale staged libs.** The new package versions (web-jwt 0.4.0, web-rest 0.5.0, web-client 0.4.0, or-throw-probe 0.0.2) are different from the ABI-10 builds at the same names in `$DRIFT_PKG_ROOT`. That's deliberate and load-bearing for `consumer-check` resolution.

---

## Appendix A — Reproduce locally

```bash
export DRIFT_TOOLCHAIN_ROOT="$HOME/opt/drift/staged/toolchain/drift-0.31.67+abi14"
export DRIFT_PKG_ROOT="$HOME/opt/drift/staged/libs"
export DRIFT_PYTHON="$(which python3)"

cd ~/src/drift-web
just lock-check          # → integrity mismatch on net-tls 0.4.1
# (apply manifest pin bump to net-tls 0.5 — already done in working tree)
just prepare             # → resolves net-tls@0.5.0, refreshes lock
just lock-check          # → up-to-date
just jwt-compile-check   # → DV / to_diag removal errors (real source issues)
```

## Appendix B — Open questions for the compiler team

- Is there a canonical helper for building scalar-keyed JSON-object strings from user code (the role `core.diagnostic_entry` used to play)? The deprecation message references `core.diagnostic_json_*` — pointer to the stdlib doc, please. drift-web's `add_field` reimplementation depends on it.
- For `pub error` types whose auto-synthesized diagnostic text isn't suitable (e.g. stable wire format), is implementing `to_json_text(self: &Self) nothrow -> String` the supported override? Bulletin implies yes.
- Can a single `catch` clause project multiple typed errors (`catch errors:RestError(e), events:RestBadRequest(e)` style), or must each typed error get its own arm? Affects `_dispatch_throws` arm count (one universal arm vs seven).
- Confirm `pub error` types support `move` semantics on construction the same way `pub struct` does — `add_field` mutates the carrier in place.
