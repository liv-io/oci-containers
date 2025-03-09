#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

# Environment variables

assemble_command() {
    cmd=(exec)
    cmd+=(/usr/bin/npm)
    cmd+=(run)
    cmd+=(start)
}

# Establish run order
main() {
    assemble_command
    "${cmd[@]}"
}

main
