#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
ADDR="${ADDR:-}"
ALIAS="${ALIAS:-}"
ANNOUNCE_ADDR="${ANNOUNCE_ADDR:-}"
ANNOUNCE_ADDR_DISCOVERED="${ANNOUNCE_ADDR_DISCOVERED:-false}"
ANNOUNCE_ADDR_DISCOVERED_PORT="${ANNOUNCE_ADDR_DISCOVERED_PORT:-9735}"
AUTOLISTEN="${AUTOLISTEN:-false}"
BIND_ADDR="${BIND_ADDR:-0.0.0.0}"
BITCOIN_CLI="${BITCOIN_CLI:-/usr/local/bin/bitcoin-cli}"
BITCOIN_DATADIR="${BITCOIN_DATADIR:-/var/local/lightning/bitcoin-cli}"
BITCOIN_RPCCONNECT="${BITCOIN_RPCCONNECT:-127.0.0.1}"
BITCOIN_RPCPASSWORD="${BITCOIN_RPCPASSWORD:-}"
BITCOIN_RPCPORT="${BITCOIN_RPCPORT:-8332}"
BITCOIN_RPCUSER="${BITCOIN_RPCUSER:-}"
LIGHTNING_DIR="${LIGHTNING_DIR:-/var/local/lightning/data}"
LOG_LEVEL="${LOG_LEVEL:-info}"
LOG_TIMESTAMPS="${LOG_TIMESTAMPS:-true}"
NETWORK="${NETWORK:-mainnet}"
RGB="${RGB:-000000}"

function assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/lightningd)

    # ADDR
    if [ -n "${ADDR}" ]; then
        cmd+=(--addr "${ADDR}")
    fi

    # ALIAS
    if [ -n "${ALIAS}" ]; then
        cmd+=(--alias "${ALIAS}")
    fi

    # ANNOUNCE_ADDR
    if [ -n "${ANNOUNCE_ADDR}" ]; then
        cmd+=(--announce-addr "${ANNOUNCE_ADDR}")
    fi

    # ANNOUNCE_ADDR_DISCOVERED
    if [ -n "${ANNOUNCE_ADDR_DISCOVERED}" ]; then
        cmd+=(--announce-addr-discovered "${ANNOUNCE_ADDR_DISCOVERED,,}")
    fi

    # ANNOUNCE_ADDR_DISCOVERED_PORT
    if [ -n "${ANNOUNCE_ADDR_DISCOVERED_PORT}" ]; then
        cmd+=(--announce-addr-discovered-port "${ANNOUNCE_ADDR_DISCOVERED_PORT}")
    fi

    # AUTOLISTEN
    if [ "${AUTOLISTEN,,}" = "false" ]; then
        cmd+=(--autolisten false)
    else
        cmd+=(--autolisten true)
    fi

    # BIND_ADDR
    if [ -n "${BIND_ADDR}" ]; then
        cmd+=(--bind-addr "${BIND_ADDR}")
    fi

    # BITCOIN_CLI
    if [ -n "${BITCOIN_CLI}" ]; then
        cmd+=(--bitcoin-cli "${BITCOIN_CLI}")
    fi

    # BITCOIN_DATADIR
    if [ -n "${BITCOIN_DATADIR}" ]; then
        cmd+=(--bitcoin-datadir "${BITCOIN_DATADIR}")
    fi

    # BITCOIN_RPCCONNECT
    if [ -n "${BITCOIN_RPCCONNECT}" ]; then
        cmd+=(--bitcoin-rpcconnect "${BITCOIN_RPCCONNECT}")
    fi

    # BITCOIN_RPCPASSWORD
    if [ -n "${BITCOIN_RPCPASSWORD}" ]; then
        cmd+=(--bitcoin-rpcpassword "${BITCOIN_RPCPASSWORD}")
    fi

    # BITCOIN_RPCPORT
    if [ -n "${BITCOIN_RPCPORT}" ]; then
        cmd+=(--bitcoin-rpcport "${BITCOIN_RPCPORT}")
    fi

    # BITCOIN_RPCUSER
    if [ -n "${BITCOIN_RPCUSER}" ]; then
        cmd+=(--bitcoin-rpcuser "${BITCOIN_RPCUSER}")
    fi

    # LIGHTNING_DIR
    if [ -n "${LIGHTNING_DIR}" ]; then
        cmd+=(--lightning-dir "${LIGHTNING_DIR}")
    fi

    # LOG_LEVEL
    if [ -n "${LOG_LEVEL}" ]; then
        cmd+=(--log-level "${LOG_LEVEL,,}")
    fi

    # LOG_TIMESTAMPS
    if [ "${LOG_TIMESTAMPS,,}" = "false" ]; then
        cmd+=(--log-timestamps false)
    else
        cmd+=(--log-timestamps true)
    fi

    # NETWORK (MAINNET / TESTNET)
    if [ "${NETWORK,,}" = "testnet" ]; then
        cmd+=(--network testnet)
    else
        cmd+=(--network bitcoin)
    fi

    # RGB
    if [ -n "${RGB}" ]; then
        cmd+=(--rgb "${RGB}")
    fi
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
