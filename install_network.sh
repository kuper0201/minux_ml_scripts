#!/bin/bash

pacman -Syu --noconfirm linux-zen-headers networkmanager
# check install_yay.sh
# yay -Syu --noconfirm broadcom-wl-dkms
systemctl enable NetworkManager
