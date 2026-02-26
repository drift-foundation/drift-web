# JWT Initial Plan

Status: done
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

## Blocking Findings (all resolved)

1. ~~Compile blocker~~: Fixed. `lib.drift` TAG_* constants now use inline string literals instead of `errors.TAG_*` references.

2. ~~Temporal arithmetic safety~~: Fixed. `claims.drift` comparisons rearranged to avoid overflow:
   - `now > exp + skew` → `now - skew > exp`
   - `now + skew < nbf` → `nbf - skew > now`
   - `iat > now + max` → `iat - now > max`

3. ~~Strict-first `typ` behavior~~: Fixed. `verify.drift` now rejects missing `typ` when `require_typ_jwt=true`. Added two new test scenarios in `strictness_test.drift` to cover missing-typ accept/reject paths.

## Validation

- `just jwt-check-par` passed (compile + serial run of all 5 unit tests).

## Next Actions

1. Start next plan for integration-facing docs and examples.
