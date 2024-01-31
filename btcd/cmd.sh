#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
ADDPEER="${ADDPEER:-}"
DEBUGLEVEL="${DEBUGLEVEL:-info}"
EXTERNALIP="${EXTERNALIP:-}"
LISTEN="${LISTEN:-0.0.0.0:8333}"
RPCLISTEN="${RPCLISTEN:-127.0.0.1:8334}"
RPCPASS="${RPCPASS:-}"
RPCUSER="${RPCUSER:-}"

# shellcheck disable=SC2068
assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/btcd)

    # ADDPEER
    for item in ${ADDPEER[@]}; do
        cmd+=(--addpeer="${item}")
    done

    # DEBUGLEVEL
    if [ -n "${DEBUGLEVEL}" ]; then
        cmd+=(--debuglevel="${DEBUGLEVEL}")
    fi

    # EXTERNALIP
    for item in ${EXTERNALIP[@]}; do
        cmd+=(--externalip="${item}")
    done

    # LISTEN
    for item in ${LISTEN[@]}; do
        cmd+=(--listen="${item}")
    done

    # RPCLISTEN
    for item in ${RPCLISTEN[@]}; do
        cmd+=(--rpclisten="${item}")
    done

    # RPCPASS
    if [ -n "${RPCPASS}" ]; then
        cmd+=(--rpcpass="${RPCPASS}")
    fi

    # RPCUSER
    if [ -n "${RPCUSER}" ]; then
        cmd+=(--rpcuser="${RPCUSER}")
    fi
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
