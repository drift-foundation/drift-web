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
export DRIFTC=/path/to/driftc
export DRIFT_SIGN_KEY_FILE=/path/to/signing-key.seed

just test                    # full test suite
just deploy                  # build, sign, smoke, publish
```

Requirements: `just`, `bash`, `driftc` (ABI 6+),
`DRIFT_SIGN_KEY_FILE` for deploy.

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
