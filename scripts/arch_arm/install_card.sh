#!/bin/bash

#!/bin/sh
set -xe
if [ $# -lt 1 ]
	then
	echo "Check device name for micro sd card and recal script with it's name as argument"
	sudo fdisk -l
fi

if [ $# -eq 1 ]
	then
	DEVICE=$1
  #wget -O "`dirname $0`/../../bucket/archlinuxarm-rpi2.tar.gz" http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz
  
  sudo umount /root/tmp/boot /root/tmp/root || true
  sudo sfdisk --delete ${DEVICE}
  sudo sfdisk ${DEVICE} < "`dirname $0`/disk.sfdisk"

  sudo su root -c "rm -rf /root/tmp/boot /root/tmp/root"
  sudo su root -c "mkdir -p /root/tmp/boot"
  sudo su root -c "mkdir -p /root/tmp/root"
  sudo su root -c "mkfs.vfat  ${DEVICE}p1"
  sudo su root -c "mkfs.ext4 -F ${DEVICE}p2"

  sudo su root -c "mount ${DEVICE}p1 /root/tmp/boot"
  sudo su root -c "mount ${DEVICE}p2 /root/tmp/root"

  sudo su root -c "bsdtar -xpf `dirname $0`/../../bucket/archlinuxarm-rpi2.tar.gz -C /root/tmp/root"
  sudo su root -c "sync"
  sudo su root -c "mv /root/tmp/root/boot/* /root/tmp/boot"

  sudo umount /root/tmp/boot /root/tmp/root
  sudo su root -c "rm -rf /root/tmp/boot /root/tmp/root"
fi
set +xe
