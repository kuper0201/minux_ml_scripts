#!/usr/bin/env bash
set -Eeuo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

./install_packages.sh
./install_yay.sh

dotfiles_dir=$(mktemp -d /root/minux-dotfiles.XXXXXX)
trap 'rm -rf "$dotfiles_dir"' EXIT
git -C "$dotfiles_dir" init -q
git -C "$dotfiles_dir" fetch --depth 1 https://github.com/kuper0201/arch_openbox 8c4741f50447e992f59f623c73e38353c97ee3b1
git -C "$dotfiles_dir" checkout -q --detach FETCH_HEAD
"$dotfiles_dir/install_iso.sh"
./update_user.sh
