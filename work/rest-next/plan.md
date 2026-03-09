# REST UX Pass 2 — Extraction & Validation Ergonomics

Status: draft
Date: 2026-03-09

## Goal

Make handler code concise and consistent for:

1. request data extraction
2. source-agnostic validation
3. field-level error accumulation

This pass is UX-first. We pin the handler model before implementation details.

## Why this changed

Earlier drafts mixed type conversion into query/path accessors.
We are explicitly not doing that now.

Reason:
- query/path values are text by nature
- the same validation rules should apply regardless of where a value came from
- a `user_id` or `page` validator should not care whether the source was:
  - JSON body
  - query param
  - path param

So the split is now:
- extraction is source-specific
- validation is source-agnostic

## Drift constraints

Current Drift constraints affect how this UX is expressed:

1. There is no `try` / `?`-style `Result` propagation sugar.
2. Match-heavy lambda bodies are still awkward because of current compiler limitations around `Result` pattern handling in lambdas.

Examples below describe the target API shape, but real implementation should prefer named handlers and explicit `match` until the language/compiler improves.

## UX principles (pinned)

1. Extraction and validation are separate concerns.
2. Query/path APIs are string-first.
3. Validation rules are reusable across body/query/path.
4. Error envelope shape stays stable: `event`, `tag`, `event_id`, `fields`.
5. Framework does not return English-heavy business text by default.

## Primary handler experience (today-expressible shape)

```drift
fn create_user(req: &rest.Request, ctx: &mut rest.Context) nothrow -> core.Result<rest.Response, rest.RestError> {
    val body = match rest.body_json(req) {
        core.Result::Ok(v) => { v },
        core.Result::Err(e) => { return core.Result::Err(e); }
    };

    val raw_id = match rest.path_param(req, "id") {
        core.Result::Ok(v) => { v },
        core.Result::Err(e) => { return core.Result::Err(e); }
    };
    val user_id = match rest.validate_int("id", raw_id) {
        core.Result::Ok(v) => { v },
        core.Result::Err(e) => { return core.Result::Err(e); }
    };
    val user_id2 = match rest.validate_int_range("id", user_id, 1, 1000000) {
        core.Result::Ok(v) => { v },
        core.Result::Err(e) => { return core.Result::Err(e); }
    };

    val email = match rest.require_body_string(&body, "email") {
        core.Result::Ok(v) => { v },
        core.Result::Err(e) => { return core.Result::Err(e); }
    };
    val email2 = match rest.validate_non_empty("email", email) {
        core.Result::Ok(v) => { v },
        core.Result::Err(e) => { return core.Result::Err(e); }
    };

    return core.Result::Ok(rest.json_response(200, "{\"ok\":true}"));
}
```

Multi-field accumulation is intentionally more verbose and is meant for form-style handlers where returning all field errors matters:

```drift
var ve = rest.new_validation_errors();

match rest.require_query_param(req, "page") {
    core.Result::Ok(raw_page) => {
        match rest.validate_int("page", raw_page) {
            core.Result::Ok(page) => {
                match rest.validate_int_range("page", page, 1, 100) {
                    core.Result::Ok(_) => {},
                    core.Result::Err(e) => { rest.merge_validation_error(&mut ve, move e); }
                }
            },
            core.Result::Err(e) => { rest.merge_validation_error(&mut ve, move e); }
        }
    },
    core.Result::Err(e) => { rest.merge_validation_error(&mut ve, move e); }
}

if rest.has_validation_errors(&ve) {
    return core.Result::Err(rest.validation_error(move ve));
}
```

Fail-fast remains the recommended default for small handlers.

## Scope

### A. Extraction APIs

#### 1. Body JSON extraction

- `body_json(req) -> Result<JsonNode, RestError>`

Behavior:
- missing/malformed body -> `request-invalid`
- `body_json()` remains the canonical API in this pass; no rename to `require_body_json`

#### 2. Body field extraction from parsed JSON

- `require_body_string(node, field) -> Result<String, RestError>`
- `require_body_int(node, field) -> Result<Int, RestError>`
- `require_body_bool(node, field) -> Result<Bool, RestError>`
- `body_string(node, field) -> Optional<String>`
- `body_int(node, field) -> Optional<Int>`

Behavior:
- field missing -> field-aware error
- wrong JSON type -> field-aware error

Note:
- body extraction naturally performs JSON type checking
- this is distinct from string parsing validators such as `validate_int`

#### 3. Query/path extraction

Query and path stay string-first.

Canonical names stay as they are today where already present:

- `query_param(req, key) -> Optional<String>`
- `require_query_param(req, key) -> Result<String, RestError>`
- `path_param(req, key) -> Result<String, RestError>`

No `query_int`, `query_int_or`, `path_int`, or `require_path_int` in this pass.
No rename to `query_string` / `require_query_string` in this pass.

There is no optional path accessor in this pass.
Reason:
- in the normal REST routing path, matched route parameters are guaranteed by the router
- a missing path param is therefore a real `404/not-found` condition, not an optional-value case

### B. Source-agnostic validation APIs

These validators operate on values, not request sources.

#### 1. String-to-type validators

- `validate_int(field, raw: String) -> Result<Int, RestError>`

Optional later:
- `validate_bool_text(field, raw: String) -> Result<Bool, RestError>`

#### 2. Typed validators

- `validate_int_range(field, value: Int, min: Int, max: Int) -> Result<Int, RestError>`
- `validate_non_empty(field, value: String) -> Result<String, RestError>`
- `validate_min_length(field, value: String, min: Int) -> Result<String, RestError>`

#### 3. Validation semantics

- validators return field-aware `RestError`
- parse/validation tags are deterministic
- validators do not know or care whether input came from body/query/path

#### 4. Field-name repetition

This split repeats field names across steps:
- extraction
- parse validation
- range/content validation

That repetition is accepted in this pass.
A future convenience layer may reduce repeated field-name literals, but that is out of scope here.

### C. Validation accumulation

Add a small collector type for multi-field validation.

Proposed APIs:
- `new_validation_errors()`
- `add_validation_error(ve, field, tag)`
- `merge_validation_error(ve, err)`
- `has_validation_errors(ve)`
- `validation_error(ve) -> RestError`

Pinned policy:
- collector produces:
  - `status=400`
  - `event=request-invalid`
  - `tag=validation-failed`
- field conflict policy: last-write-wins for MVP

There are no `_into` validator variants in this pass.
`merge_validation_error()` is the single mechanism for feeding extractor/validator failures into the collector.
`merge_validation_error()` transfers field entries only. It does not preserve the merged error's tag/event/message.

### D. Body parse caching

Still in scope, but lower priority than extraction/validation API shape.

Pinned behavior goal:
- repeated body field reads in one handler should not require reparsing JSON

This may require request-scoped caching later.
Do not let caching concerns distort the extraction/validation API shape.

## Out of scope

1. Schema/annotation-driven validation
2. Auto-binding JSON into structs
3. Transport-specific typed query/path helpers
4. Advanced coercions (date, decimal, UUID, etc.)
5. Server/transport/keep-alive changes
6. Localization/message catalogs

## Acceptance stories

### Story 1

`POST /v1/users` with malformed JSON:
- returns `400`
- `event=request-invalid`
- deterministic malformed-body tag

### Story 2

`POST /v1/users` with missing `email` and invalid `age`:
- returns `400`
- `tag=validation-failed`
- `fields.email` and `fields.age` present

### Story 3

`GET /v1/users/{id}?page=2`:
- `path_param("id")` succeeds
- `validate_int("id", raw_id)` succeeds
- `require_query_param("page")` succeeds
- `validate_int("page", raw_page)` succeeds

### Story 4

`GET /v1/users/{id}?page=abc`:
- `require_query_param("page")` succeeds
- `validate_int("page", raw_page)` fails with field error on `page`

### Story 5

Mixed validation accumulation:
- handler collects 3 field errors before returning
- response includes all 3 fields

### Story 6

Repeated body field reads in one handler:
- visible behavior is stable
- final implementation should not require reparsing body JSON for each field read

### Story 7

Optional query param with default:
- missing `page` defaults to `1`
- present `page=2` validates and yields `2`
- present `page=abc` fails through `validate_int("page", raw_page)`

## Deterministic tag table (pinned)

| Function | Error condition | Tag |
|----------|-----------------|-----|
| `body_json` | malformed/missing body | existing malformed body tag (`malformed-json`) |
| `require_body_string` | field missing | `missing-field` |
| `require_body_string` | field present, wrong JSON type | `invalid-type` |
| `require_body_int` | field missing | `missing-field` |
| `require_body_int` | field present, wrong JSON type | `invalid-type` |
| `require_body_bool` | field missing | `missing-field` |
| `require_body_bool` | field present, wrong JSON type | `invalid-type` |
| `path_param` | missing path value | `missing-path-param` |
| `require_query_param` | missing query value | `missing-query-param` |
| `validate_int` | not parseable as integer | `invalid-integer` |
| `validate_int_range` | integer out of range | `out-of-range` |
| `validate_non_empty` | empty string | `empty-value` |
| `validate_min_length` | shorter than minimum length | `too-short` |

If existing tags differ in code, they must be reconciled explicitly before implementation.

## Implementation order

1. Keep the current contract/gap tests as the pinned starting point
2. Update contract/gap test comments to match this revised plan
3. Add body field extraction helpers
4. Add source-agnostic validators:
   - `validate_int`
   - `validate_int_range`
   - `validate_non_empty`
5. Add validation collector
6. Convert current gap-placeholder stories into real handler-UX acceptance tests
7. Revisit body parse caching implementation after API shape is stable
8. Update docs examples

## Validation gates

1. `just rest-check-par`
2. `just test`
3. `just stress-test`

## Open decisions to confirm before implementation

1. Naming:
- keep existing extraction names where already present:
  - `body_json`
  - `query_param`
  - `require_query_param`
  - `path_param`
- use `require_*` naming for new body-field extractors
- use `validate_*` naming for source-agnostic validation

2. Validation collector type name:
- `ValidationErrors` is the current placeholder

3. Validator return style:
- default here is `Result<T, RestError>`
- collector helpers exist for accumulation when fail-fast is not desired
