#!/usr/bin/env bash
# assumes a Fedora Sway base with askiiart/configs/do-everything.bash already run
if [ $(whoami) == "root" ]; then
    echo "Run as a normal user, not root"
    exit 1
fi
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

sudo xbps-install sway Waybar rofi clipman swaybg swaylock slurp grim zenity wdisplays eom nemo pavucontrol brightnessctl gnome-calculator wl-clipboard gedit kanshi wireguard-tools network-manager-applet SwayNotificationCenter

git clone --depth=1 https://github.com/catppuccin/grub
sudo mkdir /usr/share/grub/themes/
sudo cp -r ./grub/src/* /usr/share/grub/themes/
rm -rf grub/
echo 'GRUB_THEME=/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt' | sudo tee /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo -e '#!/bin/sh\nfstrim /' | sudo tee /etc/cron.weekly/fstrim

sudo xbps-install dbus mesa mesa-intel-dri seatd greetd tuigreet
sudo ln -s /etc/sv/NetworkManager/ /var/service/
sudo ln -s /etc/sv/seatd/ /var/service/
sudo usermod -aG _seatd _greeter
sudo ln -s /etc/sv/greetd/ /var/service/

# pipewire setup
sudo xbps-install pipewire wireplumber pipewire-pulse
sudo usermod -aG audio $(whoami)
sudo usermod -aG video $(whoami)
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# bluetooth setup
sudo xbps-install bluez bluez-alsa libspa-bluetooth alsa-pipewire
sudo ln -s /etc/sv/bluetoothd/ /var/service/
mkdir -p /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d
read -p "Set \`MultiProfile = multiple\` in /etc/bluetooth/main.conf" </dev/tty
