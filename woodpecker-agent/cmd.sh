#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
WOODPECKER_AGENT_SECRET="${WOODPECKER_AGENT_SECRET:-}"
WOODPECKER_GRPC_SECURE="${WOODPECKER_GRPC_SECURE:-false}"
WOODPECKER_GRPC_VERIFY="${WOODPECKER_GRPC_VERIFY:-true}"
WOODPECKER_HEALTHCHECK="${WOODPECKER_HEALTHCHECK:-true}"
WOODPECKER_HEALTHCHECK_ADDR="${WOODPECKER_HEALTHCHECK_ADDR:-}"
WOODPECKER_HOSTNAME="${WOODPECKER_HOSTNAME:-woodpecker-agent}"
WOODPECKER_LOG_LEVEL="${WOODPECKER_LOG_LEVEL:-info}"
WOODPECKER_SERVER="${WOODPECKER_SERVER:-}"

# TODO
#WOODPECKER_BACKEND_DOCKER_HOST
#WOODPECKER_BACKEND_DOCKER_API_VERSION
#WOODPECKER_BACKEND_DOCKER_CERT_PATH
#WOODPECKER_BACKEND_DOCKER_TLS_VERIFY
#WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6
#WOODPECKER_BACKEND_DOCKER_NETWORK
#WOODPECKER_BACKEND_DOCKER_VOLUMES

function assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/woodpecker-agent)

    # WOODPECKER_AGENT_SECRET
    if [ ! -z "${WOODPECKER_AGENT_SECRET}" ]; then
        cmd+=(--grpc-token ${WOODPECKER_AGENT_SECRET})
    fi

    # WOODPECKER_GRPC_VERIFY
    if [ "${WOODPECKER_GRPC_VERIFY,,}" = "true" ]; then
        cmd+=(--grpc-skip-insecure true)
    else
        cmd+=(--grpc-skip-insecure false)
    fi

    # WOODPECKER_HEALTHCHECK
    if [ "${WOODPECKER_HEALTHCHECK,,}" = "true" ]; then
        cmd+=(--healthcheck true)
    else
        cmd+=(--healthcheck false)
    fi

    # WOODPECKER_HEALTHCHECK_ADDR
    if [ ! -z "${WOODPECKER_HEALTHCHECK_ADDR}" ]; then
        cmd+=(--healthcheck-addr ${WOODPECKER_HEALTHCHECK_ADDR})
    fi

    # WOODPECKER_HOSTNAME
    if [ ! -z "${WOODPECKER_HOSTNAME}" ]; then
        cmd+=(--hostname ${WOODPECKER_HOSTNAME})
    fi

    # WOODPECKER_LOG_LEVEL
    if [ ! -z "${WOODPECKER_LOG_LEVEL}" ]; then
        cmd+=(--log-level ${WOODPECKER_LOG_LEVEL})
    fi

    # WOODPECKER_SERVER
    if [ ! -z "${WOODPECKER_SERVER}" ]; then
        cmd+=(--server ${WOODPECKER_SERVER})
    fi

    # NOTE: For some reason, the order of the --grpc-secure option matters.

    # WOODPECKER_GRPC_SECURE
    if [ "${WOODPECKER_GRPC_SECURE,,}" = "true" ]; then
        cmd+=(--grpc-secure true)
    else
        cmd+=(--grpc-secure false)
    fi
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
