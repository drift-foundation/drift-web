#!/usr/bin/env bash
set -euo pipefail

FIXTURE_DIR="$(cd "$(dirname "$0")/../tests/fixtures" && pwd)"
mkdir -p "${FIXTURE_DIR}"

# CA key + cert
openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 \
  -keyout "${FIXTURE_DIR}/ca.key" -out "${FIXTURE_DIR}/ca.crt" \
  -days 3650 -nodes -subj "/CN=Test CA" 2>/dev/null

# Server key + CSR + cert (signed by CA, SANs: localhost + 127.0.0.1)
openssl req -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 \
  -keyout "${FIXTURE_DIR}/server.key" -out "${FIXTURE_DIR}/server.csr" \
  -nodes -subj "/CN=localhost" 2>/dev/null

openssl x509 -req -in "${FIXTURE_DIR}/server.csr" \
  -CA "${FIXTURE_DIR}/ca.crt" -CAkey "${FIXTURE_DIR}/ca.key" \
  -CAcreateserial -out "${FIXTURE_DIR}/server.crt" -days 3650 \
  -extfile <(printf "subjectAltName=DNS:localhost,IP:127.0.0.1") 2>/dev/null

# Wrong-host cert (SANs: wrong.example.com only)
openssl req -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 \
  -keyout "${FIXTURE_DIR}/wrong-host.key" -out "${FIXTURE_DIR}/wrong-host.csr" \
  -nodes -subj "/CN=wrong.example.com" 2>/dev/null

openssl x509 -req -in "${FIXTURE_DIR}/wrong-host.csr" \
  -CA "${FIXTURE_DIR}/ca.crt" -CAkey "${FIXTURE_DIR}/ca.key" \
  -CAcreateserial -out "${FIXTURE_DIR}/wrong-host.crt" -days 3650 \
  -extfile <(printf "subjectAltName=DNS:wrong.example.com") 2>/dev/null

# Clean up CSRs
rm -f "${FIXTURE_DIR}"/*.csr "${FIXTURE_DIR}"/*.srl

echo "test certs generated in ${FIXTURE_DIR}"
