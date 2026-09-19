#!/bin/sh
set -e

HOST_FILE="/storage/.windows-hostname"

if [ -f "$HOST_FILE" ]; then
    HOST="$(cat "$HOST_FILE")"
else
    RANDOM_ID="$(tr -dc 'A-Z0-9' </dev/urandom | head -c 7)"
    HOST="DESKTOP-${RANDOM_ID}"
    echo "$HOST" > "$HOST_FILE"
fi

export HOST

echo "Windows hostname: $HOST"

exec /usr/bin/tini -s /run/entry.sh