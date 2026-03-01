# CORE_BUG: Arc-in-struct drop not emitted after field borrow via `.get()`

**Severity:** Medium (memory leak, not crash)
**Discovered:** 2026-02-28
**Subsystem:** Codegen / struct destructor emission / borrow-through-field liveness
**Repro file:** `packages/web-rest/tests/unit/repro_arc_struct_drop.drift`

## Summary

When a struct contains an `Arc<T>` field and that field is accessed via `.get()` (borrowing through the struct field), the compiler fails to emit the struct's destructor at end of scope. The `Arc` backing allocation is leaked — the refcount is never decremented for the borrowing owner, so `dealloc` is never called.

The leak does **not** occur when:
- The struct is dropped without accessing the Arc field
- A bare `Arc<T>` (not inside a struct) is accessed via `.get()` and dropped
- The struct's Arc field is never accessed via `.get()`

## Minimal repro

```drift
module repro

import std.core as core;
import std.concurrent as conc;
import std.sync as sync;

struct Handle {
    stopped: conc.Arc<sync.AtomicBool>,
    value: Int
}

fn new_handle() nothrow -> Handle {
    return Handle(stopped = conc.arc(sync.atomic_bool(false)), value = 0);
}

fn clone_it(h: &Handle) nothrow -> Handle {
    return Handle(stopped = h.stopped.clone(), value = h.value);
}

fn wait_on(handle: Handle) nothrow -> Int {
    val flag = handle.stopped.get();
    while !flag.load(sync.MemoryOrder::Acquire()) {
        conc.sleep(conc.Duration(millis = 10));
    }
    return 0;
}

fn main() nothrow -> Int {
    var h = new_handle();
    var caller = clone_it(&h);

    // Move one clone into a spawned VT
    var sv = conc.spawn_cb(| | captures(move h) => {
        return wait_on(move h);
    });

    // Access the Arc through the struct field — THIS PREVENTS DROP
    val flag = caller.stopped.get();
    flag.store(true, sync.MemoryOrder::Release());

    match sv.join() {
        core.Result::Err(_) => { return 1; },
        core.Result::Ok(_) => {}
    }
    // caller goes out of scope — destructor NOT emitted, Arc leaked
    return 0;
}
```

## Expected vs actual

| Scenario | `.get()` on struct field? | Valgrind | Expected |
|----------|--------------------------|----------|----------|
| Bare `Arc`, clone, spawn, `.get()`, drop | No struct | 0 leaks | 0 leaks |
| Arc-in-struct, clone, spawn, **no `.get()`**, drop | No | 0 leaks | 0 leaks |
| Arc-in-struct, clone, spawn, **`.get()` on field**, drop | **Yes** | **16 bytes leaked** | 0 leaks |

## Observations

- Exactly 16 bytes leaked per instance (the `ArcBox<AtomicBool>` allocation: refcount + value).
- The leak is deterministic and reproducible across all scenarios that access `struct_var.arc_field.get()`.
- `Arc.destroy()` itself is correct — bare `Arc` cleanup works fine.
- The bug is in the compiler's drop-emission for the **struct** containing the Arc, not in Arc itself.
- The borrow returned by `.get()` (returning `&T` from `&Arc<T>`) appears to extend the struct's liveness in a way that suppresses destructor codegen, but the actual drop call is never inserted.
- Spawn is not required to trigger — any control flow where `.get()` is called on a struct's Arc field and the struct later goes out of scope should reproduce.

## Suspected root cause

When the compiler sees `caller.stopped.get()` (a borrow through a struct field that returns `&T`), it may:

1. Extend the struct's borrow scope to cover the `&T` lifetime, then fail to insert the struct destructor after the borrow ends, or
2. Treat the struct as "still borrowed" at the point where its destructor should fire (end of scope), skipping the destroy call, or
3. Lose track of the struct's drop obligation when the borrow target (`&AtomicBool` from `.get()`) is stored in a `val` binding that outlives the struct's natural drop point.

## Workaround

None known that preserves the Arc-in-struct pattern. Possible mitigations:
- Extract the Arc from the struct into a bare `var` before calling `.get()`, then access the bare Arc directly. (Not tested — may have its own issues with struct partial move.)

## Impact on drift-web-auth

Every `_roundtrip` call in `server_test.drift` leaks 16 bytes (6 scenarios = 96 bytes total). The `ServerHandle` struct contains `Arc<AtomicBool>` and `stop()` calls `.get()` on it. The leak is small and bounded (test-only), but blocks `DRIFT_MEMCHECK=1` runs from passing cleanly.

## Run repro

```sh
DRIFT_MEMCHECK=1 just rest-check-unit packages/web-rest/tests/unit/repro_arc_struct_drop.drift
```

Expected: exit 97 (valgrind reports 16 bytes definitely lost in `scenario_cross_vt` and `scenario_clone_spawn_caller_get`).
After fix: exit 0 (0 leaks).
