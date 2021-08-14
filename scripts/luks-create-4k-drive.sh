#! /usr/bin/env -S bash -ex

#DRIVE="/dev/sdd2"
#LABEL="croot"

DRIVE="/dev/sdd3"
LABEL="cblocks"

OFFSET=$((1024*8))
BS=4096
#BS=512

CIPHER="xchacha12,aes-adiantum-plain64"
#CIPHER="xchacha20,aes-adiantum-plain64"
KEY_SIZE=256

#CIPHER="aes-xts-plain64"
#KEY_SIZE=512

HASH="sha512"
ITER_TIME=4000

umount "/mnt/${LABEL}" || true
cryptdisks_stop "${LABEL}"

cryptsetup \
    --cipher="${CIPHER}" --label="${LABEL}" --key-size="${KEY_SIZE}" \
    --hash="${HASH}" --sector-size="${BS}" --offset="${OFFSET}" \
    --iter-time="${ITER_TIME}" --debug \
    luksFormat "${DRIVE}"

cryptsetup \
    --persistent --allow-discards --debug \
    luksOpen "${DRIVE}" "${LABEL}"

#mkfs.ext4 "/dev/mapper/${LABEL}"
mkfs.ext4 -b "${BS}" "/dev/mapper/${LABEL}"

mkdir "/mnt/${LABEL}" || true

mount "/dev/mapper/${LABEL}" "/mnt/${LABEL}"

# Nocrypt
#mkfs.ext4 -b "${BS}" "${DRIVE}"
#mkdir "/mnt/${LABEL}" || true
#mount "${DRIVE}" "/mnt/${LABEL}"

