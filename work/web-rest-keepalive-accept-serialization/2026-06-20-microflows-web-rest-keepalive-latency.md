# BUG REPORT — web.rest server: sequential keep-alive client connections → ~2.3s/request + alternating connection failures

**From:** Microflows (`work/business-team-starter-kit`) — coordinator + participant services are `web.rest` servers; the coordinator dispatches to participants via `web.client`.
**Toolchain:** `driftc 0.33.45 | abi 17 | git 01cee266` (certified)
**Packages:** `web-rest@0.5.4`, `web-client@0.4.2`, `net-tls@0.5.2`
**Severity:** HIGH for long-running services. Every participant dispatch pays ~2.3s and ~half the
connections fail (then reconcile/retry); a workflow with ≥4 remote operations exceeds request timeouts,
and the long-running `microflows-service` degrades as connections accumulate. A stock Python HTTP/1.1
server under the **identical** `web.client` load is instant with zero failures.

## Symptom

A client that issues **sequential requests, each on a fresh `web.client` session** (a new TCP
connection with the default `Connection: keep-alive`), against a **`web.rest` server**, sees:

- **~2.3s per request** (close to, but under, the client `io_timeout`), and
- **alternating failures** — every other request fails at the send/connect stage (`send-error`),
  the next succeeds, repeating.

The same client code against a stock **Python `http.server` (HTTP/1.1, keep-alive, Content-Length)**
returns **instantly with no failures**, so the client (`web.client`) is fine — the defect is in the
**`web.rest` server's** handling of a keep-alive connection that the client opens, uses once, and closes.

## Minimal repro (no DB, no Microflows — two ~40-line Drift programs)

`src/server.drift` — a minimal `web.rest` server, `GET /ping -> {"ok":1}`:

```drift
module wcserver;
import std.core as core; import std.console as console; import std.cli as cli;
import std.concurrent as conc; import web.rest as rest;
fn main(argv: Array<String>) nothrow -> Int {
    var p = cli.parser("wcserver","0.1.0","minimal web.rest server");
    val _ = p.option_int("port","p","PORT","listening port",true);
    var port = 8090;
    match p.parse(argv) { core.Result::Ok(pr) => { match pr.get_int("port",p) { Some(v)=>{port=v;}, None=>{} } }, core.Result::Err(_) => { return 2; } }
    return try _run(port) catch unexpected { 1 };
}
fn _run(port: Int) throws -> Int {
    var ab = rest.new_app_builder(); rest.bind(ab,"127.0.0.1",port);
    var app = rest.build_app(move ab);
    rest.add_throws_route(app,"GET","/ping", |req,ctx| captures() => { return rest.json_response(200,"{\"ok\":1}"); }).or_throw();
    var running = rest.start(move app, conc.Duration(millis=0));
    val _ = conc.await_signal(); val _ = rest.shutdown(running); return 0;
}
```

`src/bench.drift` — a `web.client` caller doing COUNT sequential GETs, **fresh session each** (exactly
how a coordinator dispatches each participant call):

```drift
module wcbench;
import std.core as core; import std.console as console; import std.io as io; import web.client as client;
fn main(argv: Array<String>) nothrow -> Int {
    val url = _dup(&argv[1]); var count = 10; var io_timeout_ms = 3000;   // argv[2], argv[3] optional
    var i = 0;
    while i < count {
        var cfg = client.new_client_config(); client.with_io_timeout(&mut cfg, io_timeout_ms);
        var session = client.new_session(move cfg);
        var req = client.new_request("GET", _dup(&url));
        match client.send(&session, move req) {
            core.Result::Ok(resp) => { match client.response_body_string(&resp) {
                core.Result::Ok(_) => { console.println("req ok " + _itoa(resp.status)); },
                core.Result::Err(_) => { console.println("body-read-error"); } } },
            core.Result::Err(_) => { console.println("send-error"); }
        }
        i = i + 1;
    }
    return 0;
}
// _dup / _itoa: trivial helpers (full source in the repro bundle)
```

Build (both, with the certified toolchain):

```
PKG=$HOME/opt/drift/certified/current/libs
driftc --target-word-bits 64 --trust-store drift/trust.json --package-root $PKG \
  --dep web-rest@0.5.4 --dep web-jwt@0.4.2 --dep net-tls@0.5.2 --entry wcserver::main src/server.drift -o wcserver
driftc --target-word-bits 64 --trust-store drift/trust.json --package-root $PKG \
  --dep web-client@0.4.2 --dep net-tls@0.5.2 --entry wcbench::main src/bench.drift -o wcbench
```

Run (start `wcserver --port P`, then `wcbench http://127.0.0.1:P/ping 10 3000`), and the same wcbench
against a one-liner Python HTTP/1.1 server for comparison.

## Observed

```
web.rest  (wcserver) : 10 reqs in 23.0s  | 200s=5  send-errors=5   (alternating ok/err)
python HTTP/1.1      : 10 reqs in  0.0s  | 200s=10 send-errors=0
```

The `web.rest` server's own response, captured on the wire, is correct and immediate:
`HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: 53\r\nConnection: keep-alive\r\n\r\n{…}`
— and the server then keeps the socket open (no EOF), as expected for keep-alive. So the response is
well-formed; the latency/failure is in how the server services the *next* fresh connection after a
keep-alive client closes the previous one.

## Expected

Sequential fresh-connection requests to a `web.rest` server should complete promptly (sub-millisecond
on localhost), as they do against a stock HTTP/1.1 server — no per-request stall, no alternating
connection failures.

## Suspected area

`web.rest` server connection/accept loop (epoll fiber, `packages/web-rest/src/server.drift`):
handling of a keep-alive connection that the client closes after a single request appears to block or
desynchronize the accept of the *next* connection for ~`io_timeout`, with a 2-state oscillation
(one stalls/fails, the next recovers). The client side (`web.client`, fresh session per request with
`Connection: keep-alive`) is exonerated by the Python-server comparison.

## Repro bundle

Self-contained build dir (manifest/trust/lock + both sources + a driver script) at
`/tmp/wcbench/` on this host; the alternating output and timings above are reproduced on every run.

## Impact / ask

Blocks Microflows roadmap item 4 (multi-operation business workflows): any workflow with ≥4 remote
dispatches exceeds service request timeouts, and the long-running coordinator service degrades under
sustained dispatch. No client-side workaround applied (the server is the defect). Requesting a
root-cause fix + certification.
