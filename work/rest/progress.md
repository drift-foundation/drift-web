# REST UX Acceptance Tests — Progress

Status: verified, all tests passing
Date: 2026-02-26

## Scope

Acceptance tests derived from `docs/effective-web-rest.md` UX spec and `work/rest/plan.md` design.
Tests exercise UX contract only — no server, router, or builder machinery.

## Framework Skeleton

Minimal `packages/web-rest/src/` created to support test compilation:

| File | Purpose |
|------|---------|
| `lib.drift` | Facade: re-exports types and functions |
| `errors.drift` | `RestError` struct, event constants, `StringPair` for fields |
| `response.drift` | `Response` struct, `json_response()`, `error_envelope()` |
| `context.drift` | `Context`, `Principal`, get/set principal |
| `request.drift` | `Request`, `QueryParam`, query/body accessors |
| `jwt_guard.drift` | JWT tag → RestError mapping (plan.md contract) |

No server, router, builder, middleware chain, or HTTP listener implemented.

## Test Files

### Story 1: `packages/web-rest/tests/unit/health_test.drift`
- `GET /health` returns 200, body is `{"ok":true}`
- 4 scenarios (100–400 range)

| Scenario | Asserts |
|----------|---------|
| `scenario_health_status_200` | Response status = 200 |
| `scenario_health_body_valid_json` | Body parses as valid JSON |
| `scenario_health_body_ok_true` | Body has `ok: true` |
| `scenario_health_body_exact` | Body = `{"ok":true}` exactly |

### Story 2: `packages/web-rest/tests/unit/jwt_guard_test.drift`
- JWT guard unauthorized/authorized flows with full tag mapping
- Guard uses RestGuard-compatible contract: (config, req, ctx)
- Token extracted from Authorization: Bearer header on Request
- 14 scenarios (100–1400 range)

| Scenario | Asserts |
|----------|---------|
| `scenario_missing_authorization` | No Authorization header → 401/unauthorized/missing-authorization |
| `scenario_invalid_authorization_format` | Non-Bearer scheme → 400/request-invalid/invalid-authorization-format |
| `scenario_valid_token_authorized` | Guard passes, principal.sub = "user-42" |
| `scenario_me_handler_success` | Handler returns 200 `{"sub":"user-42"}` |
| `scenario_no_principal_unauthorized` | require_principal → 401/unauthorized/missing-principal |
| `scenario_expired_token_unauthorized` | jwt-expired → 401/unauthorized/jwt-expired |
| `scenario_signature_mismatch_unauthorized` | jwt-signature-mismatch → 401/unauthorized |
| `scenario_not_before_unauthorized` | jwt-not-before → 401/unauthorized |
| `scenario_iat_future_unauthorized` | jwt-issued-at-future → 401/unauthorized |
| `scenario_invalid_format_bad_request` | jwt-invalid-format → 400/request-invalid |
| `scenario_invalid_segment_bad_request` | jwt-invalid-segment → 400/request-invalid |
| `scenario_unsupported_alg_bad_request` | jwt-unsupported-alg sign rejection |
| `scenario_error_envelope_unauthorized` | Envelope JSON: event/tag/event_id/fields |
| `scenario_typ_mismatch_bad_request` | jwt-header-typ-mismatch → 400/request-invalid |

### Story 3: `packages/web-rest/tests/unit/validation_test.drift`
- Invalid input → request-invalid with structured fields
- 8 scenarios (100–800 range)

| Scenario | Asserts |
|----------|---------|
| `scenario_missing_query_param` | 400/request-invalid/missing-query-param, fields[q]=required |
| `scenario_query_param_present` | require_query_param returns value |
| `scenario_optional_query_param_missing` | query_param returns None |
| `scenario_empty_body_rejected` | 400/request-invalid/missing-body |
| `scenario_malformed_json_rejected` | 400/request-invalid/malformed-json |
| `scenario_valid_json_body_accepted` | body_json parses correctly |
| `scenario_error_envelope_with_fields` | Envelope with email=invalid-format, age=out-of-range |
| `scenario_error_envelope_empty_fields` | Envelope with empty fields object |

## Justfile Recipes Added

- `rest-check-par`: parallel compile + serial run of all REST unit tests
- `rest-check-unit FILE`: single REST unit test
- `rest-compile-check FILE`: compile-only check for REST sources

## JWT Tag Mapping Coverage

All 14 JWT error tags mapped per plan.md contract:

| JWT tag | REST status | REST event |
|---------|------------|------------|
| `jwt-signature-mismatch` | 401 | unauthorized |
| `jwt-expired` | 401 | unauthorized |
| `jwt-not-before` | 401 | unauthorized |
| `jwt-issued-at-future` | 401 | unauthorized |
| `jwt-invalid-format` | 400 | request-invalid |
| `jwt-invalid-segment` | 400 | request-invalid |
| `jwt-invalid-header-json` | 400 | request-invalid |
| `jwt-invalid-payload-json` | 400 | request-invalid |
| `jwt-unsupported-alg` | 400 | request-invalid |
| `jwt-missing-alg` | 400 | request-invalid |
| `jwt-claim-invalid-type` | 400 | request-invalid |
| `jwt-header-typ-mismatch` | 400 | request-invalid |
| Unknown/future tags | 401 | unauthorized (fail-closed) |

## Compiler Bug Found During Implementation

`CORE_BUG-return-fwd-mut-ref.md` — `return void_fn(&mut ref, ...)` corrupted &mut state.
Reported to compiler team, resolved. Repro retained as regression test.

## Verification

- [x] `just rest-check-par` — all 4 test files pass (3 stories + 1 repro) (as of 2026-02-26)
- [x] `just test` — full suite (JWT + REST) passes (10 tests total) (as of 2026-02-26)
- [ ] Blocked: driftc 0.8.0-dev stdlib regression breaks all compilation (std.json/regex internals). Upstream fix required. Old code on main also fails — not caused by our changes.
