#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
ADDNODE="${ADDNODE:-}"
BIND="${BIND:-0.0.0.0}"
DATADIR="${DATADIR:-/var/local/bitcoin-core/db}"
DBCACHE="${DBCACHE:-2048}"
EXTERNALIP="${EXTERNALIP:-}"
ONLYNET="${ONLYNET:-ipv4}"
PORT="${PORT:-8333}"
REST="${REST:-false}"
RPCALLOWIP="${RPCALLOWIP:-127.0.0.0/8}"
RPCAUTH="${RPCAUTH:-}"
RPCBIND="${RPCBIND:-127.0.0.1}"
RPCPORT="${RPCPORT:-8332}"
ZMQPUBHASHBLOCK="${ZMQPUBHASHBLOCK:-tcp://127.0.0.1:5555}"
ZMQPUBHASHTX="${ZMQPUBHASHTX:-tcp://127.0.0.1:5556}"
ZMQPUBRAWBLOCK="${ZMQPUBRAWBLOCK:-tcp://127.0.0.1:5557}"
ZMQPUBRAWTX="${ZMQPUBRAWTX:-tcp://127.0.0.1:5558}"

function assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/bitcoind)
    cmd+=(-assumevalid=0)
    cmd+=(-chain=main)
    cmd+=(-disablewallet=1)
    cmd+=(-peerbloomfilters=0)
    cmd+=(-printtoconsole=1)
    cmd+=(-server=1)
    cmd+=(-txindex=1)

    # ADDNODE
    for item in "${ADDNODE[@]}"; do
        cmd+=(-addnode="${item}")
    done

    # BIND
    if [ -n "${BIND}" ]; then
        cmd+=(-bind="${BIND}")
    fi

    # DATADIR
    if [ -n "${DATADIR}" ]; then
        cmd+=(-datadir="${DATADIR}")
    fi

    # DBCACHE
    if [ -n "${DBCACHE}" ]; then
        cmd+=(-dbcache="${DBCACHE}")
    fi

    # EXTERNALIP
    if [ -n "${EXTERNALIP}" ]; then
        cmd+=(-externalip="${EXTERNALIP}")
    fi

    # ONLYNET
    for item in "${ONLYNET[@]}"; do
        cmd+=(-onlynet="${item}")
    done

    # PORT
    if [ -n "${PORT}" ]; then
        cmd+=(-port="${PORT}")
    fi

    # REST
    if [ "${REST,,}" = "true" ]; then
        cmd+=(-rest=1)

        # RPCALLOWIP
        for item in "${RPCALLOWIP[@]}"; do
            cmd+=(-rpcallowip="${item}")
        done

        # RPCAUTH
        for item in "${RPCAUTH[@]}"; do
            cmd+=(-rpcauth="${item}")
        done

        # RPCBIND
        for item in "${RPCBIND[@]}"; do
            cmd+=(-rpcbind="${item}")
        done

        # RPCPORT
        if [ -n "${RPCPORT}" ]; then
            cmd+=(-rpcport="${RPCPORT}")
        fi

        # ZMQPUBHASHBLOCK
        if [ -n "${ZMQPUBHASHBLOCK}" ]; then
            cmd+=(-zmqpubhashblock="${ZMQPUBHASHBLOCK}")
        fi

        # ZMQPUBHASHTX
        if [ -n "${ZMQPUBHASHTX}" ]; then
            cmd+=(-zmqpubhashtx="${ZMQPUBHASHTX}")
        fi

        # ZMQPUBRAWBLOCK
        if [ -n "${ZMQPUBRAWBLOCK}" ]; then
            cmd+=(-zmqpubrawblock="${ZMQPUBRAWBLOCK}")
        fi

        # ZMQPUBRAWTX
        if [ -n "${ZMQPUBRAWTX}" ]; then
            cmd+=(-zmqpubrawtx="${ZMQPUBRAWTX}")
        fi
    else
        cmd+=(-rest=0)
    fi
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
