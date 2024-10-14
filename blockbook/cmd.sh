#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
BLOCK_ADDRESSES_TO_KEEP="${BLOCK_ADDRESSES_TO_KEEP:-300}"
COIN_LABEL="${COIN_LABEL:-Bitcoin}"
COIN_NAME="${COIN_NAME:-Bitcoin}"
COIN_SHORTCUT="${COIN_SHORTCUT:-BTC}"
MESSAGE_QUEUE_BINDING="${MESSAGE_QUEUE_BINDING:-}"
PARSE="${PARSE:-true}"
RPC_PASS="${RPC_PASS:-}"
RPC_TIMEOUT="${RPC_TIMEOUT:-25}"
RPC_URL="${RPC_URL:-}"
RPC_USER="${RPC_USER:-}"
PORT="${PORT:-}"

# Configuration files
CONFIG_DST="/var/local/blockbook/config"
BLOCKBOOK_JSON="${CONFIG_DST}/blockbook.json"

# Database path
DB_PATH="/var/local/blockbook/db"

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

reset_configuration() {
    # Reset existing configuration file
    echo "{}" >"${BLOCKBOOK_JSON}"
}

config_blockbook_json() {
    # .address_format
    if [ -n "${ADDRESS_FORMAT}" ]; then
        jq ".address_format = \"${ADDRESS_FORMAT}\"" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .block_addresses_to_keep
    if [ -n "${BLOCK_ADDRESSES_TO_KEEP}" ]; then
        jq ".block_addresses_to_keep = ${BLOCK_ADDRESSES_TO_KEEP}" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .coin_label
    if [ -n "${COIN_LABEL}" ]; then
        jq ".coin_label = \"${COIN_LABEL}\"" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .coin_name
    if [ -n "${COIN_NAME}" ]; then
        jq ".coin_name = \"${COIN_NAME}\"" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .coin_shortcut
    if [ -n "${COIN_SHORTCUT}" ]; then
        jq ".coin_shortcut = \"${COIN_SHORTCUT}\"" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .message_queue_binding
    if [ -n "${MESSAGE_QUEUE_BINDING}" ]; then
        jq ".message_queue_binding = \"${MESSAGE_QUEUE_BINDING}\"" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .parse
    if [ "${PARSE,,}" = "true" ]; then
        jq ".parse = true" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    else
        jq ".parse = false" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .rpc_pass
    if [ -n "${RPC_PASS}" ]; then
        jq ".rpc_pass = \"${RPC_PASS}\"" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .rpc_timeout
    if [ -n "${RPC_TIMEOUT}" ]; then
        jq ".rpc_timeout = ${RPC_TIMEOUT}" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .rpc_url
    if [ -n "${RPC_URL}" ]; then
        jq ".rpc_url = \"${RPC_URL}\"" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .rpc_user
    if [ -n "${RPC_USER}" ]; then
        jq ".rpc_user = \"${RPC_USER}\"" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi

    # .subversion
    if [ -n "${SUBVERSION}" ]; then
        jq ".subversion = \"${SUBVERSION}\"" "${BLOCKBOOK_JSON}" | write_file "${BLOCKBOOK_JSON}"
    fi
}

# shellcheck disable=SC2206
assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/blockbook)

    # -blockchaincfg
    cmd+=(-blockchaincfg="${BLOCKBOOK_JSON}")

    # -datadir
    cmd+=(-datadir="${DB_PATH}")

    # -logtostderr
    cmd+=(-logtostderr)

    # -public
    if [ -n "${PORT}" ]; then
        cmd+=(-public=:${PORT})
    fi

    # -sync
    cmd+=(-sync)
}

# Establish run order
main() {
    reset_configuration
    config_blockbook_json
    assemble_command
    "${cmd[@]}"
}

main
