#!/bin/bash

#!/bin/sh
set -xe
if [ $# -lt 2 ]
	then
	echo "Check device name for micro sd card and recal script with it's name as argument"
	sudo fdisk -l
fi

if [ $# -eq 2 ]
	then
	DEVICE=$1
  #wget -O "`dirname $0`/../../bucket/archlinuxarm-rpi2.tar.gz" http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz
  
  sudo umount /root/tmp/boot /root/tmp/root || true
  sudo sfdisk --delete ${DEVICE}
  sudo sfdisk ${DEVICE} < "`dirname $0`/disk.sfdisk"

  sudo su root -c "rm -rf /root/tmp/boot /root/tmp/root"
  sudo su root -c "mkdir -p /root/tmp/boot"
  sudo su root -c "mkdir -p /root/tmp/root"
  sudo su root -c "mkfs.vfat  ${DEVICE}1"
  sudo su root -c "mkfs.ext4 -F ${DEVICE}2"

  sudo su root -c "mount ${DEVICE}1 /root/tmp/boot"
  sudo su root -c "mount ${DEVICE}2 /root/tmp/root"

  sudo su root -c "bsdtar -xpf $2 -C /root/tmp/root"
  sudo su root -c "sync"
  sudo su root -c "mv /root/tmp/root/boot/* /root/tmp/boot"

#  sudo umount /root/tmp/boot /root/tmp/root
#  sudo su root -c "rm -rf /root/tmp/boot /root/tmp/root"
fi
