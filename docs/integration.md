# drift-web Integration Guide

Server-side web framework for Drift: routing, guards, JSON body handling,
and HS256 JWT authentication.

## Published packages

| Package | Version | Module | Description |
|---|---|---|---|
| `web-jwt` | 0.1.0 | `web.jwt` | HS256 JWT sign/verify with temporal claims validation |
| `web-rest` | 0.1.0 | `web.rest` | HTTP/1.1 REST server with routing, guards, and JSON body handling |

`web-rest` depends on `web-jwt` — the dependency is declared in package
metadata and resolved automatically. Typical REST applications depend on
`web-rest`; the compiler pulls in `web-jwt` as a transitive dependency.

If you only need JWT sign/verify without the REST framework, `web-jwt`
can be consumed standalone.

## Consumer prerequisites

- Drift toolchain with driftc **0.27.59** or later (ABI 5)
- Both package artifacts (`.dmp` + `.sig` sidecars) under a shared
  library root
- A trust store authorizing the drift-web signing key for the
  `web.jwt.*` and `web.rest.*` namespaces

### Package root layout

```
<library-root>/
  web-jwt/
    0.1.0/
      web-jwt.dmp
      web-jwt.dmp.sig
  web-rest/
    0.1.0/
      web-rest.dmp
      web-rest.dmp.sig
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
    "web.rest.*": ["ed25519:<kid>"]
  },
  "revoked": []
}
```

The `kid` and `pubkey` values come from the `.sig` sidecar files
installed alongside each `.dmp`. Then export the environment variable:

```bash
export DRIFT_TRUST_STORE="$HOME/.config/drift/trust.json"
```

## Compilation

```bash
export DRIFT_TRUST_STORE="$HOME/.config/drift/trust.json"

driftc --target-word-bits 64 \
    --package-root ~/opt/drift/libs \
    --dep web-rest@0.1.0 \
    --dep web-jwt@0.1.0 \
    --entry main::main \
    -o my_app \
    my_app.drift
```

`--package-root` points to the library root (not the version directory).
`--dep` selects exact versions. The compiler resolves each package at
`<package-root>/<name>/<version>/<name>.dmp`.

Pin exact versions with `--dep`. The compiler never silently picks
"latest" — if multiple versions coexist and no `--dep` is provided,
compilation fails. Both `web-rest` and `web-jwt` must be pinned
explicitly when multiple versions are installed.

Consumers do not need `--allow-unsafe` or `--link-lib` flags. Neither
package uses unsafe code or native dependencies.

## Minimal example

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

    var app = match rest.build_app(move b) {
        core.Result::Ok(a) => { a },
        core.Result::Err(_) => { return 1; }
    };

    match rest.add_route(&mut app, "GET", "/health", health_handler) {
        core.Result::Ok(_) => {},
        core.Result::Err(_) => { return 2; }
    }

    match rest.start(move app, conc.Duration(millis = 5000)) {
        core.Result::Ok(srv) => {
            // Server is running. Shut down on signal or after work.
            var running = move srv;
            match rest.shutdown(&mut running) {
                core.Result::Ok(_) => { return 0; },
                core.Result::Err(_) => { return 3; }
            }
        },
        core.Result::Err(_) => { return 4; }
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
- Route matching with path parameters
- Guard and filter middleware
- JSON body parsing and caching
- HS256 JWT authentication
- Structured error envelopes

drift-web does not provide:

- Outbound HTTP client
- TLS termination (use a reverse proxy or `net-tls` for outbound)
- WebSocket or streaming transport
- Database connectivity

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

Ensure you are on driftc 0.27.59 or later. If the issue persists, report
it with the failing phase and a minimized reproduction.
