#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
ADDRESS="${ADDRESS:-:1443}"
ALLOW_DNS="${ALLOW_DNS:-}"
ALLOW_EMAIL="${ALLOW_EMAIL:-}"
CA_JSON="${CA_JSON:-/home/step-ca/.step/config/ca.json}"
COMMON_NAME="${COMMON_NAME:-}"
CRT="${CRT:-/home/step-ca/.step/certs/intermediate_ca.crt}"
DATA_SOURCE="${DATA_SOURCE:-/home/step-ca/.step/db}"
DNS_NAMES="${DNS_NAMES:-}"
KEY="${KEY:-/home/step-ca/.step/secrets/intermediate_ca_key}"
PASSWORD_TXT="${PASSWORD_TXT:-/home/step-ca/.step/password.txt}"
ROOT="${ROOT:-/home/step-ca/.step/certs/root_ca.crt}"

# Implement sponge-like command without the need for binary nor TMPDIR environment variable
write_file() {
    # Create temporary file
    # shellcheck disable=SC2155
    local tmp_file="${1}_$(tr </dev/urandom -dc A-Za-z0-9 | head -c16)"

    # Redirect the output to the temporary file
    cat >"${tmp_file}"

    # Replace the original file
    mv --force "${tmp_file}" "${1}"
}

verify_files() {
    echo "* Verifying configuration files..."

    for file in ${CA_JSON} ${PASSWORD_TXT}; do
        if [ ! -e "${file}" ]; then
            echo "Error: Unable to locate file: ${file}"
            sleep 60
            exit 1
        fi
    done
}

verify_variables() {
    echo "* Verifying configuration variables..."

    for variable in ALLOW_DNS ALLOW_EMAIL COMMON_NAME DNS_NAMES; do
        if [ -z "${!variable}" ]; then
            echo "Error: Variable is undefined: ${variable}"
            sleep 60
            exit 1
        fi
    done
}

format_ca_json() {
    jq . "${CA_JSON}" | write_file "${CA_JSON}"
}

config_ca_json() {
    # .address
    if [ -n "${ADDRESS}" ]; then
        jq ".address = \"${ADDRESS}\"" "${CA_JSON}" | write_file "${CA_JSON}"
    fi

    # .commonName
    if [ -n "${COMMON_NAME}" ]; then
        jq ".commonName = \"${COMMON_NAME}\"" "${CA_JSON}" | write_file "${CA_JSON}"
    fi

    # .dnsNames
    if [ -n "${DNS_NAMES}" ]; then
        jq ". + { \"dnsNames\": [\"${DNS_NAMES}\"] }" "${CA_JSON}" | write_file "${CA_JSON}"
    fi

    # .crt
    if [ -n "${CRT}" ]; then
        jq ".crt = \"${CRT}\"" "${CA_JSON}" | write_file "${CA_JSON}"
    fi

    # .db.dataSource
    if [ -n "${DATA_SOURCE}" ]; then
        jq ".db.dataSource = \"${DATA_SOURCE}\"" "${CA_JSON}" | write_file "${CA_JSON}"
    fi

    # .root
    if [ -n "${ROOT}" ]; then
        jq ".root = \"${ROOT}\"" "${CA_JSON}" | write_file "${CA_JSON}"
    fi

    # .authority.claims
    jq ".authority.claims = {
      \"minTLSCertDuration\": \"5m\",
      \"maxTLSCertDuration\": \"720h\",
      \"defaultTLSCertDuration\": \"720h\",
      \"disableRenewal\": false,
      \"allowRenewalAfterExpiry\": false,
      \"minHostSSHCertDuration\": \"5m\",
      \"maxHostSSHCertDuration\": \"48h\",
      \"defaultHostSSHCertDuration\": \"12h\",
      \"minUserSSHCertDuration\": \"5m\",
      \"maxUserSSHCertDuration\": \"48h\",
      \"defaultUserSSHCertDuration\": \"12h\"
    }" "${CA_JSON}" | write_file "${CA_JSON}"

    # .authority.policy.ssh.host.allow.dns
    # .authority.policy.ssh.user.allow.email
    # .authority.policy.x509.allow.dns
    jq ".authority.policy = {
      \"x509\": {
        \"allow\": {
          \"dns\": [
            \"${ALLOW_DNS}\"
          ]
        },
        \"allowWildcardNames\": false
      },
      \"ssh\": {
        \"user\": {
          \"allow\": {
            \"email\": [
              \"${ALLOW_EMAIL}\"
            ]
          }
        },
        \"host\": {
          \"allow\": {
            \"dns\": [
              \"${ALLOW_DNS}\"
            ]
          }
        }
      }
    }" "${CA_JSON}" | write_file "${CA_JSON}"

    # .authority.provisioners
    jq '.authority.provisioners |= map(
      if .type == "ACME"
      then .claims = {}
      else .
      end
    )' "${CA_JSON}" | write_file "${CA_JSON}"
}

assemble_command() {
    cmd=(exec)
    cmd+=(step-ca)
    cmd+=(${CA_JSON})
    cmd+=(--password-file)
    cmd+=(${PASSWORD_TXT})
}

# Establish run order
main() {
    verify_files
    verify_variables
    format_ca_json
    config_ca_json
    assemble_command
    "${cmd[@]}"
}

main
