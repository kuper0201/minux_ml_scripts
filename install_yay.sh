#!/bin/bash

# 임시 사용자 계정 정보
USERNAME="user3h3kd09e"

useradd -m -G wheel -s /bin/bash "$USERNAME"
echo "$USERNAME:password" | chpasswd

# sudo 권한 부여
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 임시 사용자로 전환하여 yay 설치
su - "$USERNAME" -c "
    git clone https://aur.archlinux.org/yay.git &&
    cd yay &&
    makepkg -si --noconfirm &&
    cd .. &&
    rm -rf yay &&
    yay -Syu --noconfirm downgrade ttf-nanum realvnc-vnc-server &&
    yay -Scc --noconfirm
"

systemctl enable vncserver-x11-serviced

# 임시 사용자 제거
userdel -r "$USERNAME"

# sudoers 파일 복원
sed -i '/%wheel ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers
