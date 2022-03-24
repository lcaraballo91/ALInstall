#!/bin/bash

tzselect
rm /etc/localtime
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
timedatectl set-timezone America/Bogota
timedatectl set-ntp true
hwclock --systohc
clear
timedatectl status
sleep 3

echo "LANG=es_CO.UTF-8" >> /etc/locale.conf
export LANG=es_CO.UTF-8
echo "#" >> /etc/locale.gen
echo "es_CO.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

echo "KEYMAP=us" >> /etc/vconsole.conf
echo "FONT=Lat2-Terminus16" >> /etc/vconsole.conf

echo "ArchLinux" >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	ArchLinux.localdomain	ArchLinux" >> /etc/hosts

clear
passwd
sleep 3

#APPS
pacman -S linux-docs linux-headers intel-ucode efivar gvfs gvfs-nfs ntfs-3g dosfstools dhcpcd netctl dhcpcd iw wpa_supplicant dialog networkmanager nm-connection-editor network-manager-applet modemmanager usb_modeswitch mobile-broadband-provider-info rp-pppoe networkmanager-openconnect networkmanager-pptp networkmanager-vpnc networkmanager-strongswan networkmanager-l2tp network-manager-sstp networkmanager-openvpn
#adb (AUR)
systemctl enable dhcpcd.service
systemctl enable NetworkManager.service
systemctl enable ModemManager.service

#VIDEO INTEL-AMD
pacman -S xorg xorg-apps xorg-server xorg-xset xorg-xinput libinput xf86-input-libinput xf86-video-intel mesa lib32-mesa xf86-video-intel vulkan-intel lib32-vulkan-intel vulkan-radeon lib32-vulkan-radeon amdvlk lib32-amdvlk vulkan-headers vulkan-validation-layers vulkan-tools libva-mesa-driver lib32-libva-mesa-driver 
#amf-amdgpu-pro (AUR)

#AUDIO
pacman -S gst-plugin-pipewire libpipewire02 pipewire pipewire-alsa pipewire-docs pipewire-jack pipewire-media-session pipewire-media-session-docs pipewire-pulse pipewire-v4l2 pipewire-x11-bell pipewire-zeroconf easyeffects helvum lib32-pipewire lib32-pipewire-jack lib32-pipewire-v4l2
#pipewire-jack-dropin (AUR)

useradd -m lcaraballo
passwd lcaraballo
usermod –aG wheel lcaraballo
EDITOR=nano visudo

#OTROS
pacman -S xdg-user-dirs pulseaudio xfce4 xfce4-goodies lightdm lightdm-gtk-greeter mousepad xfwm4 xfwm4-themes xfce4-settings archlinux-xdg-menu xfce4-pulseaudio-plugin sound-theme-smooth xfce4-screenshooter ttf-droid ttf-dejavu
#menulibre (AUR)
systemctl enable lightdm.service

mkinitcpio -P

bootctl install

rm /boot/loader/loader.conf
echo "default		arch.conf" >> /boot/loader/loader.conf
echo "timeout		4" >> /boot/loader/loader.conf
echo "console-mode	max" >> /boot/loader/loader.conf
echo "editor		no" >> /boot/loader/loader.conf

echo "title	Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux	/vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd	/intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd	/initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options	root="UUID=" rw" >> /boot/loader/entries/arch.conf
blkid /dev/sda3 >> /boot/loader/entries/arch.conf
nano /boot/loader/entries/arch.conf

cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-fb.conf
nano /boot/loader/entries/arch-fb.conf
clear
echo "Teclea "exit" seguido de "umount -a" y finalice la instalacion con "reboot""
sleep 10