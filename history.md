# History

## 2026-02-26

- Initialized project history tracking.
- Added JWT design and usage guidance:
  - `docs/jwt-webtoken-design.md`
  - `docs/effective-web-jwt.md`
- Added initial `web-jwt` package skeleton and unit test suite.
- Completed `work/initial/plan.md` for `web.jwt` MVP.
- Resolved initial review blockers:
  - Drift const-literal compatibility for public JWT tag constants.
  - Strict-first verify behavior for missing `typ` when `require_typ_jwt=true`.
  - Temporal-claim arithmetic hardening with bounded timestamp clamping and typed `Optional` inference fix.
- Validation:
  - `just jwt-check-par` passed (5/5 unit tests).
