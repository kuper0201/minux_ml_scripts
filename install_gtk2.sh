#!/usr/bin/env bash
set -Eeuo pipefail
# RealVNC's X11 status UI still requires GTK2. Use the signed Arch package
# matching the current AUR version, rather than an unverified binary mirror.
if pacman -T 'gtk2>=2.24.33-5' >/dev/null; then exit 0; fi
package=gtk2-2.24.33-5-x86_64.pkg.tar.zst
base=https://archive.archlinux.org/packages/g/gtk2
tmp=$(mktemp -d /var/tmp/minux-gtk2.XXXXXX)
trap 'rm -rf "$tmp"' EXIT
curl -fL --retry 3 "$base/$package" -o "$tmp/$package"
curl -fL --retry 3 "$base/$package.sig" -o "$tmp/$package.sig"
printf '%s  %s\n' a3472c5d11dc6e443d2dfe9d720c0d9b8d96a376c6cee0b412b847574649e676 "$tmp/$package" | sha256sum -c -
pacman-key --verify "$tmp/$package.sig" "$tmp/$package"
pacman -U --needed --noconfirm "$tmp/$package"
