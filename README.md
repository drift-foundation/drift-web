# drift-web

Drift web ecosystem workspace.

This repository hosts foundational user-land `web.*` packages intended for publication and reuse across Drift applications.

## Packages

1. `packages/web-jwt`
- Module: `web.jwt`
- Scope: compact JWS JWT (`HS256`) sign/verify with strict validation and temporal claim policy.

Planned next packages:
- `web.rest` (REST framework)
- `web.streaming` (streaming/web transport primitives)

## Current scope (JWT MVP)

- Compact JWT (`header.payload.signature`)
- `HS256` only
- Strict base64url handling
- Signature verification over original token segments
- Temporal claim validation (`exp`, `nbf`, `iat`) with explicit policy

## Docs

- JWT handoff notes: `docs/web-jwt.md`
- JWT design contract: `docs/jwt-webtoken-design.md`
- Effective JWT usage guide: `docs/effective-web-jwt.md`
- Project layout/template reference: `docs/project-setup.md`

## Development

Primary recipes:
- `just test`
- `just jwt-check-par`
- `just jwt-check-unit packages/web-jwt/tests/unit/sign_verify_test.drift`
- `just jwt-compile-check`

Requirements:
- `just`
- `bash`
- `driftc` (set `DRIFTC` env var)

## Repository layout

```text
packages/
  web-jwt/
docs/
work/
history.md
AGENTS.md
```

## Status

- API/design and package structure are in place.
- See `work/initial/plan.md` for active blockers and completion criteria.
