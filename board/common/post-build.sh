#!/bin/sh

set -u
set -e

cat << EOF > ${TARGET_DIR}/etc/os-release
NAME=dvbheadend
ID=dvbheadend
ID_LIKE=buildroot
PRETTY_NAME="dvbheadend (Buildroot ${BR2_VERSION})"
EOF

if [ -n "${GITHUB_SHA:-}" ]; then
    echo "VERSION_ID=${GITHUB_SHA}" >> ${TARGET_DIR}/etc/os-release 
fi
