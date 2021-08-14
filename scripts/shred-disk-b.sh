#! /usr/bin/env -S bash -ex

DRIVE="sdXDANGER"

openssl enc \
    -aes-256-ctr -pass pass:"$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | \
    base64)" -nosalt < /dev/zero | \
    pv -pterb -s "$(blockdev --getsize64 /dev/${DRIVE})" > "/dev/${DRIVE}"

