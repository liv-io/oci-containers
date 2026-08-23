#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

BIND="${BIND:-0.0.0.0 ::}"
CACHE="${CACHE:-60}"
CONF="${CONF:-/var/local/coredns/config/corefile}"
FORWARD="${FORWARD:-}"
HEALTH="${HEALTH:-:8080}"
LOG="${LOG:-log,errors}"
PORT="${PORT:-1053}"
RELOAD="${RELOAD:-30s}"
ROOT="${ROOT:-/var/local/coredns/zones}"

forward() {
    if [ -n "${FORWARD}" ]; then
        echo "forward . ${FORWARD}"
    fi
}

assemble_corefile() {
    cat <<EOF >"${CONF}"
. {
    bind ${BIND}
    health :8080
    cache ${CACHE}
$(
        IFS=',' read -ra ITEMS <<<"${LOG}"
        for item in "${ITEMS[@]}"; do
            read -r item_clean <<<"${item}"
            echo "    ${item_clean}"
        done
    )

    root ${ROOT}

    auto {
        directory .
        reload ${RELOAD}
    }
    $(forward)
}
EOF
}

assemble_command() {
    cmd=(exec)
    cmd+=(/usr/local/bin/coredns)

    # CONF
    if [ -n "${CONF}" ]; then
        cmd+=(-conf "${CONF}")
    fi

    # PORT
    if [ -n "${PORT}" ]; then
        cmd+=(-dns.port "${PORT}")
    fi

}

# Establish run order
main() {
    assemble_corefile
    assemble_command
    "${cmd[@]}"
}

main
