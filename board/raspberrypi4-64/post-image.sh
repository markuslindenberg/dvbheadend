#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
install -D -m 0644 "${BOARD_DIR}/config.txt" "${BINARIES_DIR}/rpi-firmware/config.txt"
install -D -m 0644 "${BOARD_DIR}/cmdline.txt" "${BINARIES_DIR}/rpi-firmware/cmdline.txt"

dd if=/dev/zero of=${BINARIES_DIR}/storage.f2fs bs=1M count=128
mkfs.f2fs -R 1000:1000 -l storage ${BINARIES_DIR}/storage.f2fs

GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
rm -rf "${GENIMAGE_TMP}"
genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${BOARD_DIR}/genimage.cfg"

exit $?
