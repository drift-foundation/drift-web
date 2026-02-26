# JWT Initial Plan

Status: in_progress
Owner: JWT team
Date: 2026-02-26

## Goal

Ship MVP `web.jwt` (`HS256` sign/verify + temporal claims) with stable API and passing unit suite.

## Naming Decision

- Ecosystem umbrella direction: `web.*` packages.
- JWT package/module standardized as:
  - package directory: `packages/web-jwt`
  - module root: `web.jwt`
- Documentation renamed for consistency:
  - `docs/web-jwt.md`
  - `docs/effective-web-jwt.md`

## Completed

- Drafted and aligned design docs:
  - `docs/jwt-webtoken-design.md`
  - `docs/effective-web-jwt.md`
- Implemented package structure:
  - `packages/web-jwt/src/{lib,model,errors,signing,verify,claims}.drift`
- Added unit tests:
  - `sign_verify_test.drift`
  - `claims_test.drift`
  - `policy_validation_test.drift`
  - `strictness_test.drift`
  - `error_tags_test.drift`
- Added test runner recipe wiring in `justfile`.
- Renamed package/module from `web-auth-jwt` / `web.auth.jwt` to `web-jwt` / `web.jwt` to align with `web.*` ecosystem naming.

## Blocking Findings (must fix before done)

1. Compile blocker:
`packages/web-jwt/src/lib.drift` exports `pub const TAG_* = errors.TAG_*`, which fails Drift v1 const-literal rules.

2. Temporal arithmetic safety:
`packages/web-jwt/src/claims.drift` uses unchecked additions in claim comparisons (`exp + skew`, `now + skew`, `now + max_future_iat`), which can overflow and misclassify tokens.

3. Strict-first `typ` behavior mismatch:
`verify` currently allows missing `typ` even when `require_typ_jwt=true`; confirm intended policy and enforce consistently.

## Next Actions

1. Replace const-alias pattern with compile-valid export strategy in `lib.drift`.
2. Make temporal comparisons overflow-safe.
3. Finalize and enforce `typ`-required semantics for strict policy.
4. Re-run `just jwt-check-par` and record green run.
5. Mark this plan done and append completion entry to `history.md`.
