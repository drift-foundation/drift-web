# REST Framework Plan

Status: in_progress
Owner: web team
Date: 2026-02-26

## Goal

Define `web.rest` starting from developer UX first, then derive API and internals.

## Delivery Model (Pinned)

Top-down only:
1. UX stories and API examples
2. UX acceptance tests
3. Internal machinery derived from accepted UX/tests

No low-level implementation work starts before UX acceptance tests are pinned.

## UX Stories (MVP)

1. Public health endpoint (`GET /health`)
2. JWT-protected endpoint (`GET /v1/me`)
3. Invalid request path (missing/invalid param or malformed JSON) with deterministic error envelope

## Proposed Error Model (Decision Draft)

Use a dual-surface design:

1. Core surface (`nothrow`, `Result`) for framework internals and low-level APIs.
2. Ergonomic handler surface (typed events) for application business code.

Rationale:
- Preserves Drift low-level library rule (`nothrow` core).
- Keeps business handlers concise.
- Maintains deterministic framework behavior via centralized event->HTTP mapping.

Known-error surface rule (explicit):
- The framework only treats enumerated REST event types as public error surface.
- Any non-enumerated/unexpected thrown event is treated as internal and mapped to a sanitized 500.

## Callback Type Contracts (Pinned)

### Public handler type (MVP)
- `type RestHandler = fn(req: &Request, ctx: &mut Context) -> Response`
  - Throws-style: handler code may throw typed REST events.
  - This is the only public handler registration surface in MVP.

### Public Result-style handler (Deferred — post-MVP)
- `type RestHandlerResult = fn(req: &Request, ctx: &mut Context) nothrow -> core.Result<Response, RestError>`
  - Documented as post-MVP contract continuity; not exposed in MVP registration API.

### Internal normalized router callback
- `type RestRouteCallback = fn(req: &Request, ctx: &mut Context) nothrow -> core.Result<Response, RestError>`
  - Router stores one normalized callback form.
  - Throws-style handlers are adapted at registration time, not dispatch time.

### Adapter contracts
- MVP: RestHandler → RestRouteCallback adapter (registration-time normalization via try/catch wrapper).
- Post-MVP: RestHandlerResult → RestRouteCallback adapter (trivial identity mapping).

### Storage/dispatch model (pinned for MVP)
- Router stores handlers as callback types (heterogeneous route table).
- Bottom line for framework internals: routing/middleware/handler execution is dynamic callback dispatch.
- Generic/static dispatch may be used in helper builders, but not in the runtime route table.

## UX Decisions (Pinned)

1. App construction uses builder pattern.
   - no shortcut constructor; single canonical bootstrap path via builder
   - explicit `bind(host, port)` required (multi-bind allowed)
   - no implicit default bind host (`127.0.0.1`/`0.0.0.0` not auto-selected)
   - optional logger/config injection
   - `build()` then `run()`

1a. Route declaration style for MVP is imperative builder only.
   - no annotation/macro/declarative table route definitions in MVP

2. Middleware semantics are explicit and split by intent:
   - `filter(...)` = processing/enhancement/observability
   - `guard(...)` = access/precondition gatekeeper that may block

3. App handlers are allowed to throw typed REST events.
   - framework boundary must catch and map deterministically
   - unknown events never leak internal details to client

4. Client error payloads are tagged machine data (no English sentence requirement).
   - include stable fields (`event`, `tag`, `event_id`)
   - include `fields` (structured machine map) in MVP for validation/context details
   - client payloads do not include `message` by default (locale-neutral policy)

5. Handler style emphasis:
   - throws-style handlers are primary UX in docs/examples
   - public `nothrow + Result` handler registration is deferred until after MVP

## REST Events and HTTP Mapping (Draft)

Typed REST events (separate types by design, not a single status variant):
- `RestBadRequest(tag: String, message: String)`
- `RestUnauthorized(tag: String, message: String)`
- `RestForbidden(tag: String, message: String)`
- `RestNotFound(tag: String, message: String)`
- `RestConflict(tag: String, message: String)`
- `RestInternal(tag: String, message: String)`

Event payload note:
- `message` on internal event types is for server-side handling/logging context.
- Client response payload does not include `message` by default.

Design note:
- Separate event types are deliberate for catchability and HTTP-semantic clarity.
- Future status categories are added as new event types.

Rationale for separate types vs single variant:
- Fine-grained catch behavior in handlers/middleware (`catch RestUnauthorized` directly).
- Cleaner middleware remap/rethrow flows without status-code branching.
- HTTP semantics remain explicit in type-level control flow.
- Easier incremental evolution: new categories added as new types without refactoring existing catch sites.

Boundary mapping:
- `RestBadRequest` -> 400
- `RestUnauthorized` -> 401
- `RestForbidden` -> 403
- `RestNotFound` -> 404
- `RestConflict` -> 409
- `RestInternal` and unknown/unhandled events -> 500

`RestInternal` distinction (pinned):
- If app code explicitly throws `RestInternal(tag=..., ...)`, framework returns 500 with that explicit `tag` and `event_id`.
- If framework catches truly unknown/unhandled exceptions/events, framework returns 500 with sanitized fallback tag (internal-error) and `event_id`.

Standard response envelope fields:
- `event` (stable event category tag)
- `tag` (stable specific machine tag)
- `event_id` (trace/correlation id)
- `fields` (machine details map, required when relevant)

Envelope semantics (pinned):
- `event` = framework-level category (stable taxonomy; e.g. `unauthorized`, `request-invalid`)
- `tag` = specific machine tag (often source-derived; e.g. `jwt-expired`, `missing-query-param`)

Event value mapping (pinned):
- `RestBadRequest` -> `event="request-invalid"`
- `RestUnauthorized` -> `event="unauthorized"`
- `RestForbidden` -> `event="forbidden"`
- `RestNotFound` -> `event="not-found"`
- `RestConflict` -> `event="conflict"`
- `RestInternal` -> `event="internal"`
- unknown/unhandled exceptions/events -> `event="internal"`

Correlation/logging requirement (pinned):
- if framework logs an exception/event that becomes a client-visible error, that log line must include the same `event_id` returned in the response envelope.

Concrete envelope examples (pinned):

JWT expiry (401):
```json
{
  "event": "unauthorized",
  "tag": "jwt-expired",
  "event_id": "evt-01H...",
  "fields": {}
}
```

Validation error (400):
```json
{
  "event": "request-invalid",
  "tag": "validation-failed",
  "event_id": "evt-01H...",
  "fields": {
    "email": "invalid-format",
    "age": "out-of-range"
  }
}
```

## JWT Middleware Mapping Contract (Draft)

- JWT middleware remains `nothrow` + `Result` based.
- Middleware maps specific `jwt.JwtError.tag` values:
  - -> `RestUnauthorized`:
    - `jwt-signature-mismatch`
    - `jwt-expired`
    - `jwt-not-before`
    - `jwt-issued-at-future`
  - -> `RestBadRequest`:
    - `jwt-invalid-format`
    - `jwt-invalid-segment`
    - `jwt-invalid-header-json`
    - `jwt-invalid-payload-json`
    - `jwt-unsupported-alg`
    - `jwt-missing-alg`
    - `jwt-claim-invalid-type`
    - `jwt-header-typ-mismatch`
- Unknown/future JWT tags default to `RestUnauthorized` (fail-closed posture), with server-side logging and `event_id`.
- On success, middleware stores principal in request context for handlers.

## Pipeline Order (Pinned)

1. Global filters (`app.filter(...)`)
2. Group/route guards (`group.guard(...)`, `route.guard(...)`)
3. Route handler
4. Outbound filters (optional in MVP; if included, run after handler/event mapping)

Middleware composition model (pinned for MVP):
- Ordered chain model (not nested wrapper model, not dependency graph).
- Registration order is execution order.
- Later filters/guards can rely on context enrichment produced by earlier ones.
- No dependency declaration system (`A depends on B`) in MVP.

Guard execution contract (pinned for MVP):
- Guards are framework-internal `nothrow + Result` components:
  - `type RestGuard = fn(req: &Request, ctx: &mut Context) nothrow -> core.Result<Void, RestError>`
- Guards do not throw directly in MVP.
- Guard errors are mapped by the framework boundary using the same deterministic envelope policy as other `RestError` paths.
- This keeps middleware/guard layer aligned with low-level nonthrow rule while handlers remain ergonomic throw-surface.

Filter execution contract (pinned for MVP):
- Filters are framework-internal `nothrow + Result` components:
  - `type RestFilter = fn(req: &Request, ctx: &mut Context) nothrow -> core.Result<Void, RestError>`
- Filters do not terminate normal flow unless they return `Err(RestError)`.
- Filters and guards share uniform callback arity: `(&Request, &mut Context)`.

## Request/Response Shape (Initial Draft)

- `Request` minimum:
  - method
  - path
  - headers
  - body
  - path/query accessors
- `Response` minimum:
  - status
  - headers
  - body

Path parameters are mandatory in MVP route syntax (`/users/{id}` style support).

Request parsing/cache behavior (pinned):
- path/query are parsed before handler dispatch and exposed as immutable request data.
- body is buffered once and parsed lazily on first body accessor call.
- body parse result (or parse error) is cached and reused by subsequent calls.

Request accessor API direction (pinned):
- `req.path_param(name)` -> `core.Result<String, RestError>`
- `req.query_param(name)` -> `Optional<String>`
- `req.require_path_param(name)` -> throws typed REST event on missing/invalid
- `req.require_query_param(name)` -> throws typed REST event on missing/invalid
- `req.body_json()` -> `core.Result<json.JsonNode, RestError>`
- `req.require_body_json()` -> throws typed REST event on missing/invalid JSON

`require_*` throw policy (pinned):
- `require_*` accessors throw `RestBadRequest` on missing/invalid user input.

Path matching/canonicalization policy (pinned):
- route matching is case-sensitive.
- canonical route style uses lowercase static path segments.
- path-parameter values remain case-sensitive and are not case-normalized.
- no redirect on non-canonical casing by default (API-first behavior).
- optional redirect policy can be added later for browser-facing flows.

Error `fields` type (pinned for MVP):
- `fields` is `Map<String, String>`.

## Lifecycle Notes (MVP)

- `app.run()` blocks the caller thread (`main` or whichever thread invoked it).
- Request execution is handled by runtime scheduler/epoll + virtual-thread machinery underneath.
- Shutdown API (`close()` or equivalent) is explicit, idempotent, and testable.
- Graceful shutdown contract:
  - stop accepting new connections
  - allow in-flight requests to complete up to a timeout
  - force-close remaining work after timeout
- Shutdown timeout is configured via app builder (with a documented default).
- Signal handling (`SIGINT`/`SIGTERM`) is not automatic in MVP; app code wires signals and calls `close()`.
- Executor policy is framework-managed in MVP (not user-tunable yet), while request-order/safety semantics remain public behavior.

## Open Questions (UX-first)

1. Whether outbound filters ship in MVP or immediately after MVP.

## Completed Milestones

1. UX stories and API examples: `docs/effective-web-rest.md`
2. UX acceptance tests: 3 stories (health, jwt_guard, validation) — all passing
3. JWT tag-mapping coverage: all 14 tags + unknown-tag fail-closed path
4. Validation-error tests: structured `fields` payload verified
5. Callback type contracts: all names and signatures pinned (RestHandler, RestFilter, RestGuard, RestRouteCallback)
6. Request headers: added to skeleton; JWT guard extracts `Authorization: Bearer` from request

## Next Step

1. Resolve upstream driftc 0.8.0-dev stdlib regression (std.json/regex broken) — blocks all compilation.
2. Implement internal REST framework machinery: router, builder, middleware chain, handler dispatch.
3. Wire throws-handler → RestRouteCallback adapter.
4. Add HTTP listener integration (TCP accept loop + request parsing).
