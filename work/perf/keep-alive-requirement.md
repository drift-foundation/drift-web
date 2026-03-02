# Keep-Alive Requirement for Meaningful HTTP Benchmarks

## Problem

The current REST server sends `Connection: close` on every response. This forces every request to pay the full TCP lifecycle cost:

1. TCP 3-way handshake (SYN / SYN-ACK / ACK)
2. Request write + response read
3. TCP teardown (FIN / ACK / FIN / ACK)

On our debug build, a sequential `GET /health` benchmark measures ~10ms per request (~98 req/sec). The vast majority of that time is TCP connection establishment and teardown, not framework work (routing, dispatch, serialization). The benchmark is measuring the OS networking stack, not `web.rest`.

## Why this matters

HTTP/1.1 defaults to persistent connections (`Connection: keep-alive`). Every production HTTP server and every credible framework benchmark assumes keep-alive as the baseline. The standard benchmark suites (TechEmpower, wrk, h2load) reuse connections across thousands of requests.

With keep-alive, the per-request cost reduces to:

1. Read request bytes from an already-open socket
2. Parse, route, dispatch, serialize
3. Write response bytes to the same socket

The TCP handshake and teardown are paid once per connection, amortized across all requests on that connection. This is the only mode that isolates framework overhead from OS networking overhead.

Without keep-alive, our benchmarks conflate two unrelated costs. Any performance data we collect is dominated by TCP lifecycle, making it:

- **Useless for framework optimization** — changes to routing, dispatch, or serialization are invisible under TCP noise.
- **Useless for cross-framework comparison** — every other framework benchmarks with keep-alive; our numbers would be artificially 10-100x worse.
- **Useless for regression detection at the framework layer** — a 2x regression in dispatch time would be invisible inside a 10ms TCP-dominated measurement.

## What we need

HTTP/1.1 persistent connections with `Connection: keep-alive` as the default response behavior:

- Server keeps the socket open after writing the response.
- Server re-enters the read loop on the same connection for the next request.
- `Connection: close` is sent only when the server or client explicitly opts out.
- A configurable idle timeout closes connections that have been silent for too long.

## Scope

This is not a large surface change. The accept loop in `server.drift` already handles one request per `_handle_connection` call. The change is:

1. Move from "accept → handle → close" to "accept → loop { handle } → close".
2. Default response header changes from `Connection: close` to `Connection: keep-alive`.
3. Add idle timeout on the read side to reclaim abandoned connections.
4. Respect `Connection: close` from the client request headers.

## Current benchmark status

The perf harness (`just rest-perf`) exists and runs. The `baseline-health` benchmark produces stable numbers. But until keep-alive lands, the absolute values measure TCP overhead, not framework performance. Relative comparisons between scenarios (e.g., bare health vs guarded endpoint) are still directionally valid, since all pay the same TCP tax.

## Recommendation

Keep-alive should be the next server-level feature after the current stress test suite is finalized. The perf harness is ready to measure the before/after impact immediately.
