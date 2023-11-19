#!/usr/bin/env bash
if [ $(whoami) == "root" ]; then
    echo "Run as a normal user, not root"
    exit 1
fi
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# gnome-keyring for VS Code
yay -S gnome-keyring --noconfirm --needed

#sed '/Identifier "libinput touchpad catchall"/a \ \ \ \ \ \ \ \ Option "NaturalScrolling" "True"' /usr/share/X11/xorg.conf.d/40-libinput.conf | sudo tee /usr/share/X11/xorg.conf.d/40-libinput.conf
#sed '/Identifier "libinput touchpad catchall"/a \ \ \ \ \ \ \ \ Option "Tapping" "on"' /usr/share/X11/xorg.conf.d/40-libinput.conf | sudo tee /usr/share/X11/xorg.conf.d/40-libinput.conf
#sed '/Identifier "libinput touchpad catchall"/a \ \ \ \ \ \ \ \ Option "TappingButtonMap" "lrm"' /usr/share/X11/xorg.conf.d/40-libinput.conf | sudo tee /usr/share/X11/xorg.conf.d/40-libinput.conf

yay -S gnome-themes-extra --noconfirm --needed
yay -S j4-dmenu-desktop --noconfirm --needed

# Install catppuccin grub theme
git clone https://github.com/catppuccin/grub
sudo cp -r ./grub/src/* /usr/share/grub/themes/
rm -rf grub/
echo /etc/default/grub | sudo xargs sed -i 's/#GRUB_THEME="\/path\/to\/gfxtheme"/GRUB_THEME=\/usr\/share\/grub\/themes\/catppuccin-mocha-grub-theme\/theme.txt/g'

sudo cp $GIT_DIR/other-files/suspend@.service /etc/systemd/system/
sudo systemctl enable suspend@$(whoami).service