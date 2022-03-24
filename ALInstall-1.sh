#!/bin/bash

loadkeys us
ping -c 20 archlinux.org

ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
timedatectl set-timezone America/Bogota
timedatectl set-ntp true
hwclock --systohc

clear
timedatectl status
sleep 3

(echo g; echo n; echo ; echo ; echo +1024M; echo t; echo 1; echo n; echo 2; echo ; echo +2048M; echo t; echo 2; echo 19; echo n; echo 3; echo ; echo ; echo t; echo 3; echo 20; echo w) | sudo fdisk /dev/sda

mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt/
mkdir /mnt/boot/
mount /dev/sda1 /mnt/boot/
swapon /dev/sda2

clear
lsblk /dev/sda
sleep 3

reflector --verbose --country "United States" --protocol https --latest 12 --sort rate --save /etc/pacman.d/mirrorlist
sleep 3

nano /etc/pacman.d/mirrorlist
pacstrap /mnt base linux linux-firmware

#mkinitcpio-firmware (AUR)

genfstab -U /mnt >> /mnt/etc/fstab
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
clear
cat /mnt/etc/fstab
sleep 3