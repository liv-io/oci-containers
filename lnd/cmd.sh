#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
ALIAS="${ALIAS:-}"
BITCOIND_ESTIMATEMODE="${BITCOIND_ESTIMATEMODE:-ECONOMICAL}"
BITCOIND_RPCHOST="${BITCOIND_RPCHOST:-}"
BITCOIND_RPCPASS="${BITCOIND_RPCPASS:-}"
BITCOIND_RPCUSER="${BITCOIND_RPCUSER:-}"
BITCOIND_ZMQPUBRAWBLOCK="${BITCOIND_ZMQPUBRAWBLOCK:-tcp://127.0.0.1:5557}"
BITCOIND_ZMQPUBRAWTX="${BITCOIND_ZMQPUBRAWTX:-tcp://127.0.0.1:5558}"
BITCOIN_NETWORK="${BITCOIN_NETWORK:-mainnet}"
BITCOIN_NODE="${BITCOIN_NODE:-bitcoind}"
COLOR="${COLOR:-#000000}"
EXTERNALIP="${EXTERNALIP:-}"
LISTEN="${LISTEN:-0.0.0.0:9735}"
LNDDIR="${LNDDIR:-/var/local/lnd/data}"
RESTLISTEN="${RESTLISTEN:-}"
RPCLISTEN="${RPCLISTEN:-}"

set_defaults() {
    if [ "${BITCOIN_NETWORK,,}" = "mainnet" ]; then
        BITCOIND_RPCHOST="${BITCOIND_RPCHOST:-127.0.0.1:8332}"
    elif [ "${BITCOIN_NETWORK,,}" = "test" ] || [ "${BITCOIN_NETWORK,,}" = "testnet3" ]; then
        BITCOIND_RPCHOST="${BITCOIND_RPCHOST:-127.0.0.1:18332}"
    elif [ "${BITCOIN_NETWORK,,}" = "testnet4" ]; then
        BITCOIND_RPCHOST="${BITCOIND_RPCHOST:-127.0.0.1:48332}"
    fi
}

assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/lnd)
    cmd+=(--bitcoin.active)

    # ALIAS
    if [ -n "${ALIAS}" ]; then
        cmd+=(--alias="${ALIAS}")
    fi

    # BITCOIND_ESTIMATEMODE
    if [ "${BITCOIND_ESTIMATEMODE^^}" = "ECONOMICAL" ]; then
        cmd+=(--bitcoind.estimatemode=ECONOMICAL)
    else
        cmd+=(--bitcoind.estimatemode=CONSERVATIVE)
    fi

    # BITCOIND_RPCHOST
    if [ -n "${BITCOIND_RPCHOST}" ]; then
        cmd+=(--bitcoind.rpchost="${BITCOIND_RPCHOST}")
    fi

    # BITCOIND_RPCPASS
    if [ -n "${BITCOIND_RPCPASS}" ]; then
        cmd+=(--bitcoind.rpcpass="${BITCOIND_RPCPASS}")
    fi

    # BITCOIND_RPCUSER
    if [ -n "${BITCOIND_RPCUSER}" ]; then
        cmd+=(--bitcoind.rpcuser="${BITCOIND_RPCUSER}")
    fi

    # BITCOIND_ZMQPUBRAWBLOCK
    if [ -n "${BITCOIND_ZMQPUBRAWBLOCK}" ]; then
        cmd+=(--bitcoind.zmqpubrawblock="${BITCOIND_ZMQPUBRAWBLOCK}")
    fi

    # BITCOIND_ZMQPUBRAWTX
    if [ -n "${BITCOIND_ZMQPUBRAWTX}" ]; then
        cmd+=(--bitcoind.zmqpubrawtx="${BITCOIND_ZMQPUBRAWTX}")
    fi

    # BITCOIN_NETWORK (BITCOIN_MAINNET, BITCOIN_TESTNET, BITCOIN_TESTNET4)
    if [ "${BITCOIN_NETWORK,,}" = "mainnet" ]; then
        cmd+=(--bitcoin.mainnet)
    elif [ "${BITCOIN_NETWORK,,}" = "test" ] || [ "${BITCOIN_NETWORK,,}" = "testnet3" ]; then
        cmd+=(--bitcoin.testnet)
    elif [ "${BITCOIN_NETWORK,,}" = "testnet4" ]; then
        cmd+=(--bitcoin.testnet4)
    fi

    # BITCOIN_NODE
    if [ "${BITCOIN_NODE,,}" = "btcd" ]; then
        cmd+=(--bitcoin.node=btcd)
    else
        cmd+=(--bitcoin.node=bitcoind)
    fi

    # COLOR
    if [ -n "${COLOR}" ]; then
        cmd+=(--color="${COLOR}")
    fi

    # EXTERNALIP
    if [ -n "${EXTERNALIP}" ]; then
        cmd+=(--externalip="${EXTERNALIP}")
    fi

    # LISTEN
    if [ -n "${LISTEN}" ]; then
        cmd+=(--listen="${LISTEN}")
    fi

    # LNDDIR
    if [ -n "${LNDDIR}" ]; then
        cmd+=(--lnddir="${LNDDIR}")
    fi

    # RESTLISTEN
    if [ -n "${RESTLISTEN}" ]; then
        cmd+=(--restlisten="${RESTLISTEN}")
    fi

    # RPCLISTEN
    if [ -n "${RPCLISTEN}" ]; then
        cmd+=(--rpclisten="${RPCLISTEN}")
    fi
}

# Establish run order
main() {
    set_defaults
    assemble_command
    "${cmd[@]}"
}

main
