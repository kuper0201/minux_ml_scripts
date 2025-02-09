#!/bin/bash

pacman -Syu --noconfirm linux-lts-headers lightdm lightdm-gtk-greeter enlightenment nvidia-dkms docker networkmanager nano

# check install_yay.sh
systemctl enable NetworkManager
systemctl enable lightdm
systemctl enable docker
