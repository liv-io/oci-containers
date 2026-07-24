#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

debian_version() {
    echo "Debian:"
    cat /etc/debian_version | awk '{print "  " $0}'
}

command_version() {
    local command="${1}"
    local option="${2:-version}"

    echo "${command}:"
    ${command} ${option} | awk '{print "  " $0}'
}

assemble_command() {
    cmd=(exec)
    cmd+=(${@})
}

# Establish run order
main() {
    debian_version
    command_version "curl" "--version"
    command_version "helm"
    command_version "k0s"
    command_version "k0sctl"
    command_version "kubectl" "version --client"
    command_version "kubesoloctl"
    command_version "kustomize"
    command_version "openssl" "--version"
    command_version "yq" "--version"
    assemble_command
    "${cmd[@]}"
}

main
