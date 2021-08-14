#! /usr/bin/env -S bash -ex

install -D --owner="root" --group="root" --mode="755" --verbose "raspberry-pi-luks/usr/local/share/kernel/postinst.d/01-rpi-initramfs-tools" "/mnt/croot/usr/local/share/kernel/postinst.d/01-rpi-initramfs-tools"

install -D --owner="root" --group="root" --mode="755" --verbose "raspberry-pi-luks/usr/local/share/kernel/postrm.d/01-rpi-initramfs-tools" "/mnt/croot/usr/local/share/kernel/postrm.d/01-rpi-initramfs-tools"

install -D --owner="root" --group="root" --mode="755" --verbose "raspberry-pi-luks/usr/local/share/kernel/preinst.d/01-rpi-initramfs-tools" "/mnt/croot/usr/local/share/kernel/preinst.d/01-rpi-initramfs-tools"

