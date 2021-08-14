#! /usr/bin/env -S bash -ex

if [ "${1}" == "on32" ]; then
    mount --types proc /proc/ proc/
    mount --rbind /sys sys/
    mount --make-rslave sys/
    mount --rbind /dev/ dev/
    mount --make-rslave dev/
    mount --rbind /run/ run/
    mount --make-rslave run/
    cp --dereference /etc/resolv.conf etc/
    echo "Make sure to mount /boot"
    chroot . /bin/bash
elif [ "${1}" == "on64" ]; then
    mount --types proc /proc/ proc/
    mount --rbind /sys sys/
    mount --make-rslave sys/
    mount --rbind /dev/ dev/
    mount --make-rslave dev/
    mount --rbind /run/ run/
    mount --make-rslave run/
    cp --dereference /etc/resolv.conf etc/
    mv usr/bin/qemu-aarch64-static usr/bin/qemu-aarch64-static.bak
    cp /usr/bin/qemu-aarch64-static usr/bin/
    echo "Make sure to mount /boot"
    chroot . /usr/bin/qemu-aarch64-static /bin/bash
elif [ "${1}" == "off" ]; then
    rm usr/bin/qemu-aarch64-static || true
    cp usr/bin/qemu-aarch64-static.bak usr/bin/qemu-aarch64-static
    umount boot/ || true
    umount --lazy --recursive {proc/,sys/,dev/,run/}
fi

