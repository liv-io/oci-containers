#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables
WOODPECKER_ADMIN="${WOODPECKER_ADMIN:-}"
WOODPECKER_AGENT_SECRET="${WOODPECKER_AGENT_SECRET:-}"
WOODPECKER_BACKEND_HTTPS_PROXY="${WOODPECKER_BACKEND_HTTPS_PROXY:-}"
WOODPECKER_BACKEND_HTTP_PROXY="${WOODPECKER_BACKEND_HTTP_PROXY:-}"
WOODPECKER_BACKEND_NO_PROXY="${WOODPECKER_BACKEND_NO_PROXY:-}"
WOODPECKER_ENVIRONMENT="${WOODPECKER_ENVIRONMENT:-}"
WOODPECKER_GITHUB="${WOODPECKER_GITHUB:-true}"
WOODPECKER_GITHUB_CLIENT="${WOODPECKER_GITHUB_CLIENT:-}"
WOODPECKER_GITHUB_SECRET="${WOODPECKER_GITHUB_SECRET:-}"
WOODPECKER_GITHUB_URL="${WOODPECKER_GITHUB_URL:-https://github.com}"
WOODPECKER_GRPC_ADDR="${WOODPECKER_GRPC_ADDR:-}"
WOODPECKER_GRPC_SECRET="${WOODPECKER_GRPC_SECRET:-}"
WOODPECKER_HOST="${WOODPECKER_HOST:-}"
WOODPECKER_LOG_LEVEL="${WOODPECKER_LOG_LEVEL:-info}"
WOODPECKER_METRICS_SERVER_ADDR="${WOODPECKER_METRICS_SERVER_ADDR:-}"
WOODPECKER_OPEN="${WOODPECKER_OPEN:-true}"
WOODPECKER_ORGS="${WOODPECKER_ORGS:-}"
WOODPECKER_REPO_OWNERS="${WOODPECKER_REPO_OWNERS:-}"
WOODPECKER_SERVER_ADDR="${WOODPECKER_SERVER_ADDR:-}"

function assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/woodpecker-server)

    # WOODPECKER_ADMIN
    if [ -n "${WOODPECKER_ADMIN}" ]; then
        cmd+=(--admin "${WOODPECKER_ADMIN}")
    fi

    # WOODPECKER_AGENT_SECRET
    if [ -n "${WOODPECKER_AGENT_SECRET}" ]; then
        cmd+=(--agent-secret "${WOODPECKER_AGENT_SECRET}")
    fi

    # WOODPECKER_BACKEND_HTTPS_PROXY
    if [ -n "${WOODPECKER_BACKEND_HTTPS_PROXY}" ]; then
        cmd+=(--backend-https-proxy "${WOODPECKER_BACKEND_HTTPS_PROXY}")
    fi

    # WOODPECKER_BACKEND_HTTP_PROXY
    if [ -n "${WOODPECKER_BACKEND_HTTP_PROXY}" ]; then
        cmd+=(--backend-http-proxy "${WOODPECKER_BACKEND_HTTP_PROXY}")
    fi

    # WOODPECKER_BACKEND_NO_PROXY
    if [ -n "${WOODPECKER_BACKEND_NO_PROXY}" ]; then
        cmd+=(--backend-no-proxy "${WOODPECKER_BACKEND_NO_PROXY}")
    fi

    # WOODPECKER_ENVIRONMENT
    if [ -n "${WOODPECKER_ENVIRONMENT}" ]; then
        cmd+=(--environment "${WOODPECKER_ENVIRONMENT}")
    fi

    # WOODPECKER_GITHUB
    if [ "${WOODPECKER_GITHUB,,}" = "true" ]; then
        cmd+=(--github true)
    else
        cmd+=(--github false)
    fi

    # WOODPECKER_GITHUB_CLIENT
    if [ -n "${WOODPECKER_GITHUB_CLIENT}" ]; then
        cmd+=(--github-client "${WOODPECKER_GITHUB_CLIENT}")
    fi

    # WOODPECKER_GITHUB_SECRET
    if [ -n "${WOODPECKER_GITHUB_SECRET}" ]; then
        cmd+=(--github-secret "${WOODPECKER_GITHUB_SECRET}")
    fi

    # WOODPECKER_GITHUB_URL
    if [ -n "${WOODPECKER_GITHUB_URL}" ]; then
        cmd+=(--github-server "${WOODPECKER_GITHUB_URL}")
    fi

    # WOODPECKER_GRPC_ADDR
    if [ -n "${WOODPECKER_GRPC_ADDR}" ]; then
        cmd+=(--grpc-addr "${WOODPECKER_GRPC_ADDR}")
    fi

    # WOODPECKER_GRPC_SECRET
    if [ -n "${WOODPECKER_GRPC_SECRET}" ]; then
        cmd+=(--grpc-secret "${WOODPECKER_GRPC_SECRET}")
    fi

    # WOODPECKER_HOST
    if [ -n "${WOODPECKER_HOST}" ]; then
        cmd+=(--server-host "${WOODPECKER_HOST}")
    fi

    # WOODPECKER_LOG_LEVEL
    if [ -n "${WOODPECKER_LOG_LEVEL}" ]; then
        cmd+=(--log-level "${WOODPECKER_LOG_LEVEL}")
    fi

    # WOODPECKER_METRICS_SERVER_ADDR
    if [ -n "${WOODPECKER_METRICS_SERVER_ADDR}" ]; then
        cmd+=(--metrics-server-addr "${WOODPECKER_METRICS_SERVER_ADDR}")
    fi

    # WOODPECKER_OPEN
    if [ "${WOODPECKER_OPEN,,}" = "true" ]; then
        cmd+=(--open true)
    else
        cmd+=(--open false)
    fi

    # WOODPECKER_ORGS
    if [ -n "${WOODPECKER_ORGS}" ]; then
        cmd+=(--orgs "${WOODPECKER_ORGS}")
    fi

    # WOODPECKER_REPO_OWNERS
    if [ -n "${WOODPECKER_REPO_OWNERS}" ]; then
        cmd+=(--repo-owners "${WOODPECKER_REPO_OWNERS}")
    fi

    # WOODPECKER_SERVER_ADDR
    if [ -n "${WOODPECKER_SERVER_ADDR}" ]; then
        cmd+=(--server-addr "${WOODPECKER_SERVER_ADDR}")
    fi
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
