# drift-web

Server-side web framework for Drift. Published as signed packages for
downstream consumption via `driftc --package-root`.

## Packages

| Package | Module | Description |
|---|---|---|
| `web-jwt` | `web.jwt` | HS256 JWT sign/verify with temporal claims validation |
| `web-rest` | `web.rest` | HTTP/1.1 REST server with routing, guards, and JSON body handling |

`web-rest` depends on `web-jwt`. Most applications should depend on both.

## Quick start

See [docs/integration.md](docs/integration.md) for full consumer setup,
trust store configuration, and compilation instructions.

## Documentation

- [Integration guide](docs/integration.md) — package consumption, trust
  setup, compilation
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
just deploy -- --dest=~/opt/drift/libs   # build, sign, smoke, publish
```

Requirements: `just`, `bash`, `driftc` 0.27.59+, `DRIFT_SIGN_KEY_FILE`
for deploy.

## Repository layout

```text
packages/
  web-jwt/        # JWT sign/verify
  web-rest/       # REST server framework
docs/             # Usage guides and design docs
tools/            # Test runners
drift-package.json
drift/trust.json  # Project-local trust store
```
