# JWT Integration Readiness Plan

Status: in_progress
Owner: JWT team
Date: 2026-02-26

## Goal

Prepare `web.jwt` for integration usage by downstream web projects with clear runtime patterns and end-to-end validation coverage.

## Scope

1. Document middleware-facing integration contract (`JwtError.tag` mapping guidance).
2. Add example app using `std.time.utc_unix_seconds_now()` for verification.
3. Add e2e-style test that validates real-time sourcing path and strict default policy behavior.

## Completed

- Added example app:
  - `examples/web_jwt_basic/main.drift`
  - demonstrates sign + verify flow and `std.time.utc_unix_seconds_now()` sourcing.
- Added e2e-style test:
  - `packages/web-jwt/tests/e2e/realtime_default_policy_test.drift`
  - covers:
    - runtime `now_unix` sourced from `std.time.utc_unix_seconds_now()`
    - strict default policy path (`require_typ_jwt=true`) rejecting missing `typ`.
- Added e2e recipe:
  - `just jwt-e2e-par`
  - wired into `just test` after unit suite.

## Next Actions

1. Expand docs with middleware mapping table (`JwtError.tag` -> HTTP auth response category).
2. Decide and document claim-helper API timing (`iss/aud/sub` helpers now vs post-MVP).
