#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
DATA="${DATA:-/var/local/memos/db}"
PORT="${PORT:-8081}"
URL="${URL:-}"

# shellcheck disable=SC2068
assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/memos)

    # DATA
    if [ -n "${DATA}" ]; then
        cmd+=(--data "${DATA}")
    fi

    # PORT
    if [ -n "${PORT}" ]; then
        cmd+=(--port "${PORT}")
    fi

    # URL
    if [ -n "${URL}" ]; then
        cmd+=(--instance-url "${URL}")
    fi
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
