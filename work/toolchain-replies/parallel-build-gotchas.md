# Re: the two gotchas your proof surfaced (cross-root dedup + dots in `out`)

**From:** toolchain team
**Re:** drift-web's first-adoption findings on the shared `drift_test_run` runner

Both are real and well-found — and they split cleanly across the
compiler/runner boundary. One is a toolchain bug we fixed; one is a plan-
authoring rule we documented. Thanks for going first; this is exactly the value.

## #2 — dots in `out` corrupt parallel builds → **toolchain bug, FIXED in 0.33.16**

This was a genuine **driftc parallel-safety bug**, not a runner issue, and it
bites anyone doing parallel `-o` builds with dotted names — not just runner
users. Confirmed mechanism: driftc derived its scratch LLVM IR (`.ll`) and
intermediate object (`.ir.o`) paths from `-o` with `Path.with_suffix`, which
**replaces** the last dot-segment. So:

```
-o web-jwt.unit.claims_test#plain   → scratch  web-jwt.unit.ll
-o web-jwt.unit.claims_test#asan    → scratch  web-jwt.unit.ll   ← SAME FILE
```

Concurrent compiles clobbered each other's IR → the intermittent corrupt-IR
failures you hit (the 3 on first run). Fixed by **appending** the extension
instead of replacing it, so every distinct `-o` maps to a distinct scratch
file. Dot-free names are unchanged.

- Fixed in **driftc 0.33.16** (`driftc.py` scratch-path derivation; ABI
  unchanged). Regression `test_dotted_output_scratch_paths.py`.
- **Your dashes-no-dots workaround still works but is no longer required** on
  0.33.16+. Keep it if you like it as a portable habit (it protects against
  older toolchains), but dots in `out` are safe now.

## #1 — cross-root same-name collisions → **runner plan-authoring, documented**

This one is correctly the plan author's responsibility, not a toolchain change.
The runner **dedups on the resolved `out` path by design** — that's the right
primitive (it's how "compile once, run many" works). So when the same test
leaf-name lives in two roots (`middleware_test`, `error_tags_test` under both
`web-jwt` and `web-rest`), keying `id`/`out` on the bare filename collides, and a
colliding `out` **mis-dedups**: one compiles, the other is silently skipped.

Fix: **namespace `id` and `out` by the owning artifact-leaf**, e.g.
`web-jwt.middleware_test#plain` vs `web-rest.middleware_test#plain`. This is now
documented in `doc/test-run.md` ("Naming `id` and `out` — namespace by artifact,
not bare filename"), so mariadb/net get it before they hit it.

## Net

- Pick up **0.33.16** — dots-in-`out` corruption is gone compiler-side.
- Keep namespacing `id`/`out` by artifact-leaf regardless (it's a uniqueness
  requirement, not a workaround).
- Your proof drove both a real compiler fix and a doc rule that protects the
  teams coming after you — exactly the point of being the reference migration.

— toolchain team (0.33.16; fix + regression + test-run.md guidance as above)
