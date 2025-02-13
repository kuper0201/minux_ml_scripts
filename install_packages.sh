#!/bin/bash

pacman -Syu --needed --noconfirm linux-lts-headers lightdm lightdm-gtk-greeter nvidia-dkms docker networkmanager git base-devel intel-ucode amd-ucode nano
pacman -Syu --needed --noconfirm xterm network-manager-applet openbox obconf lxqt-panel papirus-icon-theme pcmanfm-gtk3 lxappearance alacritty kvantum kvantum-theme-materia materia-gtk-theme kvantum-qt5 qt5ct qt6ct
pacman -Syu --needed --noconfirm fcitx5 fcitx5-im fcitx5-hangul fcitx5-configtool fcitx5-qt fcitx5-gtk python-cryptography nvidia-container-toolkit

# install micromamba
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
chmod +x bin/micromamba
mv bin/micromamba /usr/local/bin/micromamba
rm -rf bin

mkdir -p /opt/micromamba/envs
chmod -R 777 /opt/micromamba

# check install_yay.sh
systemctl enable NetworkManager
systemctl enable lightdm
systemctl enable docker
