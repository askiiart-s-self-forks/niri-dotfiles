#!/usr/bin/env bash
# assumes a Fedora Sway base with askiiart/configs/do-everything.bash already run
if [ $(whoami) == "root" ]; then
    echo "Run as a normal user, not root"
    exit 1
fi
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

sudo dnf install i3status clipman swaybg swaylock slurp grim zenity wdisplays eom nemo pavucontrol light gnome-calculator wl-clipboard gedit kanshi -y
# also has waybar, which is unused, but maybe i'll use it idk
sudo dnf remove Thunar imw unst foot mpv

# Install catppuccin grub theme
git clone --depth=1 https://github.com/catppuccin/grub
sudo mkdir /usr/share/grub/themes/
sudo cp -r ./grub/src/* /usr/share/grub/themes/
rm -rf grub/
echo 'GRUB_THEME=/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt' | sudo tee /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg



# greetd
#sudo dnf install tuigreet -y
#sudo cp $GIT_DIR/greetd/config.toml /etc/greetd/config.toml
#sudo systemctl disable lightdm.service
#sudo systemctl enable greetd.service
