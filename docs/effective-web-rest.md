# Effective web-rest Usage

Audience: application developers integrating `web.rest`.

Status: refreshed for `web.rest` 0.4. Code examples use the real public API (free functions on `rest`, e.g. `rest.add_middleware(&mut app, mw)`).

## Design Intent

- Primary app UX: throws-style handlers.
- Post-MVP extension: public `nothrow + Result` handler registration.
- Single bootstrap path: builder only.
- Middleware is explicit:
  - `add_middleware(...)` (and `add_route_group_middleware(...)`) for wrapping middleware — onion-shaped enter/exit, brackets the handler on every termination path
  - `add_route_group_guard(...)` for access/precondition gates (pre-only, short-circuits on Err)
- (Removed in 0.4: the pre-only `add_filter` primitive — its use cases are subsumed by global `add_middleware`.)

Pinned public/normalized callback types:
- `RestHandler = fn(req: &Request, ctx: &mut Context) -> Response`
- `RestGuard = fn(req: &Request, ctx: &mut Context) nothrow -> core.Result<Void, rest.RestError>`
- `RestMiddleware = Callback3<&Request, &mut Context, NextFn, core.Result<Response, RestError>>` where `NextFn = Callback2<&Request, &mut Context, core.Result<Response, RestError>>`
- Internal router callback: `RestRouteCallback = fn(req: &Request, ctx: &mut Context) nothrow -> core.Result<Response, rest.RestError>`

## Canonical Bootstrap Shape

```drift
import std.core as core;
import std.concurrent as conc;
import web.rest as rest;

fn main() nothrow -> Int {
	val timeout = conc.Duration(millis = 5000);
	var b = rest.new_app_builder();
	rest.bind(&mut b, "0.0.0.0", 8080);
	match rest.build_app(move b) {
		core.Result::Err(_) => { return 1; },
		core.Result::Ok(a) => {
			var app = move a;
			// register middleware, routes, route groups here, then:
			match rest.start(move app, timeout) {
				core.Result::Err(_) => { return 2; },
				core.Result::Ok(running) => {
					var rs = move running;
					// app's main loop / wait-for-signal goes here.
					match rest.shutdown(&mut rs) {
						core.Result::Err(_) => { return 3; },
						core.Result::Ok(_) => { return 0; }
					}
				}
			}
		}
	}
}
```

Notes:
- `rest.bind(&mut builder, host, port)` is required at least once before `build_app`.
- Multiple binds are allowed.
- `rest.start(move app, timeout)` consumes the App by value, spawns the serve loop on a VT fiber, and returns `RunningServer`. App registration (routes, middleware, guards) must be complete before `start`.

## Hello API (Throws-Style Primary)

```drift
import std.core as core;
import std.concurrent as conc;
import web.rest as rest;
import web.rest.events as events;

fn _health(req: &rest.Request, ctx: &mut rest.Context) -> rest.Response {
	return rest.json_response(200, "{\"ok\":true}");
}

fn _me(req: &rest.Request, ctx: &mut rest.Context) -> rest.Response {
	match rest.require_principal(ctx) {
		core.Result::Ok(p) => { return rest.json_response(200, "{\"sub\":\"" + p.sub + "\"}"); },
		core.Result::Err(e) => {
			throw events:RestUnauthorized(tag = "missing-principal", message = e.message, fields_json = "{}");
		}
	}
}

fn main() nothrow -> Int {
	val timeout = conc.Duration(millis = 5000);
	var b = rest.new_app_builder();
	rest.bind(&mut b, "0.0.0.0", 8080);
	match rest.build_app(move b) {
		core.Result::Err(_) => { return 1; },
		core.Result::Ok(a) => {
			var app = move a;

			// Wrapping middleware that runs on every request (audit, tracing, etc.).
			// rest.add_middleware(&mut app, request_id_mw());

			// Health route — no JWT required.
			match rest.add_throws_route(&mut app, "GET", "/health", core.callback_throw2(_health)) {
				core.Result::Err(_) => { return 2; },
				core.Result::Ok(_) => {}
			}

			// /v1 group with JWT guard.
			match rest.add_route_group(&mut app, "/v1") {
				core.Result::Err(_) => { return 3; },
				core.Result::Ok(rg) => {
					// rest.add_route_group_guard(&mut app, &rg, jwt_hs256_guard(shared_secret()));
					match rest.add_route_group_throws_route(&mut app, &rg, "GET", "/me", core.callback_throw2(_me)) {
						core.Result::Err(_) => { return 4; },
						core.Result::Ok(_) => {}
					}
				}
			}

			match rest.start(move app, timeout) {
				core.Result::Err(_) => { return 5; },
				core.Result::Ok(rs) => {
					var running = move rs;
					// (production code blocks here until a shutdown signal)
					match rest.shutdown(&mut running) {
						core.Result::Err(_) => { return 6; },
						core.Result::Ok(_) => { return 0; }
					}
				}
			}
		}
	}
}
```

## Result-Style Handler Registration

For handlers that prefer `nothrow + Result` over `throws -> Response`, register via `rest.add_route` / `rest.add_route_group_route` and `core.callback2(...)`:

```drift
fn _me_result(req: &rest.Request, ctx: &mut rest.Context) nothrow -> core.Result<rest.Response, rest.RestError> {
	match rest.ctx_get<type rest.Principal>(ctx) {
		Optional::Some(p) => { return core.Result::Ok(rest.json_response(200, "{\"sub\":\"" + p.sub + "\"}")); },
		Optional::None => { return core.Result::Err(rest.rest_error(401, "unauthorized", "missing-principal", "no principal in context")); }
	}
}

// match rest.add_route(&mut app, "GET", "/me", core.callback2(_me_result)) { ... }
```

Both styles compose with middleware identically — the framework converts typed-throw responses to `Result::Err` (via `_dispatch_throws`) before the next-fn returns inside an onion layer.

## Request Accessors

- `rest.path_param(req, &name) -> core.Result<String, rest.RestError>`
- `rest.query_param(req, &name) -> Optional<String>`
- `rest.require_query_param(req, &name) -> core.Result<String, rest.RestError>` (adds field info on missing)
- `rest.body_json(req) -> core.Result<json.JsonHandle, rest.RestError>` (returns a JsonHandle — Arc-backed, O(1) clone; dispatch caches the parse, so multiple calls in the same request are free)

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
