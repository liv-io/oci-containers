#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELL="/bin/bash"
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

CACHE="${CACHE:-60}"
CONF="${CONF:-/var/local/coredns/config/corefile}"
FORWARD="${FORWARD:-}"
HEALTH="${HEALTH:-:8080}"
LOG="${LOG:-errors}"
PORT="${PORT:-1053}"
RELOAD="${RELOAD:-30s}"
ROOT="${ROOT:-/var/local/coredns/zones}"

log() {
    IFS=',' read -ra ITEMS <<<"${LOG}"
    for item in "${ITEMS[@]}"; do
        read -r item_clean <<<"${item}"
        echo "    ${item_clean}"
    done
}

forward() {
    if [ -n "${FORWARD}" ]; then
        echo "    forward . ${FORWARD}"
    else
        echo "    template ANY ANY {"
        echo "        rcode REFUSED"
        echo "    }"
    fi
}

root() {
    echo ". {"
    echo "    health :8080"
    echo "$(log)"
    echo "$(forward)"
    echo "}"
}

zones() {
    for item in $(find ${ROOT} -type f -printf "%f\n" | sort); do
        echo "${item#db.} {"
        echo "    file ${ROOT}/${item}"
        echo "    cache ${CACHE}"
        echo "    reload ${RELOAD}"
        echo "$(log)"
        echo "}"
        echo
    done
}

assemble_corefile() {
    cat <<EOF >"${CONF}"
$(root)

$(zones)
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
