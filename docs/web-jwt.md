# web-jwt handoff plan (user-space library)

## Purpose
Build a minimal, secure JWT user-space library on top of existing stdlib primitives.
This is a handoff document for the JWT team (similar operating model as mariadb-client):
- JWT team owns user-space library implementation and tests.
- Compiler/toolchain team owns language/runtime defects discovered during implementation.

## Ownership split
- JWT team (this project):
  - package design and implementation
  - claims policy and API ergonomics
  - integration tests
- Toolchain team (drift-lang):
  - parser/checker/lowering/codegen/runtime defects (LANGUAGE_BUG)
  - stdlib primitive defects

## Current stdlib support available
- `std.crypto`:
  - `sha256(data: &Array<Byte>) -> Array<Byte>`
  - `hmac_sha256(key: &Array<Byte>, msg: &Array<Byte>) -> Array<Byte>`
  - `constant_time_eq(a: &Array<Byte>, b: &Array<Byte>) -> Bool`
- `std.codec`:
  - `base64url_encode(bytes: &Array<Byte>) -> String`
  - `base64url_decode(s: &String) -> Result<Array<Byte>, CodecError>`
  - strict decode with canonical checks and deterministic offsets

## Scope for JWT MVP
Implement only:
- JWS compact with `HS256`.
- `sign` and `verify` flows.
- Minimal claims validation (`exp`, `nbf`, `iat`) with configurable clock-skew.

Out of scope for MVP:
- `alg=none`
- RSA/ECDSA/EdDSA
- JWK/JWKS
- nested JWT/JWE
- permissive decoders

## Security constraints (mandatory)
1. Accept only explicit allowlisted `alg` (MVP: `HS256` only).
2. Reject missing/unknown/mismatched `alg`.
3. Use constant-time compare for signature checks.
4. Verify signature over original token segments:
   - `base64url(header) + "." + base64url(payload)`
   - never reserialize parsed JSON before verify.
5. Strict base64url decode only.
6. Enforce claim types (`exp/nbf/iat` numeric) and time semantics.
7. No fallback to SHA-1 for signing/verification.

## Proposed package/API shape
Package suggestion: `packages/web-jwt`

Candidate API:
- `fn sign_hs256(header_json: &String, payload_json: &String, secret: &Array<Byte>) -> Result<String, JwtError>`
- `fn verify_hs256(token: &String, secret: &Array<Byte>, now_unix: Int, skew_sec: Int) -> Result<VerifiedJwt, JwtError>`
- `struct VerifiedJwt { header_json: String, payload_json: String }`

Optional convenience layer (separate functions):
- typed claims extraction/validation wrappers
- helper for default header construction

## Parsing/validation rules
1. Token must have exactly 3 segments.
2. Segment decode uses strict `base64url_decode`.
3. Header/payload JSON parse must be strict enough for deterministic field lookup.
4. Header checks:
   - `alg` required and equals `HS256`
   - reject if mismatch or unsupported value
5. Claims checks (if present):
   - `exp`: reject if `now > exp + skew`
   - `nbf`: reject if `now + skew < nbf`
   - `iat`: reject if unreasonably in future by policy

## Test matrix required
### Functional
- sign/verify happy path
- wrong secret rejected
- modified payload rejected
- modified header rejected
- malformed segment count rejected
- malformed base64url rejected
- unsupported `alg` rejected

### Claims
- expired token
- not-yet-valid token
- skew boundary behavior
- non-numeric claim type rejected

### Canonical/strictness
- padding-containing tokens rejected
- non-canonical base64url tails rejected
- `+` and `/` chars rejected

### Security behavior
- verify uses original token segments (no reserialization)
- constant-time compare path exercised in verify

### Tooling modes
- normal
- ASAN
- memcheck

## Error model recommendation
Define stable, explicit tags (example set):
- `jwt-invalid-format`
- `jwt-invalid-segment`
- `jwt-invalid-header-json`
- `jwt-invalid-payload-json`
- `jwt-unsupported-alg`
- `jwt-signature-mismatch`
- `jwt-claim-invalid-type`
- `jwt-expired`
- `jwt-not-before`

Keep offsets/details when available from codec errors.

## Integration guidance for REST stack
- JWT package should be dependency of web/REST framework, not vice versa.
- Framework auth middleware should consume `verify_hs256(...)` and map errors to auth responses.
- Keep signing/verification policy centralized in one config module.

## LANGUAGE_BUG escalation protocol (for JWT team)
If implementation hits suspected compiler/runtime defect:
1. Stop workaround-driven refactors.
2. Add minimal repro test (prefer e2e).
3. Confirm failure on current compiler.
4. Report with:
   - minimal repro source
   - command used
   - actual vs expected
   - suspected subsystem
5. Wait for toolchain fix or explicit temporary-workaround approval.

## Suggested delivery phases
1. Package skeleton + error model.
2. HS256 sign implementation.
3. HS256 verify implementation.
4. Claims validation and policy knobs.
5. E2E/security matrix and docs.

