# web-rest 0.4 — wrapping middleware + extensible Context

**Status**: design accepted, implementation pending.
**Source request**: `pushcoin/work/request-for-web-team/wrapping-middleware-and-extensible-context.md`.
**Toolchain prerequisite**: certified Drift `0.31.24` (ABI 10) — verified end-to-end before this design was approved.
**Versioning**: web-rest `0.3.1` → `0.4.0`. Breaking, intentional. No deprecation shims for renamed/removed APIs; one-time rework on consumer side is accepted by the app team.

## Goals

1. **Wrapping middleware** with onion semantics — entry/exit work brackets every termination path of a request, including the error path. Required for tracing-span close, audit-line emission, latency histograms, in-flight gauge decrement, log-context pop. All five concerns share the same shape: paired enter/exit work where the exit must run on every termination path and needs state from the entry.
2. **Extensible Context** — per-request typed slot map for middleware-to-handler state transfer (e.g. middleware opens a `SpanHandle`, handler reads span-id, middleware retakes ownership at exit and calls `close_span(self)`).
3. **Naming**: rename `Group` → `RouteGroup` so the abstraction is self-documenting.

## Public API

### Renamed (mechanical)

| Before | After |
|---|---|
| `Group` | `RouteGroup` |
| `add_group(app, prefix) -> Result<Group, _>` | `add_route_group(app, prefix) -> Result<RouteGroup, _>` |
| `add_group_guard(app, &group, cb)` | `add_route_group_guard(app, &rg, cb)` |
| `add_group_route(app, &group, ...)` | `add_route_group_route(app, &rg, ...)` |
| `add_group_throws_route(app, &group, ...)` | `add_route_group_throws_route(app, &rg, ...)` |

### Removed

- `set_principal(ctx: &mut Context, sub: String) -> Void`
- `get_principal(ctx: &Context) -> Optional<Principal>`
- `Context.has_principal: Bool`
- `Context.principal_sub: String`
- `add_filter(app: &mut App, filter: ...) -> Void` (along with `App.filters` and the dispatch filters loop)

`Principal` struct stays as a public type. Apps that previously called `set_principal(ctx, sub)` switch to `ctx_set<Principal>(ctx, Principal(sub = ...))`. Apps that called `get_principal(ctx)` switch to `ctx_get<Principal>(ctx)`.

`add_filter` is functionally subsumed by global `add_middleware` — a middleware that returns its own `Err` before calling `next.call(...)` is exactly the pre-only filter case. Hard cut in 0.4 — one compositional primitive is easier to teach and maintain.

### New

```drift
// Per-request typed slot map. Lifetime = one request.
pub fn ctx_set<T>(ctx: &mut Context, value: T) nothrow -> Void
pub fn ctx_get<T>(ctx: &Context) nothrow -> Optional<&T>
pub fn ctx_take<T>(ctx: &mut Context) nothrow -> Optional<T>

// Wrapping middleware — two scopes (global + per-RouteGroup).
pub fn add_middleware(
    app: &mut App,
    mw: core.Callback3<&Request, &mut Context,
                       core.Callback2<&Request, &mut Context,
                                      core.Result<Response, RestError>>,
                       core.Result<Response, RestError>>
) nothrow -> Void

pub fn add_route_group_middleware(
    app: &mut App, rg: &RouteGroup, mw: <same shape>
) nothrow -> Void
```

No `add_route_middleware` (per-route). Group-of-one (a `RouteGroup` containing a single route) covers per-route cases without combinatorial test matrix. Per app-team spec.

## Behavioral contract

1. **Middleware itself is `nothrow`**, returns `Result<Response, RestError>`. The framework's `_dispatch_throws` adapter converts handler exceptions to `Result::Err` *before* `next.call(...)` returns, so middleware never sees a raw exception. ScopeGuards in middleware bodies fire on normal function return — the error case is just a `Result` branch.
2. **Onion model** — middlewares apply outside-in around the handler; post-`next` code runs inside-out as each middleware returns. Standard pattern (Express, Koa, Tower, ASP.NET Core).
3. **Full transformation** — middleware can mutate response headers, swap response status, transform payload, convert `Ok→Err` (e.g. flag a 200 with bad body to a 400) or `Err→Ok` (catch a known error class).
4. **Every-path execution** — middleware observes the `Result` regardless of how the request terminated: handler success, handler typed-throw, downstream-middleware short-circuit. RAII via ScopeGuard fires on the middleware's normal return.
5. **Short-circuit by not calling `next`** — auth failures, rate limits, etc. return their own `Err` (or `Ok(custom_response)`) without invoking `next`.

## Internal structure

### `Context` (rewrite — `packages/web-rest/src/context.drift`)

```drift
pub struct Context {
    slots_keys: Array<Uint64>,           // package-private (no pub)
    slots_vals: Array<std.runtime.TypeBox>
}

pub fn new_context() nothrow -> Context { /* empty arrays */ }

pub fn ctx_set<T>(ctx: &mut Context, value: T) nothrow -> Void {
    // Linear scan; if key present, replace TypeBox (old box drops, old T drops);
    // else push new key + box.
}

pub fn ctx_get<T>(ctx: &Context) nothrow -> Optional<&T> {
    // Linear scan; on hit return rt.downcast<type T>(&ctx.slots_vals[i]).
}

pub fn ctx_take<T>(ctx: &mut Context) nothrow -> Optional<T> {
    // Linear scan; on hit:
    //   1. swap-remove from both arrays (swap with last, pop)
    //   2. rt.take<type T>(move tb) on the popped TypeBox to extract owned T.
    // Returns None on miss; preserves remaining slots intact.
}
```

Slot fields are package-private. Public access is exclusively through `ctx_set` / `ctx_get` / `ctx_take`. Linear scan is fine — N is the number of distinct types stashed per request, typically single digits. No HashMap until perf-smoke says otherwise.

### `App` storage (`packages/web-rest/src/app.drift`)

Add two parallel-array fields, mirroring the existing filters/guards/routes pattern:

```drift
pub struct App {
    // ... existing fields unchanged ...

    // Middleware registry (single registry, both scopes)
    pub middleware_callbacks: Array<core.Callback3<...>>,
    pub middleware_route_group_ids: Array<Int>   // -1 = global, else route group id
}
```

`add_middleware` pushes with `route_group_ids = -1`. `add_route_group_middleware` pushes with the group id. Same pattern as `guard_callbacks` / `guard_group_ids`.

### Dispatch threading (load-bearing change)

Phase 0 verification established that onion-fold closures escape past their construction iteration → must `share` over an `conc.Arc<App>`, not borrow. Cleanest path: wrap `App` in `conc.Arc` once at `serve()` entry; change `dispatch`'s signature to take the Arc.

`server.drift`:
```drift
pub fn serve(a: app.App, ...) {
    val app_arc = conc.arc(move a);
    // per connection:
    match dispatch(app_arc.clone(), &mut req, &mut ctx) { ... }
}
```

`dispatch` signature: `&App` → `conc.Arc<App>`. All non-onion paths inside dispatch use `app_arc.get()` to access `&App`. Onion-fold closures use `captures(share app_arc, copy idx, move next)`.

Helpers `_dispatch_throws`, route-handler invocation etc. continue taking `&App` as parameter; dispatch passes `app_arc.get()` at the call site. This isolates the Arc detail to dispatch + serve.

### Dispatch order

```
1. Path → segments
2. Best route match (404 on miss)
3. Clear/extract path params; cache body JSON
4. Route-group guards (existing — pre-only, short-circuit on Err)
5. Build middleware onion → invoke
   ├─ outermost: globals + matched route-group middleware (filtered + ordered)
   └─ innermost: route handler (nothrow direct, or _dispatch_throws)
```

## Two pinned invariants

### Mutation invariant: registration is complete before serve

> **App registration is complete before `serve()` / `start()`. Arc-wrapped dispatch assumes no mutation after serving begins.**

`start()` consumes `App` by value (current signature: `pub fn start(var a: app.App, timeout: conc.Duration) -> Result<RunningServer, RestError>`). Once consumed, the App is owned by the server fiber, wrapped in `conc.Arc`, and shared into per-request closures. The caller retains only `RunningServer` (no App handle exposed). Mutation of route/middleware/guard registries post-start is therefore structurally impossible — there is no API path that surfaces an `&mut App` after `start()` returns. New 0.4 surfaces (`add_middleware`, `add_route_group_middleware`) preserve this: they take `&mut App` only during the pre-`start` registration phase.

### Middleware ordering invariant

> **Middleware ordering is defined by filtering the single `App.middleware_callbacks` registry in registration order: globals plus middleware for the matched `RouteGroup`, then folded outside-in over that ordered list.**

Concretely, per request:
1. Walk `App.middleware_callbacks` in registration order; collect indices `i` where `middleware_route_group_ids[i] == -1` (global) **or** `middleware_route_group_ids[i] == matched_route_group_id`.
2. The collected list, in registration order, is the outside-in stack: index 0 of the filtered list is outermost, last index is closest to the handler.
3. Onion fold builds the chain bottom-up by iterating the filtered list reversed; outer middleware wraps inner.

A consequence: registration order across the *whole* app determines layering. Registering a route-group middleware before a global middleware places the route-group middleware *outside* the global one for routes in that group. Apps relying on a specific layering must register in the desired outside-in sequence. Documented explicitly in the integration guide.

## Implementation sequencing (Phase 2)

Six commits, each independently green-CI'd (`just rest-check-par`, `just test`, `just consumer-check`):

1. **Mechanical rename: `Group` → `RouteGroup`.** Type, four registration APIs, all internal references, all unit + consumer tests. Pure rename, no behavior change. Easy review, isolates concerns.

2. **Context typed slot map.** Rewrite `context.drift`: drop `set_principal`/`get_principal` and the boolean+string fields; keep `Principal` as a public payload type. Add `slots_keys`/`slots_vals` (package-private) and `ctx_set`/`ctx_get`/`ctx_take`. Update internal call sites (`jwt_guard.drift` is the main consumer of `set_principal`). New unit test `context_slot_test.drift` — see "Durable test commitments" below.

3. **Arc-wrap App in `serve()`; change `dispatch` signature.** No middleware yet — just the plumbing change. All existing tests pass after this commit.

4. **`add_middleware` (global) + onion fold in `dispatch`.** Onion-fold algorithm using the verified `captures(move next, copy idx, share app_arc)` shape. Validation tests 1-5 from the app-team spec: single mw, composition, handler-throws-typed, handler-throws-unknown, short-circuit.

5. **`add_route_group_middleware` + hard-cut `add_filter`.** Onion respects the filtering rule above. Validation tests 6, 7: group scoping (only fires for routes in that group), full composition with guards + global mw + group mw + handler. Removes `add_filter`, `App.filters`, the dispatch filters loop, and the filter-using scenarios in `dispatch_test.drift` (equivalents are in `middleware_test.drift`).

6. **lib.drift facade + version bump 0.4.0.** Final commit. New sections for middleware + Context slot map. Verify the export list matches the API surface above.

Stress + perf-smoke run at the end of the sequence (serial per project parallelism policy).

## Durable test commitments

Owned by Phase 2 commit #2 (`context_slot_test.drift`) and commit #4 (`middleware_test.drift`). These are the cases the app team explicitly called out for memcheck-clean coverage:

### `ctx_set` overwrite with owning payload
- Set `ctx_set<String>(ctx, "first")`; then `ctx_set<String>(ctx, "second")`; verify `ctx_get<String>(ctx)` returns `Some(&"second")`. The first String must drop cleanly (no leak under memcheck, no double-drop).
- Same with a non-trivial owning struct (e.g. `struct OwnedHandle { name: String, count: Int }`) — overwrite must drop the previous instance's String field.

### `ctx_take` swap-remove with owning payload
- Set three distinct types in order: `<TypeA>`, `<String>`, `<TypeC>`. Take `<String>` (the middle slot). Verify:
  - Returned value is owned and equals the originally set String.
  - `ctx.slots_keys.len == 2` after take.
  - `ctx_get<TypeA>` and `ctx_get<TypeC>` still return the correct values (swap-remove preserved them).
  - Memcheck-clean: no leaks, no double-drop on the swapped element.
- Take from the *last* slot (no swap needed) — verify same correctness.
- Take from the *first* slot (swap with last; index 0 receives the moved entry).

### Defensive cases
- `ctx_take<T>` on absent T returns `None` (no crash, no spurious slot consumption).
- `ctx_get<T>` after `ctx_take<T>` returns `None`.
- `ctx_set<T>` after `ctx_take<T>` re-creates the slot cleanly.
- Multi-type isolation: `ctx_set<TypeA>` followed by `ctx_get<TypeB>` returns `None` (type-id discrimination is correct).

### Drop-on-Context-end
- Set a slot containing an Arc'd resource with a known reference count; let `Context` drop at end of scope; verify the Arc's strong count decrements (i.e. TypeBox drop chain runs through to the inner T's drop).

## Open questions resolved

| Q | Resolution |
|---|---|
| Q1: `add_filter` deprecation | Hard cut in 0.4. Removed entirely along with `App.filters` and the dispatch filters loop. Apps migrate to `add_middleware`. |
| Q2: Onion construction (lambda fold vs. recursive helper) | Verified lambda-fold for first cut; refactor to recursive helper later only if review prefers. |
| Q3: Defensive throws-wrapping around middleware | No. Type contract is `nothrow -> Result`; trust the type. |
| Q4: `Context` slot field privacy | Package-private. Public access only through `ctx_set` / `ctx_get` / `ctx_take`. |
| Q5: Other blockers before sequencing | None. |

## ABI / compatibility

Source-only, ABI-neutral. web-rest is source-distributed; consumers re-compile against 0.4.0. No `.dmp` ABI bump implied.
