# CORE_BUG: `if` rejects Bool value bound from mut-var struct field

**Severity:** Low (workaround trivial: `== true`)
**Discovered:** 2026-03-02
**Status:** OPEN
**Subsystem:** Type checker / if-condition validation
**Repro file:** `packages/web-rest/tests/unit/repro_if_bool_field.drift`

## Summary

When a `Bool` value is read from a struct field on a mutable variable
(moved-into), the compiler rejects it as an `if` condition with
`"if condition must be Bool"` — even though the value IS Bool.

The same Bool value wrapped in `== true` compiles fine.

## Trigger conditions

The defect requires ALL of:
1. A struct with a `pub` Bool field
2. The struct instance held in a `var` (mutable variable, typically via `move`)
3. The field value used directly in an `if` condition — either via
   `val f = p.flag; if f { ... }` or `if p.flag { ... }`

## What works vs what fails

| Pattern | Compiles? |
|---------|-----------|
| `if param_bool { ... }` (function parameter) | Yes |
| `if ref.field { ... }` (ref to struct) | Yes |
| `var p = move parsed; if p.flag == true { ... }` | Yes |
| `var p = move parsed; if p.flag { ... }` | **No** |
| `var p = move parsed; val f = p.flag; if f { ... }` | **No** |
| `var p = move parsed; val f = p.flag == true; if f == true { ... }` | Yes |

## Minimal repro

```drift
module repro

import std.core as core;

pub struct Parsed {
    pub value: Int,
    pub flag: Bool
}

fn _test(parsed: Parsed) nothrow -> Int {
    var p = move parsed;
    val f = p.flag;
    if f {         // ERROR: if condition must be Bool
        return 1;
    }
    return 0;
}

fn main() nothrow -> Int {
    val p = Parsed(value = 42, flag = true);
    return _test(move p);
}
```

## Expected

Compiles and returns 1. `f` is typed `Bool`, which satisfies the
`if` condition requirement.

## Actual

```
<source>:13:5: error: if condition must be Bool
```

## Workaround

Use explicit `== true` comparison:

```drift
val f = p.flag == true;
if f == true { ... }
```

Or bind through a ref instead:

```drift
fn _test(p: &Parsed) nothrow -> Int {
    if p.flag { ... }  // works with ref
}
```

## Suspected root cause

The type checker likely infers a different type for field projections
on mutable variables vs references. The `p.flag` expression on a `var`
may resolve to a type other than `Bool` in the type checker's internal
representation — perhaps a "place" type that hasn't been resolved to
its underlying `Bool`. The `== true` comparison forces the operand
through a different code path that correctly resolves to `Bool`.

## Impact on drift-web-auth

Two instances in `server.drift` use `== true` workaround:
- `val conn_close = p.conn_close == true;` (line 99)
- `if conn_close == true { ... }` (line 125)

Functionally correct. The workaround is trivial and has no runtime cost.

## Run repro

```sh
just rest-check-unit packages/web-rest/tests/unit/repro_if_bool_field.drift
```

To see the failure, uncomment `_test_val_from_mut()` and its call in `main()`.
