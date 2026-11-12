#!/usr/bin/env bash
set -Eeuo pipefail

pacman -Syu --needed --noconfirm linux-lts-headers lightdm lightdm-gtk-greeter docker networkmanager git base-devel intel-ucode amd-ucode nano
pacman -Syu --needed --noconfirm xorg-server xorg-xinit mesa pciutils xterm network-manager-applet openbox lxqt-panel papirus-icon-theme pcmanfm lxappearance lxappearance-obconf alacritty kvantum kvantum-theme-materia materia-gtk-theme kvantum-qt5 qt5ct qt6ct
pacman -Syu --needed --noconfirm fcitx5 fcitx5-im fcitx5-hangul fcitx5-configtool fcitx5-qt fcitx5-gtk python-cryptography
# A VM or an Intel/AMD-only system does not need the NVIDIA driver.
if lspci -Dn | grep -q '10de:'; then
    pacman -S --needed --noconfirm nvidia-open-dkms nvidia-container-toolkit
    nvidia-ctk runtime configure --runtime=docker
fi

# install micromamba
mamba_dir=$(mktemp -d)
trap 'rm -rf "$mamba_dir"' EXIT
curl --fail --location --retry 3 https://micro.mamba.pm/api/micromamba/linux-64/latest -o "$mamba_dir/micromamba.tar.bz2"
tar -xjf "$mamba_dir/micromamba.tar.bz2" -C "$mamba_dir" bin/micromamba
install -m 755 "$mamba_dir/bin/micromamba" /usr/local/bin/micromamba

mkdir -p /opt/micromamba/envs
chmod 1777 /opt/micromamba
chmod 1777 /opt/micromamba/envs

# check install_yay.sh
systemctl enable NetworkManager
systemctl enable lightdm
systemctl enable docker

pacman -Scc --noconfirm
rm -rf ~/.cache
