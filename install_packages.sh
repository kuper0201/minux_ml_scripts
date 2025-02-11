#!/bin/bash

pacman -Syu --needed --noconfirm linux-lts-headers lightdm lightdm-gtk-greeter nvidia-dkms docker networkmanager git base-devel nano
pacman -Syu --needed --noconfirm xterm network-manager-applet openbox lxqt-panel pcmanfm-gtk3 lxappearance alacritty kvantum kvantum-theme-materia materia-gtk-theme kvantum-qt5 qt5ct qt6ct

# check install_yay.sh
systemctl enable NetworkManager
systemctl enable lightdm
systemctl enable docker
