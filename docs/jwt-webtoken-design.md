# JWT Web Token Design (Drift)

## Status
Draft v0.2 (design-in-progress).

Pinned decisions:
- strict-first policy (`require_typ_jwt` default is `true`)
- no `verify_hs256_default(...)` helper in MVP

## Purpose
Define a sound, safe, and stable JWT API for Drift user-space libraries.
This package is intended to be imported by web/auth middleware and application code.

MVP scope:
- JWS compact serialization
- `HS256` only
- Sign + verify
- Minimal temporal claim validation (`exp`, `nbf`, `iat`) with configurable skew

Out of scope (MVP):
- `alg=none`
- RSA/ECDSA/EdDSA
- JWK/JWKS
- JWE/nested JWT

## Design Principles
1. Secure-by-default: default path should reject unsafe inputs.
2. Misuse resistance: API shape should make common mistakes difficult.
3. Deterministic behavior: strict decoding and stable error tags.
4. Low coupling: package should not depend on web framework details.
5. Backward compatibility: additive evolution with stable core contracts.

## Ecosystem Alignment Targets (from mariadb-client style)
1. Public `lib.drift` exports define a compact, stable API facade.
2. Separate config-validation errors from runtime verification errors.
3. Provide builder + `build_*` validation pattern for policy/config objects.
4. Keep stable string error tags with `jwt-{category}-{detail}` naming.
5. Keep tests as standalone `scenario_*` functions with unique exit-code ranges.
6. Maintain an effective-usage guide (`docs/effective-web-jwt.md`) as a living contract for consumers and implementers.

## Package and Modules
Suggested package root: `packages/web-jwt/src/lib.drift`

Internal module split:
- `signing.drift`: HS256 signing
- `verify.drift`: token parsing + signature validation
- `claims.drift`: `exp`/`nbf`/`iat` validation
- `errors.drift`: error tags/types
- `model.drift`: public structs/options

## Public API (Proposed)

```drift
module web.jwt

struct SignOptions {
    // If true, ensure header contains typ=JWT.
    enforce_typ_jwt: Bool,
}

struct JwtVerifyPolicy {
    // Allowed clock skew in seconds. Must be >= 0.
    skew_sec: Int,
    // Maximum allowed future iat offset in seconds.
    // Example: 300 allows iat up to 5 minutes ahead of now.
    max_future_iat_sec: Int,
    // If true, require typ=="JWT" when typ exists.
    require_typ_jwt: Bool,
}

struct JwtVerifyPolicyBuilder {
    skew_sec: Int,
    max_future_iat_sec: Int,
    require_typ_jwt: Bool,
}

struct JwtConfigError {
    tag: String,
    field: String,
    message: String,
}

struct JwtError {
    tag: String,
    message: String,
}

struct VerifiedJwt {
    header_json: String,
    payload_json: String,
}

fn new_sign_options() -> SignOptions
fn new_verify_policy_builder() -> JwtVerifyPolicyBuilder
fn build_verify_policy(builder: JwtVerifyPolicyBuilder) -> Result<JwtVerifyPolicy, JwtConfigError>

fn sign_hs256(
    header_json: &String,
    payload_json: &String,
    secret: &Array<Byte>,
    opts: &SignOptions
) -> Result<String, JwtError>

fn verify_hs256(
    token: &String,
    secret: &Array<Byte>,
    now_unix: Int,
    policy: &JwtVerifyPolicy
) -> Result<VerifiedJwt, JwtError>
```

Notes:
- Keep MVP API string-based for header/payload to avoid forcing a JSON AST dependency.
- Verify returns original decoded JSON strings for framework-level claim handling.
- `now_unix` is caller-provided for deterministic tests.
- Keep top-level free functions first; method sugar can be added later if needed.
- Do not add `verify_hs256_default(...)` in MVP.

Recommended builder defaults:
- `skew_sec = 0`
- `max_future_iat_sec = 0`
- `require_typ_jwt = true`

## Canonical Verification Contract
`verify_hs256` must:
1. Split token into exactly 3 segments.
2. Strict-decode header and payload via base64url (no padding, canonical form).
3. Parse header JSON and require `alg == "HS256"`.
4. Recompute signature over exact original signing input:
   - `segment0 + "." + segment1`
5. Compare expected vs actual signature using constant-time equality.
6. Parse payload JSON only as needed for temporal claim checks.
7. Validate `exp`/`nbf`/`iat` semantics with `JwtVerifyPolicy`.

Never:
- Reserialize parsed JSON before signature verification.
- Fallback to other algorithms.
- Accept missing or unknown `alg`.

## Claims Policy (MVP)

If claim is absent: no failure for that claim.

If claim is present:
- `exp` must be numeric unix seconds.
  - Reject if `now_unix > exp + skew_sec`.
- `nbf` must be numeric unix seconds.
  - Reject if `now_unix + skew_sec < nbf`.
- `iat` must be numeric unix seconds.
  - Reject if `iat > now_unix + max_future_iat_sec`.

Validation constraints:
- `skew_sec >= 0`
- `max_future_iat_sec >= 0`
- invalid policy options should return explicit config error tags.

## Time Source Requirement

JWT verification requires unix seconds sourced from `std.time`.

Standard source (now available):
- `utc_unix_seconds_now() -> Int`
- `utc_unix_seconds(ts: &UtcTimestamp) -> Int`
- `utc_unix_millis(ts: &UtcTimestamp) -> Int` (non-JWT helper)

Semantics:
- UTC epoch values
- signed `Int`
- deterministic truncation toward zero for seconds conversion from milliseconds

## Error Model (Stable Tags)
Public errors should expose stable tags for callers and logs.

Recommended tag set:
- `jwt-invalid-format`
- `jwt-invalid-segment`
- `jwt-invalid-header-json`
- `jwt-invalid-payload-json`
- `jwt-unsupported-alg`
- `jwt-signature-mismatch`
- `jwt-claim-invalid-type`
- `jwt-expired`
- `jwt-not-before`
- `jwt-issued-at-future`
- `jwt-config-invalid`

Recommended split:
- `JwtConfigError` tags:
  - `jwt-config-invalid`
  - `jwt-config-missing-required` (if future required fields are added)
- `JwtError` tags:
  - all runtime verify/sign failures (`jwt-invalid-*`, `jwt-claim-*`, `jwt-signature-mismatch`, etc.)

Error design guidance:
- Include segment index or claim key where safe and useful.
- Do not include secrets or full token values in error messages.
- Keep tag meanings stable across versions.

## Security Requirements (Non-Negotiable)
1. Allowlist only `HS256` in MVP.
2. Constant-time signature comparison.
3. Strict/canonical base64url decode.
4. Signature input uses original token segments.
5. No implicit algorithm selection.
6. No SHA-1 fallback behavior.
7. Reject malformed token structure early.

## Interop and Consumer Guidance
- Library is policy-light for non-temporal claims (`iss`, `aud`, `sub`) in MVP.
- Frameworks should enforce app-specific claim policies above this layer.
- Keep one central auth config module in app code to avoid policy drift.

## Versioning and Compatibility
- Treat error tags and core verify semantics as compatibility surface.
- Future algorithms should be added via new explicit API/types, not silent behavior changes.
- Backward-compatible additions:
  - new optional fields in options structs
  - additive helper APIs

Compatibility guarantees to pin:
- `sign_hs256`/`verify_hs256` call signatures
- `JwtVerifyPolicy` field semantics
- `JwtConfigError` + `JwtError` tag meanings

## Test Contract (Must Pass Before Release)

Functional:
- sign/verify happy path
- wrong secret rejected
- tampered payload/header rejected
- malformed segment count rejected
- unsupported/missing alg rejected

Claims:
- expired
- not-before violation
- future iat violation
- skew boundary checks
- non-numeric claim types rejected

Strictness:
- padding rejected
- non-canonical base64url rejected
- `+` and `/` chars rejected

Security behavior:
- verify uses original segments (no JSON reserialization)
- constant-time compare path covered

Tooling:
- normal run
- ASAN
- memcheck

Test shape requirements (ecosystem consistency):
- each test file has `scenario_*` functions and a `main()` dispatcher
- each scenario uses unique exit-code ranges (100s, 200s, ...)
- tests assert exact stable error tags for negative cases

## Open Design Questions (For Finalization)
1. Should `JwtError` include optional detail fields (`claim`, `segment_index`) now, or keep only `tag/message`?
2. Should we expose claim helper functions in MVP, or defer to consumer/framework layer?

## Proposed Next Step
Freeze v0 API signatures, policy builder behavior, and error tags first, then let implementation proceed against this document.
