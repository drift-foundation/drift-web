# CORE_BUG: `return void_fn(&mut ref, ...)` corrupts &mut state

**Severity:** Blocking
**Discovered:** 2026-02-26
**Subsystem:** MIR codegen / &mut reference forwarding
**Repro file:** `packages/web-rest/tests/unit/repro_array_push_struct_field.drift`

## Summary

When a `Void`-returning function that mutates a struct through a `&mut` parameter is called via `return f(ref, args)` from another `Void`-returning function, the mutation performed inside `f()` is lost or causes a runtime crash (exit 45, probable memory corruption).

The same call written as `f(ref, args); return core.void_value();` (call-then-return) works correctly.

## Minimal repro

```drift
module web.rest.tests.unit.repro_array_push_struct_field

import std.core as core;

pub struct IntBox {
    pub items: Array<Int>
}

fn _new_int_box() nothrow -> IntBox {
    var items: Array<Int> = [];
    return IntBox(items = move items);
}

fn _push_int(box: &mut IntBox, v: Int) nothrow -> Void {
    box.items.push(v);
    return core.void_value();
}

// BUG: return-forwarding pattern — mutation lost / crash.
fn _push_int_return_fwd(box: &mut IntBox, v: Int) nothrow -> Void {
    return _push_int(box, v);
}

// OK: call-then-return pattern — mutation preserved.
fn _push_int_call_then_return(box: &mut IntBox, v: Int) nothrow -> Void {
    _push_int(box, v);
    return core.void_value();
}

fn main() nothrow -> Int {
    // PASS: one-level call.
    var a = _new_int_box();
    _push_int(&mut a, 42);
    if a.items.len != 1 { return 1; }

    // PASS: two-level call-then-return.
    var b = _new_int_box();
    _push_int_call_then_return(&mut b, 42);
    if b.items.len != 1 { return 2; }

    // BUG: two-level return-forwarding — crashes (exit 45) or len==0.
    var c = _new_int_box();
    _push_int_return_fwd(&mut c, 42);
    if c.items.len != 1 { return 3; }

    return 0;
}
```

## Expected vs actual

| Pattern | Expected | Actual |
|---------|----------|--------|
| `_push_int(&mut b, 42)` | `b.items.len == 1` | PASS |
| `_push_int_call_then_return(&mut b, 42)` | `b.items.len == 1` | PASS |
| `_push_int_return_fwd(&mut b, 42)` | `b.items.len == 1` | **CRASH (exit 45)** or `len == 0` |

## Observations

- Affects `Array<Int>` and `Array<String>` (not type-specific).
- Only triggers with two-level indirection through `return fn_call(...)`.
- One-level `return` from a Void function (`return core.void_value()`) is fine.
- One-level `&mut` call (no forwarding) works correctly.
- The exact same `&mut` plumbing works when call and return are separate statements.
- Exit code 45 suggests runtime memory corruption, not a controlled error.
- ASAN build also exits 45 (no additional diagnostic output observed).

## Suspected root cause

In the `return f(&mut ref, ...)` lowering, the compiler may be generating MIR that:
1. Evaluates `f(ref, ...)` with `ref` pointing to a temporary/copy instead of the original struct, or
2. Drops/invalidates the `&mut` borrow before the callee's write-back completes, or
3. Treats `return void_fn(...)` as a tail-call optimization that bypasses write-back of the mutable reference.

The key distinction: `call; return void_value()` correctly sequences the mutation before the return, while `return call(...)` does not.

## Workaround

Replace all `return f(&mut ref, ...)` patterns in Void-returning functions with:

```drift
f(ref, args);
return core.void_value();
```

This is safe and fully equivalent at the source level, but avoids the codegen bug.

## Impact on drift-web-auth

This pattern exists in the `web.rest` package facade functions that forward `&mut` calls (e.g., `add_query_param`, `set_principal`, `add_field`). All must use the call-then-return workaround until the compiler fix lands.

## Run repro

```sh
just rest-check-unit packages/web-rest/tests/unit/repro_array_push_struct_field.drift
```

Expected: exit 45 (crash on scenario 3).
After fix: exit 0 (all 3 scenarios pass).
