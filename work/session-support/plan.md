# web.client Session-First API Plan

## Goal

Replace the current primary `web.client` one-shot API with a session-first
model now, before broader adoption.

Reason:

- cookies are required
- cookies are inherently cross-request state
- future pooling, redirects, and default per-session policy also need a
  stateful home
- we do not want two parallel public client APIs where users learn a
  convenience path first and then migrate later

This plan makes `Session` the one robust public model for both simple and
advanced use. One-shot helpers may remain only as thin secondary sugar.

## Decision

`web.client` should move to a session-centric public API immediately.

Primary public shape:

- configure client policy
- create `Session`
- send requests through `Session`
- use convenience HTTP verb helpers on `Session`

Not the primary shape:

- top-level stateless `send(cfg, req)` as the main usage model

That older one-shot path may remain temporarily as compatibility sugar, but it
should stop being the center of the API, docs, and examples.

## Why now

If we delay this change:

- cookies will force a second API shift later
- pooling will need a new stateful handle later
- redirect policy will need a new stateful handle later
- examples and users will anchor on the wrong abstraction

If we do it now:

- there is one coherent mental model
- cookies have a natural home immediately
- pooling can arrive later without invasive public churn
- simple examples and real applications use the same abstraction

## Session model

`Session` is a cheap copyable handle, not a heavyweight state blob.

Important Drift-specific expectation:

- cheap copyable values are acceptable and expected for lightweight handles
- `clone` / `clone_deep` imply expensive duplication and should not be the
  normal way to share client session state

So the intended design is:

- public `Session` is cheap to copy/pass around
- internal state behind `Session` can be shared
- future cookie jar / connection pool / redirect state can live behind that
  handle

This does NOT require pooling to exist now. It only requires the public shape
to reserve the right abstraction boundary.

Operationally, the intended mental model is Arc-like:

- `Session` is a cheap shared handle
- heavy mutable state lives behind the handle
- ordinary copying of `Session` does not deep-copy cookie/pool state
- `Session` should be safe to share across fibers/threads

This means the internal implementation should be designed from the start around
a shared-inner pattern, so later mutable shared state such as a cookie jar has a
correct home.

## Session responsibilities

`Session` is the home for cross-request client state and policy, including:

- configuration defaults
- cookie jar
- future connection pool / keep-alive reuse
- future redirect policy/state
- future default headers / auth helpers if added

`ClientRequest` remains per-request input:

- method
- URL
- request-specific headers
- request-specific body

`ClientResponse` remains per-response output.

## API direction

### Primary public API

The public API should be centered on `Session`.

Target shape:

```drift
var cfg = client.new_client_config();
client.with_connect_timeout(&mut cfg, 5000);
client.with_tls_handshake_timeout(&mut cfg, 5000);
client.with_io_timeout(&mut cfg, 5000);
client.with_tls_trust_store(&mut cfg, client.TrustStore::PemFile(path = "/etc/ssl/certs/ca-certificates.crt"));

val session = client.new_session(cfg);

match session.get("https://api.example.com/health") {
    core.Result::Ok(resp) => { ... },
    core.Result::Err(err) => { ... }
}
```

For more control:

```drift
var req = client.new_request("POST", "https://api.example.com/items");
client.set_header(&mut req, "Accept", "application/json");
client.set_json_body(&mut req, "{\"name\":\"x\"}");

match session.send(move req) {
    core.Result::Ok(resp) => { ... },
    core.Result::Err(err) => { ... }
}
```

### Convenience helpers

Session-level verb helpers should exist:

- `session.get(url)`
- `session.post(url, body)`
- `session.put(url, body)`
- `session.delete(url)`

They should be thin helpers that create a request and delegate to
`session.send(...)`.

### Lower-level helpers

The existing lower-level request builder helpers still make sense:

- `new_request(...)`
- `set_header(...)`
- `set_body(...)`
- `set_body_string(...)`
- `set_json_body(...)`

These should remain because they support nontrivial requests cleanly.

### One-shot helper

If retained, one-shot should be explicitly secondary:

- `send_once(cfg, req)`

It should not remain the main documented or recommended API.

## Recommended public surface

This is the intended direction, not necessarily the exact final spelling if
Drift method constraints suggest a slightly different form.

```drift
pub struct ClientConfig { ... }
pub struct Session { ... }
pub struct ClientRequest { ... }
pub struct ClientResponse { ... }
pub struct ClientError { ... }

pub fn new_client_config() nothrow -> ClientConfig
pub fn new_session(cfg: ClientConfig) nothrow -> Session

// Request builder
pub fn new_request(method: String, url: String) nothrow -> ClientRequest
pub fn set_header(req: &mut ClientRequest, name: String, value: String) nothrow -> Void
pub fn set_body(req: &mut ClientRequest, body: Array<Byte>) nothrow -> Void
pub fn set_body_string(req: &mut ClientRequest, body: String) nothrow -> Void
pub fn set_json_body(req: &mut ClientRequest, json: String) nothrow -> Void

// Primary send path
pub fn send(session: Session, req: ClientRequest) nothrow -> core.Result<ClientResponse, ClientError>

// Session convenience helpers
pub fn get(session: Session, url: String) nothrow -> core.Result<ClientResponse, ClientError>
pub fn post(session: Session, url: String, body: Array<Byte>) nothrow -> core.Result<ClientResponse, ClientError>
pub fn put(session: Session, url: String, body: Array<Byte>) nothrow -> core.Result<ClientResponse, ClientError>
pub fn delete(session: Session, url: String) nothrow -> core.Result<ClientResponse, ClientError>

// Optional secondary helper
pub fn send_once(cfg: &ClientConfig, req: ClientRequest) nothrow -> core.Result<ClientResponse, ClientError>
```

Notes:

- if Drift method syntax is appropriate and ergonomically better, the user-facing
  shape can become `session.send(...)`, `session.get(...)`, etc.
- if the implementation needs free functions for now, keep docs/examples aligned
  with the session-centric model, not the old config-centric model
- `new_session(cfg)` should consume config by move, not copy
- by-value `Session` parameters are acceptable here because `Session` is intended
  to be a cheap shared handle, not heavyweight owned state

## Copy semantics

`Session` should be cheap to copy.

That is important because real applications will often:

- pass session handles through helper layers
- share a session across fibers/tasks
- carry potentially heavy session-backed state such as a cookie jar later

The handle must therefore be cheap to pass around even if the internal state
later becomes large.

Do NOT make ordinary sharing depend on `clone()` or `clone_deep()`.

## Thread/fiber safety

`Session` is intended to be safe to share across fibers/threads.

That requirement should be explicit now, even if the first implementation does
not yet contain pooling or cookie logic.

Why:

- real applications often pass a client/session through multiple fibers
- cookie state is shared mutable session state
- future pooling is also shared mutable session state

This does not require solving the entire synchronization design in this plan,
but it does mean the internal `Session` representation should be built with
shared-state synchronization in mind from the beginning.

Consequence:

- internal design should assume a `SessionInner`-style shared object behind the
  public handle
- mutable shared pieces such as a future cookie jar will require explicit
  synchronization
- that cost is acceptable because correctness and API stability are the priority

Locking guidance:

- do not treat locking itself as a design failure
- uncontended or lightly contended locks are acceptable
- the real performance concern is contention, not the mere presence of locks
- start from a correct synchronized design
- avoid obvious global choke points in the request path
- only refine lock granularity when real contention appears

## Cookies

Cookies are the immediate driver for this change.

Required direction:

- cookie storage belongs to `Session`
- request send path should be able to consult session cookies later
- response handling should be able to update session cookies later

Cookie implementation itself does not have to land in the same patch as the
API shift, but the API shift must happen first so cookie support lands on the
right abstraction.

Important implementation note:

- a real cookie jar is mutable shared state
- behind an Arc-like session handle, that means synchronization will be needed
- the plan does not need to pin the exact internal primitive yet, but the
  `Session` design should leave an obvious slot for synchronized cookie state
- using locks for cookie/pool state is acceptable; the design should focus on
  avoiding unnecessary contention, not on avoiding locks at all costs

## Pooling

Pooling is not required for this API change, but the API must not block it.

Future pooling should fit naturally inside `Session`:

- keyed internally by origin / destination
- invisible to request construction
- additive with no public API replacement

That is the main reason not to continue expanding the stateless `send(cfg, req)`
surface.

## Redirects

Redirect support, if later added, should also live at session level:

- redirect policy belongs to session config/state
- redirect-follow bookkeeping belongs to session send logic

This is another reason to avoid treating the one-shot path as primary.

## Migration direction

We are intentionally dropping the current one-shot-first UX as the primary
design direction.

Implementation strategy:

1. Introduce `Session` and the session-based send path.
2. Rework examples/docs to teach `Session` first.
3. Convert current internals so the session path is canonical.
4. Keep `send_once(...)` only if useful as thin sugar.
5. Do not add more public one-shot convenience API beyond that.

## Immediate implementation expectations

What Klaudia should do next:

1. Design and implement `Session` as a cheap copyable handle.
2. Convert the main send path to be session-based.
3. Add session-level verb helpers:
   - GET
   - POST
   - PUT
   - DELETE
4. Keep request-builder support for nontrivial requests.
5. Preserve current HTTP/HTTPS behavior and tests while shifting the API.
6. Update examples and docs so session usage is the default story.

## Non-goals for this step

Do not expand scope here into:

- connection pooling implementation
- cookie parsing/persistence implementation
- redirect implementation
- retries
- HTTP/2
- broader auth middleware/convenience systems

This step is specifically about fixing the public abstraction boundary now.

## Acceptance criteria

This API-shift step is complete when:

- `Session` exists as the primary client abstraction
- the main public docs/examples use session-first calls
- current HTTP and HTTPS tests still pass
- one-shot is no longer the primary recommended UX
- the code structure leaves an obvious home for cookie jar state
- the code structure leaves an obvious home for future pooling

## Summary

We are choosing one robust client model now instead of maintaining a
fragmented surface.

Decision:

- session-first API
- cheap copyable `Session` handle
- request remains per-call
- future cookies/pooling/redirects hang off `Session`
- one-shot helper, if kept, is secondary only
