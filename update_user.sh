#!/usr/bin/env bash
set -Eeuo pipefail

# Preserve executable bits and private-file permissions from the skeleton.
while IFS=: read -r username _ uid _ _ user_home _; do
    [[ "$uid" =~ ^[0-9]+$ ]] || continue
    (( uid >= 1000 && uid < 65534 )) || continue
    [[ "$user_home" == /home/* && -d "$user_home" ]] || continue
    home_mode=$(stat -c %a "$user_home")
    cp -a /etc/skel/. "$user_home/"
    chown -R "$username:$(id -gn "$username")" "$user_home"
    chmod "$home_mode" "$user_home"
done < <(getent passwd)
