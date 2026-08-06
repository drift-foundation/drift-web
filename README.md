# drift-web

Web framework and HTTP client for Drift. Published as signed packages
for downstream consumption via `driftc --package-root`.

## Packages

| Package | Module | Description |
|---|---|---|
| `web-jwt` | `web.jwt` | HS256 JWT sign/verify with temporal claims validation |
| `web-rest` | `web.rest` | HTTP/1.1 REST server with routing, guards, and JSON body handling |
| `web-client` | `web.client` | HTTP/1.1 and HTTPS client for outbound requests |

`web-rest` depends on `web-jwt`. `web-client` is independent and provides outbound HTTP/HTTPS.

## Quick start

See [docs/integration-guide.md](docs/integration-guide.md) for full
consumer setup, trust store configuration, and compilation instructions.

## Documentation

- [Integration guide](docs/integration-guide.md) — package consumption,
  trust setup, compilation
- [Effective web-jwt](docs/effective-web-jwt.md) — JWT API reference and
  usage patterns
- [Effective web-rest](docs/effective-web-rest.md) — REST server API,
  routing, guards, error envelopes
- [Project setup template](docs/project-setup.md) — Drift library project
  conventions

## Development

```bash
# All recipes resolve driftc/drift from DRIFT_TOOLCHAIN_ROOT and packages
# from DRIFT_PKG_ROOT. During certification point both at the staged lane:
export DRIFT_TOOLCHAIN_ROOT=$HOME/opt/drift/staged/toolchain/drift-0.35.0+abi22
export DRIFT_PKG_ROOT=$HOME/opt/drift/staged/libs
# Outside certification, use the certified snapshot instead:
#   export DRIFT_TOOLCHAIN_ROOT=$HOME/opt/drift/certified/current/toolchain
#   export DRIFT_PKG_ROOT=$HOME/opt/drift/certified/current/pkgs
export DRIFT_SIGN_KEY_FILE=/path/to/signing-key.seed   # deploy/reseal only

just test                    # full test suite
just deploy                  # build, sign, smoke, publish
```

Requirements: `just`, `bash`, `driftc` (0.35.0+ / ABI 22),
`DRIFT_SIGN_KEY_FILE` for deploy. ABI 22 changed the `String`
representation: ABI 21 objects/packages cannot link against ABI 22
artifacts and must be rebuilt. 0.33.91 additionally rejects redundant
argument-position borrows (`E_REDUNDANT_ARG_BORROW`) — when a parameter
is declared `&T`/`&mut T`, pass the value bare; the sources and docs
use that spelling.

## Repository layout

```text
packages/
  web-jwt/        # JWT sign/verify
  web-rest/       # REST server framework
  web-client/     # Outbound HTTP/HTTPS client
examples/         # Small consumer examples
docs/             # Usage guides and design docs
tools/            # Test runners
drift/manifest.json
drift/trust.json  # Project-local trust store
```
