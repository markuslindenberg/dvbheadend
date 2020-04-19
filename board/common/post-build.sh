#!/bin/sh

set -u
set -e

rm -f ${TARGET_DIR}/etc/pam.d/*
cp -f ${TARGET_DIR}/usr/share/factory/etc/pam.d/* ${TARGET_DIR}/etc/pam.d/
rm -rf ${TARGET_DIR}/etc/network

cat << EOF > ${TARGET_DIR}/etc/os-release
NAME=dvbheadend
ID=dvbheadend
ID_LIKE=buildroot
PRETTY_NAME="dvbheadend (Buildroot ${BR2_VERSION})"
EOF

if [ -n "${GITHUB_SHA}" ]; then
    echo "VERSION_ID=${GITHUB_SHA}" >> ${TARGET_DIR}/etc/os-release 
fi
