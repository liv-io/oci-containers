#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
ADDPEER="${ADDPEER:-}"
APPDIR="${APPDIR:-/var/local/rusty-kaspa/data}"
DISABLE_UPNP="${DISABLE_UPNP:-true}"
EXTERNALIP="${EXTERNALIP:-}"
LISTEN="${LISTEN:-}"
LOGLEVEL="${LOGLEVEL:-info}"
NODNSSEED="${NODNSSEED:-false}"
NOGRPC="${NOGRPC:-true}"
NOLOGFILES="${NOLOGFILES:-true}"
RAM_SCALE="${RAM_SCALE:-0.3}"
RPCLISTEN="${RPCLISTEN:-}"
SANITY="${SANITY:-false}"
UTXOINDEX="${UTXOINDEX:-false}"

# shellcheck disable=SC2068
assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/kaspad)

    # ADDPEER
    for item in ${ADDPEER[@]}; do
        cmd+=(--addpeer="${item}")
    done

    # APPDIR
    if [ -n "${APPDIR}" ]; then
        cmd+=(--appdir "${APPDIR}")
    fi

    # DISABLE_UPNP
    if [ "${DISABLE_UPNP,,}" = "true" ]; then
        cmd+=(--disable-upnp)
    fi

    # EXTERNALIP
    if [ -n "${EXTERNALIP}" ]; then
        cmd+=(--externalip="${EXTERNALIP}")
    fi

    # LISTEN
    if [ -n "${LISTEN}" ]; then
        cmd+=(--listen="${LISTEN}")
    fi

    # LOGLEVEL
    if [ -n "${LOGLEVEL}" ]; then
        cmd+=(--loglevel="${LOGLEVEL,,}")
    fi

    # NODNSSEED
    if [ "${NODNSSEED,,}" = "true" ]; then
        cmd+=(--nodnsseed)
    fi

    # NOGRPC
    if [ "${NOGRPC,,}" = "true" ]; then
        cmd+=(--nogrpc)
    fi

    # NOLOGFILES
    if [ "${NOLOGFILES,,}" = "true" ]; then
        cmd+=(--nologfiles)
    fi

    # RAM_SCALE
    if [ -n "${RAM_SCALE}" ]; then
        cmd+=(--ram-scale="${RAM_SCALE}")
    fi

    # RPCLISTEN
    if [ -n "${RPCLISTEN}" ]; then
        cmd+=(--rpclisten="${RPCLISTEN}")
    fi

    # SANITY
    if [ "${SANITY,,}" = "true" ]; then
        cmd+=(--sanity)
    fi

    # UTXOINDEX
    if [ "${UTXOINDEX,,}" = "true" ]; then
        cmd+=(--utxoindex)
    fi

    # Answer yes to all interactive console questions
    cmd+=(--yes)
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
