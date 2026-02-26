# Effective web-jwt Usage

Audience: application developers and implementers of `web-jwt`.

Status: API draft intended to guide MVP implementation.

Pinned decisions:
- strict-first policy (`require_typ_jwt` defaults to `true`)
- no `verify_hs256_default(...)` convenience wrapper in MVP

## Module and package

- Package path: `packages/web-jwt/src/lib.drift`
- Public module name: `web.jwt`
- Consumer import:

```drift
import web.jwt as jwt;
```

## MVP scope

- JWS compact JWT only (`header.payload.signature`)
- `HS256` only
- Sign and verify
- Temporal claims validation for `exp`, `nbf`, `iat`

Out of scope in MVP:
- `alg=none`
- RSA/ECDSA/EdDSA
- JWK/JWKS and JWE

## Pinned public API (for implementation)

```drift
module web.jwt

pub struct SignOptions {
	pub enforce_typ_jwt: Bool
}

pub struct JwtVerifyPolicy {
	pub skew_sec: Int,
	pub max_future_iat_sec: Int,
	pub require_typ_jwt: Bool
}

pub struct JwtVerifyPolicyBuilder {
	pub skew_sec: Int,
	pub max_future_iat_sec: Int,
	pub require_typ_jwt: Bool
}

pub struct JwtConfigError {
	pub tag: String,
	pub field: String,
	pub message: String
}

pub struct JwtError {
	pub tag: String,
	pub message: String
}

pub struct VerifiedJwt {
	pub header_json: String,
	pub payload_json: String
}

pub fn new_sign_options() nothrow -> SignOptions
pub fn new_verify_policy_builder() nothrow -> JwtVerifyPolicyBuilder
pub fn build_verify_policy(builder: JwtVerifyPolicyBuilder) nothrow -> core.Result<JwtVerifyPolicy, JwtConfigError>

pub fn sign_hs256(
	header_json: &String,
	payload_json: &String,
	secret: &Array<Byte>,
	opts: &SignOptions
) nothrow -> core.Result<String, JwtError>

pub fn verify_hs256(
	token: &String,
	secret: &Array<Byte>,
	now_unix: Int,
	policy: &JwtVerifyPolicy
) nothrow -> core.Result<VerifiedJwt, JwtError>
```

MVP intentionally does **not** include `verify_hs256_default(...)` to avoid hidden policy behavior.

## Quick start

### 1) Sign a token

```drift
import std.core as core;
import web.jwt as jwt;

fn sign_example() nothrow -> core.Result<String, jwt.JwtError> {
	val header = "{\"alg\":\"HS256\",\"typ\":\"JWT\"}";
	val payload = "{\"sub\":\"u123\",\"iat\":1730000000,\"exp\":1730003600}";
	var secret: Array<Byte> = [];
	secret.push(cast<Byte>(115)); // s
	secret.push(cast<Byte>(51));  // 3
	secret.push(cast<Byte>(99));  // c
	secret.push(cast<Byte>(114)); // r
	secret.push(cast<Byte>(51));  // 3
	secret.push(cast<Byte>(116)); // t

	var opts = jwt.new_sign_options();
	opts.enforce_typ_jwt = true;
	return jwt.sign_hs256(&header, &payload, &secret, &opts);
}
```

### 2) Verify a token

```drift
import std.core as core;
import std.time as time;
import web.jwt as jwt;

fn verify_example(token: &String, secret: &Array<Byte>) nothrow -> Int {
	var pb = jwt.new_verify_policy_builder();
	pb.skew_sec = 30;
	pb.max_future_iat_sec = 300;
	pb.require_typ_jwt = true;

	val policy = match jwt.build_verify_policy(move pb) {
		core.Result::Ok(v) => { v },
		core.Result::Err(_) => { return 11; }
	};

	val now_unix = time.utc_unix_seconds_now();
	match jwt.verify_hs256(token, secret, now_unix, &policy) {
		core.Result::Ok(v) => {
			// Verified signature + validated temporal claims.
			val _header = v.header_json;
			val _payload = v.payload_json;
			return 0;
		},
		core.Result::Err(e) => {
			if e.tag == "jwt-expired" { return 21; }
			if e.tag == "jwt-signature-mismatch" { return 22; }
			return 23;
		}
	}
}
```

## Verification behavior contract

`verify_hs256` must:
1. Require exactly 3 token segments.
2. Strict-decode each segment using base64url rules from `std.codec.base64url_decode`.
3. Require header `alg` claim and require it equals `"HS256"`.
4. Recompute signature over original signing input: `segment0 + "." + segment1`.
5. Use `std.crypto.constant_time_eq` for signature comparison.
6. Validate temporal claims (`exp`, `nbf`, `iat`) if present.
7. Return decoded `header_json` and `payload_json` on success.

## Temporal claim rules (MVP)

- `exp` present:
  - must be numeric unix seconds
  - reject when `now_unix > exp + skew_sec`
- `nbf` present:
  - must be numeric unix seconds
  - reject when `now_unix + skew_sec < nbf`
- `iat` present:
  - must be numeric unix seconds
  - reject when `iat > now_unix + max_future_iat_sec`

Policy validation:
- `skew_sec >= 0`
- `max_future_iat_sec >= 0`

## Time source contract

- `verify_hs256` accepts `now_unix` (unix seconds) from the caller.
- Production callers should source this from `std.time`, using:
  - `std.time.utc_unix_seconds_now()`
  - or `std.time.utc_unix_seconds(&ts)` after `ts = std.time.now_utc()`
- `std.time.utc_unix_millis(&ts)` is available when millisecond precision is needed elsewhere.

## Error tags

Config/build-time (`JwtConfigError`):
- `jwt-config-invalid`
- `jwt-config-missing-required` (reserved for future required fields)

Runtime (`JwtError`) recommended tags:
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

Guidance:
- tags are stable API surface
- messages are human-readable but not stability-critical
- never include secrets in errors

## Security invariants (must not regress)

1. Only `HS256` accepted in MVP.
2. No fallback algorithms.
3. No JSON reserialization before verify.
4. Constant-time signature compare.
5. Strict base64url handling (reject padding and non-canonical forms).

## Recommended consumer pattern

1. Build verify policy once at service startup.
2. For each request, call `verify_hs256(token, secret, now_unix, &policy)`.
3. Map `JwtError.tag` to auth response categories.
4. Parse app-specific claims (`iss`, `aud`, `sub`, custom) in framework layer.

## Implementation notes for Klaudia

- Keep `lib.drift` as a stable facade with explicit exports.
- Keep helper modules internal (`claims`, `signing`, `verify`, `errors`).
- Add unit tests that assert exact tag values for negative paths.
- Add e2e tests for tampering, malformed segments, and claim boundary conditions.
