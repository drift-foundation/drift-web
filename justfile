# Full test suite.
test:
    @just jwt-check-par
    @just jwt-e2e-par
    @just rest-check-par

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

# JWT e2e-style tests (no external services).
jwt-e2e-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --src-root packages/web-jwt/src \
      --test-root packages/web-jwt/tests/e2e \
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

# All REST unit tests (parallel compile, serial run).
rest-check-par:
    @tools/drift_test_parallel_runner.sh run-all \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-root packages/web-rest/tests/unit \
      --target-word-bits 64

# Single REST unit test.
rest-check-unit FILE:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file "{{FILE}}" \
      --target-word-bits 64

# REST stress tests (separate gate, not in default test target).
rest-stress:
    @tools/drift_test_parallel_runner.sh run-one \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --test-file packages/web-rest/tests/stress/stress_test.drift \
      --target-word-bits 64

# Compile-only check for REST (no execution).
rest-compile-check FILE="packages/web-rest/src/lib.drift":
    @tools/drift_test_parallel_runner.sh compile \
      --src-root packages/web-jwt/src \
      --src-root packages/web-rest/src \
      --file "{{FILE}}" \
      --target-word-bits 64

# Show driftc version info.
driftc-help:
    @${DRIFTC} --help 2>&1 | head -5 || true
