#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
WOODPECKER_AGENT_SECRET="${WOODPECKER_AGENT_SECRET:-}"
WOODPECKER_BACKEND="${WOODPECKER_BACKEND:-docker}"
WOODPECKER_BACKEND_DOCKER_API_VERSION="${WOODPECKER_BACKEND_DOCKER_API_VERSION:-}"
WOODPECKER_BACKEND_DOCKER_CERT_PATH="${WOODPECKER_BACKEND_DOCKER_CERT_PATH:-}"
WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6="${WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6:-false}"
WOODPECKER_BACKEND_DOCKER_HOST="${WOODPECKER_BACKEND_DOCKER_HOST:-unix://run/podman/podman.sock}"
WOODPECKER_BACKEND_DOCKER_NETWORK="${WOODPECKER_BACKEND_DOCKER_NETWORK:-}"
WOODPECKER_BACKEND_DOCKER_TLS_VERIFY="${WOODPECKER_BACKEND_DOCKER_TLS_VERIFY:-true}"
WOODPECKER_BACKEND_DOCKER_VOLUMES="${WOODPECKER_BACKEND_DOCKER_VOLUMES:-}"
WOODPECKER_BACKEND_LOCAL_TEMP_DIR="${WOODPECKER_BACKEND_LOCAL_TEMP_DIR:-/var/local/woodpecker-agent/tmp}"
WOODPECKER_GRPC_SECURE="${WOODPECKER_GRPC_SECURE:-false}"
WOODPECKER_GRPC_VERIFY="${WOODPECKER_GRPC_VERIFY:-true}"
WOODPECKER_HEALTHCHECK="${WOODPECKER_HEALTHCHECK:-true}"
WOODPECKER_HEALTHCHECK_ADDR="${WOODPECKER_HEALTHCHECK_ADDR:-}"
WOODPECKER_HOSTNAME="${WOODPECKER_HOSTNAME:-woodpecker-agent}"
WOODPECKER_LOG_LEVEL="${WOODPECKER_LOG_LEVEL:-info}"
WOODPECKER_SERVER="${WOODPECKER_SERVER:-}"

assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/woodpecker-agent)

    # WOODPECKER_AGENT_SECRET
    if [ -n "${WOODPECKER_AGENT_SECRET}" ]; then
        cmd+=(--grpc-token "${WOODPECKER_AGENT_SECRET}")
    fi

    # WOODPECKER_BACKEND
    if [ "${WOODPECKER_BACKEND,,}" = "local" ]; then
        cmd+=(--backend-engine local)

        # WOODPECKER_BACKEND_LOCAL_TEMP_DIR
        if [ -n "${WOODPECKER_BACKEND_LOCAL_TEMP_DIR}" ]; then
            cmd+=(--backend-local-temp-dir "${WOODPECKER_BACKEND_LOCAL_TEMP_DIR}")
        fi
    else
        cmd+=(--backend-engine docker)

        # WOODPECKER_BACKEND_DOCKER_API_VERSION
        if [ -n "${WOODPECKER_BACKEND_DOCKER_API_VERSION}" ]; then
            cmd+=(--backend-docker-api-version "${WOODPECKER_BACKEND_DOCKER_API_VERSION}")
        fi

        # WOODPECKER_BACKEND_DOCKER_CERT_PATH
        if [ -n "${WOODPECKER_BACKEND_DOCKER_CERT_PATH}" ]; then
            cmd+=(--backend-docker-cert "${WOODPECKER_BACKEND_DOCKER_CERT_PATH}")
        fi

        # WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6
        if [ "${WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6,,}" = "true" ]; then
            cmd+=(--backend-docker-ipv6 true)
        else
            cmd+=(--backend-docker-ipv6 false)
        fi

        # WOODPECKER_BACKEND_DOCKER_HOST
        if [ -n "${WOODPECKER_BACKEND_DOCKER_HOST}" ]; then
            cmd+=(--backend-docker-host "${WOODPECKER_BACKEND_DOCKER_HOST}")
        fi

        # WOODPECKER_BACKEND_DOCKER_NETWORK
        if [ -n "${WOODPECKER_BACKEND_DOCKER_NETWORK}" ]; then
            cmd+=(--backend-docker-network "${WOODPECKER_BACKEND_DOCKER_NETWORK}")
        fi

        # WOODPECKER_BACKEND_DOCKER_TLS_VERIFY
        if [ "${WOODPECKER_BACKEND_DOCKER_TLS_VERIFY,,}" = "false" ]; then
            cmd+=(--backend-docker-tls-verify true)
        else
            cmd+=(--backend-docker-tls-verify false)
        fi

        # WOODPECKER_BACKEND_DOCKER_VOLUMES
        if [ -n "${WOODPECKER_BACKEND_DOCKER_VOLUMES}" ]; then
            cmd+=(--backend-docker-volumes "${WOODPECKER_BACKEND_DOCKER_VOLUMES}")
        fi
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
    if [ -n "${WOODPECKER_HEALTHCHECK_ADDR}" ]; then
        cmd+=(--healthcheck-addr "${WOODPECKER_HEALTHCHECK_ADDR}")
    fi

    # WOODPECKER_HOSTNAME
    if [ -n "${WOODPECKER_HOSTNAME}" ]; then
        cmd+=(--hostname "${WOODPECKER_HOSTNAME}")
    fi

    # WOODPECKER_LOG_LEVEL
    if [ -n "${WOODPECKER_LOG_LEVEL}" ]; then
        cmd+=(--log-level "${WOODPECKER_LOG_LEVEL}")
    fi

    # WOODPECKER_SERVER
    if [ -n "${WOODPECKER_SERVER}" ]; then
        cmd+=(--server "${WOODPECKER_SERVER}")
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
