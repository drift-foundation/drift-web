# Effective web-rest Usage (UX Spec Draft)

Audience: application developers and implementers of `web.rest`.

Status: UX-first draft. This document is the source for acceptance tests before internal framework implementation.

## Design Intent

- Primary app UX: throws-style handlers.
- Advanced path: `nothrow + Result` handlers.
- Single bootstrap path: builder only.
- Middleware is explicit:
  - `filter(...)` for enrichment/observability
  - `guard(...)` for access/precondition gates

## Canonical Bootstrap Shape

```drift
import web.rest as rest;

fn main() nothrow -> Int {
	var b = rest.new_app_builder();
	b.bind("0.0.0.0", 8080);
	// b.logger(...)
	var app = b.build();
	return app.run();
}
```

Notes:
- `bind(host, port)` is required.
- Multiple binds are allowed.
- `run()` blocks caller thread.

## Hello API (Throws-Style Primary)

```drift
import web.rest as rest;
import web.jwt as jwt;

fn main() nothrow -> Int {
	var b = rest.new_app_builder();
	b.bind("0.0.0.0", 8080);
	var app = b.build();

	app.filter(rest.middleware.request_id());

	var v1 = app.group("/v1");
	v1.guard(rest.auth.jwt_hs256(shared_secret()));

	app.get("/health").handle(|req: &rest.Request, ctx: &mut rest.Context| => {
		return rest.json(200, "{\"ok\":true}");
	});

	v1.get("/me").handle(|req: &rest.Request, ctx: &mut rest.Context| => {
		val p = rest.auth.require_principal(ctx);
		return rest.json(200, "{\"sub\":\"" + p.sub + "\"}");
	});

	return app.run();
}
```

## Same Behavior (Result-Style Advanced)

```drift
import std.core as core;
import web.rest as rest;

fn me_handler(req: &rest.Request, ctx: &mut rest.Context) nothrow -> core.Result<rest.Response, rest.RestError> {
	match rest.auth.principal(ctx) {
		Optional::Some(p) => { return core.Result::Ok(rest.json(200, "{\"sub\":\"" + p.sub + "\"}")); },
		Optional::None => { return core.Result::Err(rest.err_unauthorized("missing-principal")); }
	}
}
```

## Request Accessors

Result-based:
- `req.path_param(name) -> core.Result<String, rest.RestError>`
- `req.query_param(name) -> Optional<String>`
- `req.body_json() -> core.Result<json.JsonNode, rest.RestError>`

Throwing convenience:
- `req.require_path_param(name)`
- `req.require_query_param(name)`
- `req.require_body_json()`

`require_*` accessors throw `RestBadRequest` for missing/invalid user input.

## Error Envelope (Pinned)

Client payload fields:
- `event`
- `tag`
- `event_id`
- `fields` (`Map<String, String>`)

JWT expiry example:

```json
{
  "event": "unauthorized",
  "tag": "jwt-expired",
  "event_id": "evt-01H...",
  "fields": {}
}
```

Validation example:

```json
{
  "event": "request-invalid",
  "tag": "validation-failed",
  "event_id": "evt-01H...",
  "fields": {
    "email": "invalid-format"
  }
}
```

No localized English message is required in client payload by default.

## Routing Policy (Pinned)

- Path parameters use `{name}` syntax: `/users/{id}`
- Route matching is case-sensitive.
- Canonical static paths are lowercase.
- No automatic redirect for non-canonical casing by default.

## Next

Derive UX acceptance tests directly from this document:
1. `GET /health` success.
2. `GET /v1/me` unauthorized/success via JWT guard.
3. Invalid input path returning `request-invalid` envelope with `fields`.
