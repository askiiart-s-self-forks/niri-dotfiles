#!/usr/bin/env bash
# assumes a Fedora Sway base with askiiart/configs/do-everything.bash already run
if [ $(whoami) == "root" ]; then
    echo "Run as a normal user, not root"
    exit 1
fi
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

sudo xbps-install clipman swaybg swaylock slurp grim zenity wdisplays eom nemo pavucontrol light gnome-calculator wl-clipboard gedit kanshi wireguard-tools network-manager-applet

git clone --depth=1 https://github.com/catppuccin/grub
sudo mkdir /usr/share/grub/themes/
sudo cp -r ./grub/src/* /usr/share/grub/themes/
rm -rf grub/
echo 'GRUB_THEME=/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt' | sudo tee /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
