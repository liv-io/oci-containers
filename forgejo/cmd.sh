#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
CONFIG="${CONFIG:-/var/local/forgejo/work/custom/conf/app.ini}"
CUSTOM_PATH="${CUSTOM_PATH:-/var/local/forgejo/work/custom}"
INSTALL_PORT="${INSTALL_PORT:-3000}"
PID="${PID:-}"
PORT="${PORT:-3000}"
WORK_PATH="${WORK_PATH:-/var/local/forgejo/work}"

assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/forgejo)
    cmd+=(web)

    # CONFIG
    if [ -n "${CONFIG}" ]; then
        cmd+=(--config "${CONFIG}")
    fi

    # CUSTOM_PATH
    if [ -n "${CUSTOM_PATH}" ]; then
        cmd+=(--custom-path "${CUSTOM_PATH}")
    fi

    # INSTALL_PORT
    if [ -n "${INSTALL_PORT}" ]; then
        cmd+=(--install-port "${INSTALL_PORT}")
    fi

    # PID
    if [ -n "${PID}" ]; then
        cmd+=(--pid "${PID}")
    fi

    # PORT
    if [ -n "${PORT}" ]; then
        cmd+=(--port "${PORT}")
    fi

    # WORK_PATH
    if [ -n "${WORK_PATH}" ]; then
        cmd+=(--work-path "${WORK_PATH}")
    fi
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
