#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

APPEND_ONLY="${APPEND_ONLY:-true}"
AUTH="${AUTH:-}"
BCRYPT_WORK_FACTOR="${BCRYPT_WORK_FACTOR:-13}"
DATA="${DATA:-/var/local/rest-server/data}"
LISTEN="${LISTEN:-:8000}"
PASSWORD_FILE="${PASSWORD_FILE:-/var/local/rest-server/config/htpasswd}"
PRIVATE_REPOS="${PRIVATE_REPOS:-true}"
PROMETHEUS="${PROMETHEUS:-true}"

assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/rest-server)

    # APPEND_ONLY
    if [ "${APPEND_ONLY,,}" = "true" ]; then
        cmd+=(--append-only)
    fi

    # AUTH
    if [ -n "${PASSWORD_FILE}" ]; then
        install /dev/null --owner=rest-server --group=rest-server --mode=0600 "${PASSWORD_FILE}"

        if [ -n "${AUTH}" ]; then
            IFS=' ' read -ra ITEMS <<< "${AUTH}"
            for item in "${ITEMS[@]}"; do
                username="${item%%:*}"
                password="${item#*:}"
                htpasswd -b -B -C${BCRYPT_WORK_FACTOR} "${PASSWORD_FILE}" "${username}" "${password}"
            done
        fi
    fi

    # DATA
    if [ -n "${DATA}" ]; then
        cmd+=(--path ${DATA})
    fi

    # LISTEN
    if [ -n "${LISTEN}" ]; then
        cmd+=(--listen "${LISTEN}")
    fi

    # PASSWORD_FILE
    if [ -n "${PASSWORD_FILE}" ]; then
        cmd+=(--htpasswd-file ${PASSWORD_FILE})
    fi

    # PRIVATE_REPOS
    if [ "${PRIVATE_REPOS,,}" = "true" ]; then
        cmd+=(--private-repos)
    fi

    # PROMETHEUS
    if [ "${PROMETHEUS,,}" = "true" ]; then
        cmd+=(--prometheus)
    fi
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
