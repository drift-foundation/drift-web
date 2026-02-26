# Drift Library Project Setup Guide

Template for structuring a Drift user-land library project. Based on conventions established in `drift-mariadb-client`. New projects should follow this layout so tooling, testing, and development workflows stay consistent across the team.

## Repository root layout

```
your-project/
  AGENTS.md              # Agent/AI rules: Drift context, git policy, defect handling
  README.md              # Package overview, scope, dependencies, recipes
  TODO.md                # Project roadmap (owned by maintainer, not updated by agents)
  LICENSE
  history.md             # Chronological changelog of completed work
  justfile               # Build/test/dev recipes (primary developer entrypoint)
  packages/              # One directory per package
  tests/                 # Cross-package fixtures and shared test data
  tools/                 # Build scripts, test runners, dev utilities
  docs/                  # Effective-usage guides and design docs
  examples/              # Example programs (can start as .gitkeep)
  work/                  # Per-branch working directories
  tmp/                   # Transient local state (gitignored)
```

## Package structure

Each package under `packages/` follows the same internal layout:

```
packages/<package-name>/
  src/
    lib.drift            # Package facade: public API, exports, re-exports
    <module>.drift       # Internal modules grouped by concern
    <subdir>/            # Deeper nesting for larger subsystems
      <module>.drift
  tests/
    unit/                # Offline tests (no network, no external deps)
      <name>_test.drift
    e2e/                 # End-to-end tests (may require live services)
      <name>_test.drift
```

### Conventions

- `lib.drift` is the package facade. It defines the public API surface: types, functions, exports. Consumers import the package module (e.g., `import your.package as pkg`), which resolves to `lib.drift`.
- Internal modules are imported by `lib.drift` or by each other. They are not imported directly by consumers.
- If a package grows large enough to warrant splitting types into a separate file, use `import your.package.types as types` inside `lib.drift` rather than duplicating definitions. Never have two files defining the same types independently.

### Layered packages

When building a multi-layer library (e.g., low-level protocol + high-level client), use separate packages with explicit dependency direction:

```
packages/
  <lower-layer>/        # No dependency on higher layers
    src/lib.drift
  <higher-layer>/       # Imports lower layer
    src/lib.drift        # import <lower.layer> as lower;
```

The test runner supports multiple `--src-root` flags to compile tests that span packages:

```
tools/drift_test_parallel_runner.sh run-one \
  --src-root packages/<lower-layer>/src \
  --src-root packages/<higher-layer>/src \
  --test-file packages/<higher-layer>/tests/e2e/some_test.drift \
  --target-word-bits 64
```

## Test structure and conventions

### Test file anatomy

Every test file is a standalone executable with a `module` declaration and `fn main() nothrow -> Int`:

```drift
module your.package.tests.unit.feature_test

import std.core as core;
import your.package as pkg;

fn scenario_happy_path() nothrow -> Int {
    // ... test logic ...
    // return 0 on success, unique nonzero code on failure
    return 0;
}

fn scenario_error_case() nothrow -> Int {
    // error codes in a distinct range per scenario (100s, 200s, etc.)
    // so failures are immediately identifiable from the exit code
    return 0;
}

fn main() nothrow -> Int {
    val a = scenario_happy_path();
    if a != 0 { return a; }
    val b = scenario_error_case();
    if b != 0 { return b; }
    return 0;
}
```

### Key testing conventions

- **Unique error codes**: Each scenario uses a distinct numeric range (100s, 200s, 1000s, etc.). A nonzero exit code pinpoints the exact failure without needing a debugger.
- **Scenario functions**: Named `scenario_*` for clarity. Each is self-contained.
- **`nothrow` everywhere**: Test functions are `nothrow`. Use `match` on `Result` types to handle errors explicitly.
- **No test framework**: Tests are plain executables. The runner compiles and runs them; exit 0 = pass, nonzero = fail.
- **Unit vs e2e**: Unit tests have no external dependencies. E2e tests may need a running service (database, HTTP server, etc.).

### Test runner

The shared test runner lives at `tools/drift_test_parallel_runner.sh`. It handles:

- **`run-all`**: Discovers all `.drift` files under `--test-root` that have a `module` declaration and `fn main(`, compiles them in parallel, runs them serially.
- **`run-one`**: Compiles and runs a single `--test-file`.
- **`compile`/`compile-one`**: Compile-only (no execution). Useful for syntax/type checking.

The runner requires `DRIFTC` to be set to the compiler path. It respects `DRIFT_BUILD_JOBS` for parallelism (defaults to `nproc`).

### Sanitizer and memory checking support

The runner supports these flags at execution time:

| Flag | Effect |
|---|---|
| `DRIFT_ASAN=1` | Sets default ASAN options; incompatible with MEMCHECK/MASSIF |
| `DRIFT_MEMCHECK=1` | Runs binaries under `valgrind --tool=memcheck` |
| `DRIFT_MASSIF=1` | Runs binaries under `valgrind --tool=massif` |
| `DRIFT_ALLOC_TRACK=1` | Enables allocator tracking in the runtime |

## Justfile recipes

The justfile is the primary developer entrypoint. Structure it in layers:

### Required recipes

```just
# Full test suite: compile-first checks, then live/e2e.
test:
    @just <pkg>-check-par
    @just <pkg>-live-par

# Package unit tests (discovers all tests under tests/unit/).
<pkg>-check-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --src-root packages/<pkg>/src \
      --test-root packages/<pkg>/tests/unit \
      --target-word-bits 64

# Single targeted unit test (for development iteration).
<pkg>-check-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/<pkg>/src \
      --test-file "{{FILE}}" \
      --target-word-bits 64
```

### Design principles

- **`just test`** runs the full suite. It calls sub-recipes in order: unit/compile checks first, then live/e2e tests.
- **`-par` suffix recipes** use the parallel runner (`run-all`). These are what `just test` calls. New test files dropped into the `--test-root` directory are picked up automatically.
- **Targeted recipes** (like `<pkg>-check-unit FILE` or `<pkg>-check-<feature>`) run a single test file. These are for development iteration. They do NOT need to be wired into `just test` if the `-par` recipe already covers them via `run-all` directory scanning.
- **Multi-package tests**: Use multiple `--src-root` flags when a higher-layer package's tests need the lower layer compiled in.

### Compile-only check recipe

Useful during development to verify syntax/types without running:

```just
<pkg>-compile-check FILE="packages/<pkg>/src/lib.drift":
    @tools/drift_test_parallel_runner.sh compile \
      --src-root packages/<pkg>/src \
      --file "{{FILE}}" \
      --target-word-bits 64
```

## Documentation

### docs/ directory

Each package gets an effective-usage guide:

```
docs/effective-<package-name>.md
```

These are living documents aimed at application developers consuming the package. They should cover:

- Core principles and API philosophy
- Primary usage patterns (with pseudocode or real examples)
- Error model: error types, error tag catalog, naming convention
- Anti-patterns to avoid
- Operational guidance (timeouts, retries, resource management)

### Error tag convention

All error tags follow a consistent pattern across the project:

```
<pkg>-{category}-{detail}
```

Categories typically include:
- `<pkg>-config-*` for configuration validation errors
- `<pkg>-invalid-*` for input validation errors
- `<pkg>-<subsystem>-*` for subsystem-specific errors (transport, I/O, etc.)

Document the full error tag catalog in the effective-usage guide with tables showing tag, source function, and when it occurs.

## Root-level files

### AGENTS.md

Rules for AI agents working on the codebase. Should include:

- **Drift context**: ownership/move semantics, borrowing rules, runtime model
- **Git policy**: agents should not stage/commit/mutate without permission
- **Defect policy**: regression-first, no semantic masking, stop-and-confirm on suspected core bugs
- **Links to Drift language docs** (spec, stdlib, concurrency, effective guide)

### TODO.md

Project roadmap owned by the maintainer. Organized by phase. Agents do not update this file.

### history.md

Chronological changelog of completed work. Organized by date, then by category (tooling, tests, implementation, validation). Written after work is merged, not during.

### README.md

Standard project readme covering:

- What the project is and its scope
- Package listing with one-line descriptions
- Links to effective-usage guides
- Dependencies (bash, just, docker, driftc)
- Compiler environment setup (`DRIFTC`)
- Build flags reference
- Recipe overview

## Branch workflow

### work/ directories

Each feature branch gets a working directory:

```
work/<branch-name>/
  todo.md       # Owned by user: task list, open questions
  plan.md       # Implementation plan (written before coding starts)
  progress.md   # Owned by agent: decisions, status, work log
```

- `todo.md` is maintained by the user. Agents read it but do not modify it.
- `progress.md` is maintained by the agent. Updated with decisions, status changes, and work log entries as work proceeds.
- `plan.md` documents the agreed implementation plan before coding starts.

These directories are committed to the branch and serve as a record of how decisions were made.

## Fixtures and test data

For projects that need captured/recorded test data:

```
tests/
  fixtures/
    <schema_or_setup>.sql          # Schema/setup scripts for test services
    packetized/                    # Processed fixtures for deterministic replay
      <scenario>/<run-id>/
        manifest.json
        *.bin                      # Binary data files
        scenario.sql               # Human-readable transcript
```

### Fixture workflow (when applicable)

1. **Capture**: Record real interactions with a live service (e.g., TCP proxy capture).
2. **Extract**: Process raw captures into structured, packetized fixtures.
3. **Replay**: Unit tests replay fixtures deterministically without needing the live service.

This capture-extract-replay pipeline gives you both live e2e confidence and fast offline unit test coverage.

## Getting started checklist for a new project

1. Create the repository with the root layout shown above.
2. Copy `tools/drift_test_parallel_runner.sh` from an existing project (it is project-agnostic).
3. Create `AGENTS.md` with Drift context and policies.
4. Create `packages/<your-package>/src/lib.drift` with initial module declaration.
5. Create `packages/<your-package>/tests/unit/` and write your first `_test.drift`.
6. Set up the justfile with `test`, `<pkg>-check-par`, and `<pkg>-check-unit` recipes.
7. Verify: `DRIFTC=/path/to/driftc just test` should compile and run your first test.
8. Create `docs/effective-<your-package>.md` as a stub.
9. Write `README.md` and `TODO.md`.
10. Start developing.

## Drift toolchain dependency

All projects track `drift-foundation/lang-toolchain` `main`. Compatibility target is current `main`, not historical snapshots. If a `main` change breaks the project, treat it as immediate integration work.
