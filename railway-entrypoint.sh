#!/bin/sh
# Railway allows one volume per service, so admin-UI config (PEERTUBE_LOCAL_CONFIG)
# lives inside the /data volume instead of a second /config mount.
set -e
mkdir -p /data/config
exec /usr/local/bin/entrypoint.sh "$@"
