#!/bin/sh

set -e

export TARGET_UID=${STRONGSWAN_UID:-0}
export TARGET_GID=${STRONGSWAN_GID:-0}
export TARGET_REMAP_IDS=${STRONGSWAN_REMAP_IDS:-0}
export TARGET_USER=${STRONGSWAN_USER:-root}
export TARGET_GROUP=${STRONGSWAN_GROUP:-root}
export TARGET_HOME=${STRONGSWAN_HOME:-/root}
export TARGET_SHELL=${STRONGSWAN_SHELL:-/bin/sh}

exec /usr/local/bin/entrypoint_su-exec.sh /cmd.sh "$@"