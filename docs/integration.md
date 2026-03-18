# drift-web Integration Guide

Web framework and HTTP client for Drift: inbound REST server, outbound
HTTP/HTTPS client, and HS256 JWT authentication.

## Published packages

| Package | Version | Module | Description |
|---|---|---|---|
| `web-jwt` | 0.2.1 | `web.jwt` | HS256 JWT sign/verify with temporal claims validation |
| `web-rest` | 0.2.1 | `web.rest` | HTTP/1.1 REST server with routing, guards, and JSON body handling |
| `web-client` | 0.2.1 | `web.client` | HTTP/1.1 and HTTPS client for outbound requests |

`web-rest` depends on `web-jwt` (resolved automatically). `web-client`
is independent and provides outbound HTTP/HTTPS via `net-tls`.

## Consumer prerequisites

- Drift toolchain with driftc **0.27.71** or later (runtime ABI 6)
- Package artifacts under a shared library root
- A trust store authorizing the drift-web signing key for the
  `web.jwt.*`, `web.rest.*`, and `web.client.*` namespaces

### Package root layout

```
<library-root>/
  web-jwt/
    0.2.1/
      web-jwt.zdmp
      web-jwt.sig
  web-rest/
    0.2.1/
      web-rest.zdmp
      web-rest.sig
  web-client/
    0.2.1/
      web-client.zdmp
      web-client.sig
```

### Trust store setup

Create a trust store file (e.g. `~/.config/drift/trust.json`) that
authorizes the drift-web signing key:

```json
{
  "format": "drift-trust",
  "version": 0,
  "keys": {
    "ed25519:<kid>": {
      "algo": "ed25519",
      "pubkey": "<pubkey>"
    }
  },
  "namespaces": {
    "web.jwt.*": ["ed25519:<kid>"],
    "web.rest.*": ["ed25519:<kid>"],
    "web.client.*": ["ed25519:<kid>"]
  },
  "revoked": []
}
```

The `kid` and `pubkey` values come from the `.sig` sidecar files
installed alongside each package. Then export the environment variable:

```bash
export DRIFT_TRUST_STORE="$HOME/.config/drift/trust.json"
```

## Compilation

### REST server application

```bash
driftc --target-word-bits 64 \
    --package-root ~/opt/drift/libs \
    --dep web-rest@0.2.1 \
    --dep web-jwt@0.2.1 \
    --entry main::main \
    -o my_server \
    my_server.drift
```

### HTTP client application

```bash
driftc --target-word-bits 64 \
    --package-root ~/opt/drift/libs \
    --dep web-client@0.2.1 \
    --entry main::main \
    -o my_client \
    my_client.drift
```

`--package-root` points to the library root (not the version directory).
`--dep` selects exact versions. Pin all consumed packages explicitly.

## Minimal client example

```drift
module main;

import std.core as core;
import std.console as console;
import std.format as fmt;
import web.client as client;

fn main() nothrow -> Int {
    var cfg = client.new_client_config();
    client.with_tls_trust_store(&mut cfg,
        client.TrustStore::PemFile(path = "/etc/ssl/certs/ca-certificates.crt"));

    var session = client.new_session(move cfg);

    match client.get(&session, "https://api.example.com/health") {
        core.Result::Ok(resp) => {
            console.println("status=" + fmt.format_int(resp.status));
            return 0;
        },
        core.Result::Err(e) => {
            console.println("failed: " + e.tag);
            return 1;
        }
    }
}
```

For custom requests:

```drift
var req = client.new_request("POST", "https://api.example.com/items");
client.set_header(&mut req, "Accept", "application/json");
client.set_json_body(&mut req, "{\"name\":\"x\"}");

match client.send(&session, move req) {
    core.Result::Ok(resp) => { ... },
    core.Result::Err(e) => { ... }
}
```

## Minimal server example

```drift
module main;

import std.core as core;
import std.concurrent as conc;
import web.rest as rest;

fn health_handler(req: &rest.Request, ctx: &mut rest.Context) nothrow -> core.Result<rest.Response, rest.RestError> {
    return core.Result::Ok(rest.json_response(200, "{\"ok\":true}"));
}

fn main() nothrow -> Int {
    var b = rest.new_app_builder();
    rest.bind(&mut b, "0.0.0.0", 8080);

    match rest.build_app(move b) {
        core.Result::Err(_) => { return 1; },
        core.Result::Ok(a) => {
            var app = move a;
            match rest.add_route(&mut app, "GET", "/health", health_handler) {
                core.Result::Err(_) => { return 2; },
                core.Result::Ok(_) => {}
            }
            match rest.start(move app, conc.Duration(millis = 5000)) {
                core.Result::Err(_) => { return 3; },
                core.Result::Ok(srv) => {
                    var running = move srv;
                    match rest.shutdown(&mut running) {
                        core.Result::Ok(_) => { return 0; },
                        core.Result::Err(_) => { return 4; }
                    }
                }
            }
        }
    }
}
```

## API documentation

- [Effective web-jwt usage](effective-web-jwt.md) — JWT API, sign/verify
  patterns, temporal claims, error tags
- [Effective web-rest usage](effective-web-rest.md) — REST server API,
  routing, guards, filters, error envelopes, request accessors

## Scope

drift-web provides:

- HTTP/1.1 REST server (inbound request handling)
- HTTP/1.1 and HTTPS outbound client (session-based)
- Route matching with path parameters
- Guard and filter middleware
- JSON body parsing and caching
- HS256 JWT authentication
- Structured error envelopes

drift-web does not provide:

- TLS termination for inbound (use a reverse proxy)
- WebSocket or streaming transport
- Database connectivity
- Connection pooling (planned)
- Cookie management (planned)
- Redirect following (planned)

## Troubleshooting

If package consumption fails, identify the phase:

| Phase | Symptom |
|---|---|
| **Verification** | Signature rejected, untrusted signer, missing `.sig` |
| **Package load** | Crash during metadata import |
| **Checker** | Type errors referencing package types |
| **Codegen** | LLVM errors |
| **Link-time** | Undefined symbols |
| **Runtime** | Crash or incorrect behavior after successful build |

Ensure you are on driftc 0.27.71 or later. If the issue persists, report
it with the failing phase and a minimized reproduction.
