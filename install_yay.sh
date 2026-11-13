#!/usr/bin/env bash
set -Eeuo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
"$script_dir/install_gtk2.sh"
build_user="minux-aur-$$"
build_home=$(mktemp -d /var/tmp/minux-aur.XXXXXX)
sudoers_file="/etc/sudoers.d/$build_user"
cleanup() {
    rm -f "$sudoers_file"
    if id "$build_user" >/dev/null 2>&1; then
        userdel -r "$build_user" >/dev/null 2>&1 || true
    fi
    rm -rf "$build_home"
}
trap cleanup EXIT
useradd --system --home-dir "$build_home" --shell /bin/bash "$build_user"
cp -a "$script_dir/packages/realvnc-vnc-server" "$build_home/"
chown -R "$build_user:$(id -gn "$build_user")" "$build_home"
install -d -m 750 /etc/sudoers.d
printf '%s ALL=(root) NOPASSWD: /usr/bin/pacman\n' "$build_user" > "$sudoers_file"
chmod 440 "$sudoers_file"
visudo -cf "$sudoers_file"

# yay-bin uses the upstream release binary and avoids compiling Go in the installer.
# HOME must expand in the builder shell, not the root shell.
# shellcheck disable=SC2016
su - "$build_user" -c '
    set -Eeuo pipefail
    git clone --depth 1 https://aur.archlinux.org/yay-bin.git "$HOME/yay-bin"
    cd "$HOME/yay-bin"
    makepkg -si --noconfirm
    yay -S --needed --noconfirm downgrade ttf-nanum
    cd "$HOME/realvnc-vnc-server"
    makepkg -si --noconfirm
'
systemctl enable vncserver-x11-serviced
