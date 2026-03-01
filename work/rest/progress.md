# REST Framework — Progress

Status: verified, all tests passing
Date: 2026-02-28

## Scope

Full REST framework with router, dispatch pipeline, HTTP parser/serializer, and TCP server.

## Framework Source

| File | Purpose |
|------|---------|
| `lib.drift` | Facade: re-exports types and functions |
| `errors.drift` | `RestError` struct, event constants, `StringPair` for fields |
| `response.drift` | `Response` struct, `json_response()`, `error_envelope()` |
| `context.drift` | `Context`, `Principal`, get/set principal |
| `request.drift` | `Request`, `QueryParam`, query/body/header/path-param accessors |
| `jwt_guard.drift` | JWT tag → RestError mapping (plan.md contract) |
| `router.drift` | Route pattern parsing, path matching, path param extraction |
| `app.drift` | AppBuilder, App, Group, route/filter/guard registration, dispatch |
| `events.drift` | Exception types for throws-handler adapter |
| `http.drift` | HTTP/1.1 request parser + response serializer |
| `server.drift` | ServerHandle, listen_app, serve (TCP accept loop), handle_connection |

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

### Dispatch: `packages/web-rest/tests/unit/dispatch_test.drift`
- Router, path params, filters, guards, throws adapter
- 20 scenarios (100–2000 range)

### HTTP Parser: `packages/web-rest/tests/unit/http_test.drift`
- HTTP/1.1 request parsing and response serialization
- 7 scenarios (100–700 range)

| Scenario | Asserts |
|----------|---------|
| `scenario_parse_get_request` | GET /health → method, path, empty body |
| `scenario_parse_post_with_body` | POST with Content-Length → body extracted |
| `scenario_parse_headers` | Multiple headers parsed, Authorization found |
| `scenario_parse_empty_body` | No Content-Length → empty body |
| `scenario_parse_malformed_request_line` | Garbage → 400 malformed-http |
| `scenario_serialize_200` | Response(200) → HTTP/1.1 200 OK status line + body |
| `scenario_serialize_401` | Response(401) → HTTP/1.1 401 Unauthorized status line |

### Server Integration: `packages/web-rest/tests/unit/server_test.drift`
- Full TCP lifecycle: listen → accept → parse → dispatch → serialize → respond
- Spawned server VT, real TCP connections via port 0
- 5 scenarios (100–500 range)

| Scenario | Asserts |
|----------|---------|
| `scenario_health_endpoint` | GET /health → 200 `{"ok":true}` over TCP |
| `scenario_jwt_authorized` | GET /v1/me + Bearer token → 200 `{"sub":"user-42"}` |
| `scenario_jwt_unauthorized` | GET /v1/me without token → 401 unauthorized envelope |
| `scenario_not_found` | GET /nonexistent → 404 not-found envelope |
| `scenario_malformed_request` | Garbage TCP data → 400 Bad Request |

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

## HTTP Listener Limitations (MVP)

- HTTP/1.1 only, version not validated
- No chunked transfer encoding — Content-Length only
- No keep-alive — one request per connection, `Connection: close` always sent
- Max header size: 8192 bytes
- No percent-decoding of URL path
- No Host header validation
- Response always `Content-Type: application/json`
- `event_id` is counter-based (`evt-N`), not globally unique
- Connections handled synchronously (one at a time) — `serve()` takes owned `App` to enable spawning in VTs (Drift closure borrow restriction)
- **Server shutdown uses `Arc<AtomicBool>` shared stop flag.** `ServerHandle.stopped` is `conc.Arc<sync.AtomicBool>`. `clone_handle()` clones the Arc so caller retains a handle while `serve()` owns another. `stop()` takes `&ServerHandle` and atomically sets the flag. The accept loop checks the flag with `Acquire` ordering between iterations (200ms accept timeout bounds responsiveness).
- `ServerHandle.max_requests` provides optional bounded exit (0 = unlimited, >0 = exit after N connections) — useful as a test helper but not the primary shutdown mechanism

## Verification

- [x] `just rest-check-par` — all 7 test files pass (as of 2026-02-28)
- [x] `just test` — full suite (JWT + REST) passes (13 tests total) (as of 2026-02-28)
- [x] Query string parsing: request target split on `?`, path routed without query, params populated
- [x] Truncated body: Content-Length mismatch returns 400 `incomplete-body`
- [x] Real lifecycle test: `listen_app()` → `clone_handle()` → spawn `serve()` → roundtrip → `stop()` → `join()` clean exit
