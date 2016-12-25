#!/usr/bin/env bash
set -xe

DISK=/dev/sda


timedatectl set-ntp true
timedatectl set-local-rtc 0

echo "==> clear put partitions"
/usr/bin/umount /mnt/boot || /bin/true
/usr/bin/umount /mnt || /bin/true
/usr/bin/sgdisk --zap ${DISK}

echo "==> set partition positions"
/usr/bin/sgdisk --new=1:0:512M ${DISK}
/usr/bin/sgdisk --new=2:0:0 ${DISK}

echo "==> set partition names"
/usr/bin/sgdisk --change-name 1:boot ${DISK}
/usr/bin/sgdisk --change-name 2:home ${DISK}

echo "==> set partition types"
/usr/bin/sgdisk --typecode=1:ef00 ${DISK}
/usr/bin/sgdisk --typecode=2:8300 ${DISK}

echo "==> format partitions"
mkfs.fat -F32 ${DISK}1
/usr/bin/mkfs.ext4 ${DISK}2
/usr/bin/mount ${DISK}2 /mnt
/usr/bin/mkdir /mnt/boot
/usr/bin/mount ${DISK}1 /mnt/boot

echo '==> bootstrapping the base installation'
#pacstrap /mnt base base-devel wpa_supplicant
/usr/bin/pacstrap /mnt base base-devel wpa_supplicant dialog python2 openssh

echo '==> generating the filesystem table'
/usr/bin/genfstab -U /mnt >> "/mnt/etc/fstab"

arch-chroot /mnt hwclock --systohc
arch-chroot /mnt echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen    # Für Deutschland
arch-chroot /mnt locale-gen
arch-chroot /mnt ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
    arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt /usr/bin/usermod --password `/usr/bin/openssl passwd -crypt 'root'` root
arch-chroot /mnt /usr/bin/bootctl --path=/boot install
arch-chroot /mnt /bin/bash -c "cat >/boot/loader/loader.conf <<EOL
default  arch
timeout  2
editor   0
EOL"
arch-chroot /mnt /bin/bash  -c "cat >/boot/loader/entries/arch.conf <<EOL
title          Arch Linux
linux          /vmlinuz-linux
initrd         /initramfs-linux.img
options        root=PARTUUID=`blkid -s PARTUUID -o value ${DISK}2` rw
EOL"

read -p "Unount /mnt and reboot? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    umount -R /mnt
    reboot
fi
set +xe
