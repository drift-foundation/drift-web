# Full test suite.
test:
    @just jwt-check-par

# All JWT unit tests (parallel compile, serial run).
jwt-check-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --src-root packages/web-jwt/src \
      --test-root packages/web-jwt/tests/unit \
      --target-word-bits 64

# Single JWT unit test.
jwt-check-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --test-file "{{FILE}}" \
      --target-word-bits 64

# Compile-only check (no execution).
jwt-compile-check FILE="packages/web-jwt/src/lib.drift":
    @tools/drift_test_parallel_runner.sh compile \
      --src-root packages/web-jwt/src \
      --file "{{FILE}}" \
      --target-word-bits 64

# Compile all unit tests without running.
jwt-compile-check-par:
    @tools/drift_test_parallel_runner.sh compile \
      --src-root packages/web-jwt/src \
      --test-root packages/web-jwt/tests/unit \
      --target-word-bits 64

# Show driftc version info.
driftc-help:
    @${DRIFTC} --help 2>&1 | head -5 || true
