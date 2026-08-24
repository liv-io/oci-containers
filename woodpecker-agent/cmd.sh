#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

WOODPECKER_AGENT_CONFIG_FILE="${WOODPECKER_AGENT_CONFIG_FILE:-/var/local/woodpecker-agent/config/agent.conf}"
WOODPECKER_AGENT_SECRET="${WOODPECKER_AGENT_SECRET:-}"
WOODPECKER_BACKEND="${WOODPECKER_BACKEND:-kubernetes}"
WOODPECKER_BACKEND_DOCKER_API_VERSION="${WOODPECKER_BACKEND_DOCKER_API_VERSION:-}"
WOODPECKER_BACKEND_DOCKER_CERT_PATH="${WOODPECKER_BACKEND_DOCKER_CERT_PATH:-}"
WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6="${WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6:-false}"
WOODPECKER_BACKEND_DOCKER_HOST="${WOODPECKER_BACKEND_DOCKER_HOST:-unix://run/podman/podman.sock}"
WOODPECKER_BACKEND_DOCKER_NETWORK="${WOODPECKER_BACKEND_DOCKER_NETWORK:-}"
WOODPECKER_BACKEND_DOCKER_TLS_VERIFY="${WOODPECKER_BACKEND_DOCKER_TLS_VERIFY:-true}"
WOODPECKER_BACKEND_DOCKER_VOLUMES="${WOODPECKER_BACKEND_DOCKER_VOLUMES:-}"
WOODPECKER_BACKEND_K8S_NAMESPACE="${WOODPECKER_BACKEND_K8S_NAMESPACE:-woodpecker-runtime}"
WOODPECKER_BACKEND_K8S_NAMESPACE_PER_ORGANIZATION="${WOODPECKER_BACKEND_K8S_NAMESPACE_PER_ORGANIZATION:-false}"
WOODPECKER_BACKEND_K8S_PERMISSION_INIT_IMAGE="${WOODPECKER_BACKEND_K8S_PERMISSION_INIT_IMAGE:-busybox:stable-musl}"
WOODPECKER_BACKEND_K8S_POD_LABELS="${WOODPECKER_BACKEND_K8S_POD_LABELS:-"{\"app.kubernetes.io/managed-by\": \"woodpecker\"}"}"
WOODPECKER_BACKEND_K8S_PULL_SECRET_NAMES="${WOODPECKER_BACKEND_K8S_PULL_SECRET_NAMES:-}"
WOODPECKER_BACKEND_K8S_STORAGE_CLASS="${WOODPECKER_BACKEND_K8S_STORAGE_CLASS:-local-path}"
WOODPECKER_BACKEND_K8S_STORAGE_RWX="${WOODPECKER_BACKEND_K8S_STORAGE_RWX:-false}"
WOODPECKER_BACKEND_K8S_VOLUME_SIZE="${WOODPECKER_BACKEND_K8S_VOLUME_SIZE:-10G}"
WOODPECKER_BACKEND_LOCAL_TEMP_DIR="${WOODPECKER_BACKEND_LOCAL_TEMP_DIR:-/var/local/woodpecker-agent/tmp}"
WOODPECKER_GRPC_SECURE="${WOODPECKER_GRPC_SECURE:-false}"
WOODPECKER_GRPC_VERIFY="${WOODPECKER_GRPC_VERIFY:-true}"
WOODPECKER_HEALTHCHECK="${WOODPECKER_HEALTHCHECK:-true}"
WOODPECKER_HEALTHCHECK_ADDR="${WOODPECKER_HEALTHCHECK_ADDR:-}"
WOODPECKER_HOSTNAME="${WOODPECKER_HOSTNAME:-woodpecker-agent}"
WOODPECKER_LOG_LEVEL="${WOODPECKER_LOG_LEVEL:-info}"
WOODPECKER_SERVER="${WOODPECKER_SERVER:-}"

# Only compatible with WOODPECKER_BACKEND="docker"
import_ca_certificates() {
    source_dir="/var/local/woodpecker-agent/certs"
    destination_dir="/usr/local/share/ca-certificates"

    if [ -n "$(ls ${source_dir}/)" ]; then
        echo "* Importing CA certificates..."

        for cert in $(ls -1 ${source_dir}/*); do
            if $(openssl x509 -in "${cert}" -noout); then
                echo "  File Name: $(basename ${cert})"

                datetime_valid=$(openssl x509 -in "${cert}" -noout --enddate | sed 's@notAfter=@@g')
                epoch_valid=$(date --date="${datetime_valid}" --utc +'%s')
                epoch_now=$(date --utc +'%s')

                ca_certificate_name=$(openssl x509 -in "${cert}" -noout -subject | awk -F 'CN = ' '{print $NF}' | cut -f1 -d',')
                ca_certificate_fingerprint=$(openssl x509 -in "${cert}" -noout -fingerprint | sed 's@=@: @g')
                ca_certificate_valid=$(openssl x509 -in "${cert}" -noout -enddate | sed 's@notAfter=@Valid Until: @g')

                if [ "${epoch_valid}" -ge "${epoch_now}" ]; then
                    echo "  Common Name: ${ca_certificate_name}"
                    echo "  ${ca_certificate_fingerprint}"
                    echo "  ${ca_certificate_valid}"
                    cp -f "${cert}" "${destination_dir}"
                    update-ca-certificates
                    echo
                else
                    echo "  ${ca_certificate_valid}"
                    echo "Error: CA certificate expired, exiting..."
                    sleep 60
                    exit 1
                fi
            fi
        done
    fi
}

assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/woodpecker-agent)

    # WOODPECKER_AGENT_CONFIG_FILE
    if [ -n "${WOODPECKER_AGENT_CONFIG_FILE}" ]; then
        cmd+=(--agent-config="${WOODPECKER_AGENT_CONFIG_FILE}")
    fi

    # WOODPECKER_AGENT_SECRET
    if [ -n "${WOODPECKER_AGENT_SECRET}" ]; then
        cmd+=(--grpc-token="${WOODPECKER_AGENT_SECRET}")
    fi

    # WOODPECKER_BACKEND
    if [ "${WOODPECKER_BACKEND,,}" = "local" ]; then
        cmd+=(--backend-engine=local)

        # WOODPECKER_BACKEND_LOCAL_TEMP_DIR
        if [ -n "${WOODPECKER_BACKEND_LOCAL_TEMP_DIR}" ]; then
            cmd+=(--backend-local-temp-dir="${WOODPECKER_BACKEND_LOCAL_TEMP_DIR}")
        fi

    elif [ "${WOODPECKER_BACKEND,,}" = "docker" ]; then
        cmd+=(--backend-engine=docker)

        # WOODPECKER_BACKEND_DOCKER_API_VERSION
        if [ -n "${WOODPECKER_BACKEND_DOCKER_API_VERSION}" ]; then
            cmd+=(--backend-docker-api-version="${WOODPECKER_BACKEND_DOCKER_API_VERSION}")
        fi

        # WOODPECKER_BACKEND_DOCKER_CERT_PATH
        if [ -n "${WOODPECKER_BACKEND_DOCKER_CERT_PATH}" ]; then
            cmd+=(--backend-docker-cert="${WOODPECKER_BACKEND_DOCKER_CERT_PATH}")
        fi

        # WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6
        if [ "${WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6,,}" = "true" ]; then
            cmd+=(--backend-docker-ipv6=true)
        else
            cmd+=(--backend-docker-ipv6=false)
        fi

        # WOODPECKER_BACKEND_DOCKER_HOST
        if [ -n "${WOODPECKER_BACKEND_DOCKER_HOST}" ]; then
            cmd+=(--backend-docker-host="${WOODPECKER_BACKEND_DOCKER_HOST}")
        fi

        # WOODPECKER_BACKEND_DOCKER_NETWORK
        if [ -n "${WOODPECKER_BACKEND_DOCKER_NETWORK}" ]; then
            cmd+=(--backend-docker-network="${WOODPECKER_BACKEND_DOCKER_NETWORK}")
        fi

        # WOODPECKER_BACKEND_DOCKER_TLS_VERIFY
        if [ "${WOODPECKER_BACKEND_DOCKER_TLS_VERIFY,,}" = "false" ]; then
            cmd+=(--backend-docker-tls-verify=true)
        else
            cmd+=(--backend-docker-tls-verify=false)
        fi

        # WOODPECKER_BACKEND_DOCKER_VOLUMES
        if [ -n "${WOODPECKER_BACKEND_DOCKER_VOLUMES}" ]; then
            cmd+=(--backend-docker-volumes="${WOODPECKER_BACKEND_DOCKER_VOLUMES}")
        fi
    else
        # WOODPECKER_BACKEND_K8S_NAMESPACE
        if [ -n "${WOODPECKER_BACKEND_K8S_NAMESPACE}" ]; then
            cmd+=(--backend-k8s-namespace="${WOODPECKER_BACKEND_K8S_NAMESPACE}")
        fi

        # WOODPECKER_BACKEND_K8S_NAMESPACE_PER_ORGANIZATION
        if [ "${WOODPECKER_BACKEND_K8S_NAMESPACE_PER_ORGANIZATION,,}" = "true" ]; then
            cmd+=(--backend-k8s-namespace-per-org=true)
        else
            cmd+=(--backend-k8s-namespace-per-org=false)
        fi

        # WOODPECKER_BACKEND_K8S_PERMISSION_INIT_IMAGE
        if [ -n "${WOODPECKER_BACKEND_K8S_PERMISSION_INIT_IMAGE}" ]; then
            cmd+=(--backend-k8s-permission-init-image="${WOODPECKER_BACKEND_K8S_PERMISSION_INIT_IMAGE}")
        fi

        # WOODPECKER_BACKEND_K8S_POD_LABELS
        if [ -n "${WOODPECKER_BACKEND_K8S_POD_LABELS}" ]; then
            cmd+=(--backend-k8s-pod-labels="${WOODPECKER_BACKEND_K8S_POD_LABELS}")
        fi

        # WOODPECKER_BACKEND_K8S_PULL_SECRET_NAMES
        if [ -n "${WOODPECKER_BACKEND_K8S_PULL_SECRET_NAMES}" ]; then
            cmd+=(--backend-k8s-pod-image-pull-secret-names="${WOODPECKER_BACKEND_K8S_PULL_SECRET_NAMES}")
        fi

        # WOODPECKER_BACKEND_K8S_STORAGE_CLASS
        if [ -n "${WOODPECKER_BACKEND_K8S_STORAGE_CLASS}" ]; then
            cmd+=(--backend-k8s-storage-class="${WOODPECKER_BACKEND_K8S_STORAGE_CLASS}")
        fi

        # WOODPECKER_BACKEND_K8S_STORAGE_RWX
        if [ "${WOODPECKER_BACKEND_K8S_STORAGE_RWX,,}" = "true" ]; then
            cmd+=(--backend-k8s-storage-rwx=true)
        else
            cmd+=(--backend-k8s-storage-rwx=false)
        fi

        # WOODPECKER_BACKEND_K8S_VOLUME_SIZE
        if [ -n "${WOODPECKER_BACKEND_K8S_VOLUME_SIZE}" ]; then
            cmd+=(--backend-k8s-volume-size="${WOODPECKER_BACKEND_K8S_VOLUME_SIZE}")
        fi
    fi

    # WOODPECKER_GRPC_SECURE
    if [ "${WOODPECKER_GRPC_SECURE,,}" = "true" ]; then
        cmd+=(--grpc-secure=true)
    else
        cmd+=(--grpc-secure=false)
    fi

    # WOODPECKER_GRPC_VERIFY
    if [ "${WOODPECKER_GRPC_VERIFY,,}" = "true" ]; then
        cmd+=(--grpc-skip-insecure=true)
    else
        cmd+=(--grpc-skip-insecure=false)
    fi

    # WOODPECKER_HEALTHCHECK
    if [ "${WOODPECKER_HEALTHCHECK,,}" = "true" ]; then
        cmd+=(--healthcheck=true)
    else
        cmd+=(--healthcheck=false)
    fi

    # WOODPECKER_HEALTHCHECK_ADDR
    if [ -n "${WOODPECKER_HEALTHCHECK_ADDR}" ]; then
        cmd+=(--healthcheck-addr="${WOODPECKER_HEALTHCHECK_ADDR}")
    fi

    # WOODPECKER_HOSTNAME
    if [ -n "${WOODPECKER_HOSTNAME}" ]; then
        cmd+=(--hostname="${WOODPECKER_HOSTNAME}")
    fi

    # WOODPECKER_LOG_LEVEL
    if [ -n "${WOODPECKER_LOG_LEVEL}" ]; then
        cmd+=(--log-level="${WOODPECKER_LOG_LEVEL}")
    fi

    # WOODPECKER_SERVER
    if [ -n "${WOODPECKER_SERVER}" ]; then
        cmd+=(--server="${WOODPECKER_SERVER}")
    fi
}

# Establish run order
main() {
    if [ "${WOODPECKER_BACKEND,,}" = "docker" ]; then
        import_ca_certificates
    fi
    assemble_command
    "${cmd[@]}"
}

main
