# drift-web Integration Guide

Web framework and HTTP client for Drift: inbound REST server, outbound
HTTP/HTTPS client, and HS256 JWT authentication.

This guide covers everything needed to consume the published `drift-web`
signed packages.

## Published packages

| Package | Module | Description |
|---|---|---|
| `web-jwt` | `web.jwt` | HS256 JWT sign/verify with temporal claims validation |
| `web-rest` | `web.rest` | HTTP/1.1 REST server with routing, guards, and JSON body handling |
| `web-client` | `web.client` | HTTP/1.1 and HTTPS client for outbound requests |

`web-rest` depends on `web-jwt` (resolved automatically). `web-client`
is independent and provides outbound HTTP/HTTPS via `net-tls`.

## Consumer prerequisites

- Drift toolchain with `driftc` (runtime ABI 6 or later)
- Package artifacts under a shared library root (`.zdmp` + `.sig`)
- The publisher's `.author-profile` (shipped inside the versioned
  artifact directory)
- Trust established via `drift trust`

## Trust and signed package setup

drift-web is consumed through Drift's signed package flow. Consumers
need the package artifact, its signature sidecar, and the correct trust
setup.

### What Drift verifies

Drift distinguishes between two trust domains:

- **Bundled stdlib**: the deployed toolchain ships `std.zdmp` and its
  detached signature sidecar. The compiler verifies stdlib against the
  bundled core trust store that ships with the toolchain.
- **User / third-party packages**: packages such as drift-web are
  verified against the consumer's trust store. Trust is established by
  importing the publisher's `.author-profile` via `drift trust`.

### Trust setup

Obtain the publisher's `.author-profile` (included in the published
artifact directory) and import it:

```bash
drift trust $DRIFT_PKG_ROOT/web-rest/<version>/.author-profile
```

Drift shows the publisher metadata, key fingerprint, and namespace
claims (e.g. `web.jwt.*`, `web.rest.*`, `web.client.*`). Review and
confirm trust explicitly. Drift updates the local trust store
automatically.

This replaces manual trust store JSON editing. The `drift trust` command
is the primary consumer path for establishing package trust.

### Package root layout

```
<library-root>/
  web-jwt/
    <version>/
      web-jwt.zdmp
      web-jwt.sig
      .author-profile
  web-rest/
    <version>/
      web-rest.zdmp
      web-rest.sig
      .author-profile
  web-client/
    <version>/
      web-client.zdmp
      web-client.sig
      .author-profile
```

The `.author-profile` is published automatically by `drift deploy`
inside each versioned artifact directory.

### What to distribute

For signed-package consumption, publish:

- The package artifact (`.zdmp`)
- Its detached signature sidecar (`.sig`)
- The publisher's `.author-profile`

All three are published automatically by `drift deploy`. Consumers
import the `.author-profile` via `drift trust` to establish trust.

## Compilation

### REST server application

```bash
driftc --target-word-bits 64 \
    --package-root "$DRIFT_PKG_ROOT" \
    --dep web-rest@<version> \
    --dep web-jwt@<version> \
    --entry main::main \
    -o my_server \
    my_server.drift
```

### HTTP client application

```bash
driftc --target-word-bits 64 \
    --package-root "$DRIFT_PKG_ROOT" \
    --dep web-client@<version> \
    --entry main::main \
    -o my_client \
    my_client.drift
```

`--package-root` points to the library root (not the version directory).
`--dep` selects exact versions. The compiler resolves the package at
`<package-root>/<package>/<version>/<package>.zdmp`.

Pin all consumed packages explicitly. When multiple versions coexist
under the same package root, `--dep` ensures deterministic version
selection.

`web-client` depends on `net-tls`. The compiler reads `net-tls`'s
native dependencies (`ssl`, `crypto`) from the signed `.zdmp` metadata
and applies them automatically — consumers do not need `--link-lib`
flags.

### Development bypass

During development, use `--allow-unsigned-from` to skip signature
verification for unsigned or locally-built packages:

```bash
driftc --target-word-bits 64 \
    --package-root /path/to/libs \
    --dep web-rest@<version> \
    --dep web-jwt@<version> \
    --allow-unsigned-from /path/to/libs \
    --entry main::main \
    -o my_server \
    my_server.drift
```

Package metadata (dependencies, unsafe scoping) is still read from the
`.zdmp` — `--allow-unsigned-from` only bypasses signature verification.

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

The `Session` API is the primary client interface. Sessions manage TLS
configuration and cookie state across requests.

## Scope

drift-web provides:

- HTTP/1.1 REST server (inbound request handling)
- HTTP/1.1 and HTTPS outbound client (session-based)
- Route matching with path parameters
- Wrapping middleware (global and per-RouteGroup) and route-group guards
- JSON body parsing and caching
- HS256 JWT authentication
- Structured error envelopes
- Cookie management (session-scoped)

drift-web does not provide:

- TLS termination for inbound (use a reverse proxy)
- WebSocket or streaming transport
- Database connectivity
- Connection pooling
- Redirect following
- Automatic retries

## API documentation

- [Effective web-jwt usage](effective-web-jwt.md) — JWT API, sign/verify
  patterns, temporal claims, error tags
- [Effective web-rest usage](effective-web-rest.md) — REST server API,
  routing, route-group guards, wrapping middleware, Context slot map,
  error envelopes, request accessors

## Troubleshooting

If package consumption fails, identify the phase:

| Phase | Symptom |
|---|---|
| **Trust** | `drift trust` rejects the `.author-profile` (bad signature, key mismatch) |
| **Verification** | Signature rejected, untrusted signer, missing `.sig` |
| **Package load** | Crash during metadata import |
| **Checker** | Type errors referencing package types |
| **Codegen** | LLVM errors |
| **Link-time** | Undefined symbols (often missing native libs for `net-tls`) |
| **Runtime** | Crash or incorrect behavior after successful build |

When reporting an issue, include:

- Exact compiler version (`driftc --version`)
- Exact `--dep` pins used
- Trust store mode (author-profile via `drift trust`, or `--allow-unsigned-from`)
- Target endpoint / minimal reproduction
