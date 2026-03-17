# Session Follow-Up TODO

These items are intentionally deferred until the session-first API shift is
implemented and reviewed cleanly.

## Next features after session support

- cookies
- permanent redirect caching
- TLS/TCP connection reuse
- examples update/refresh

## Examples

Examples should be updated once the session-first API shift lands so they teach
the correct client model.

Required follow-up:

- refresh existing `web.client` examples to use the session-first API
- add examples that reflect realistic usage, not just one-shot toy calls
- keep examples aligned with the public docs and recommended client usage
- update `README.md` examples/snippets to use the session-first API

## Cookies

Cookie work must include behavioral tests, not just storage/replay tests.

Required test expectation:

- the test server must be able to detect when the client incorrectly sends or
  withholds cookies
- tests should prove that the client honors cookie security rules rather than
  merely storing cookie values

Minimum cookie-security coverage to add:

- `Secure` cookies are sent only over HTTPS
- cookies are not sent to unrelated hosts/origins
- domain scoping is enforced correctly
- path scoping is enforced correctly
- cookie overwrite/update behavior is correct

If expiration / Max-Age lands in the first cookie pass, add tests for that too.

## Permanent redirects

Add redirect behavior only after session support is stable.

When implemented, include tests for:

- honoring permanent redirect responses
- caching permanent redirect results at session level where appropriate
- not applying cached redirect behavior outside the correct origin/path scope

## Connection reuse

Add connection reuse only after session support is stable.

When implemented, include tests for:

- TCP connection reuse
- TLS session/connection reuse behavior as applicable to the client design
- no cross-origin reuse bugs
- correct fallback when reuse is not possible
- isolation behavior when multiple sessions are used intentionally
