#!/usr/bin/env bash
# assumes a Fedora Sway base with askiiart/configs/do-everything.bash already run
if [ $(whoami) == "root" ]; then
    echo "Run as a normal user, not root"
    exit 1
fi

command_exists() { type "$1" &>/dev/null; }

GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

if command_exists "dnf"; then
    sudo dnf install clipman swaybg swaylock slurp grim zenity wdisplays eom nemo pavucontrol brightnessctl gnome-calculator wl-clipboard gedit kanshi wireguard-tools iperf3 zstd network-manager-applet -y
    sudo usermod -aG input $(whoami) # so that waybar's keyboard-state works
    sudo dnf copr enable erikreider/SwayNotificationCenter
    sudo dnf install SwayNotificationCenter

    sudo dnf remove Thunar imw foot mpv dunst
    sudo dnf autoremove
elif command_exists "rpm-ostree"; then
    rpm-ostree install clipman zenity wdisplays eom nemo gnome-calculator gedit wireguard-tools -y
    sudo usermod -aG input $(whoami)
    sudo wget https://copr.fedorainfracloud.org/coprs/erikreider/SwayNotificationCenter/repo/fedora-$(rpm -E %fedora)/erikreider-SwayNotificationCenter-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/erikreider-SwayNotificationCenter.repo
    rpm-ostree install SwayNotificationCenter
fi

# make GUI stuff work when running as root (e.g. gparted)
xhost +SI:localuser:root

# Install catppuccin grub theme
#git clone --depth=1 https://github.com/catppuccin/grub
#sudo mkdir /etc/grub-themes/
#sudo cp -r ./grub/src/* /etc/grub-themes/
#rm -rf grub/
#echo 'GRUB_THEME=/etc/grub-themes/catppuccin-mocha-grub-theme/theme.txt' | sudo tee /etc/default/grub
#sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# greetd
#sudo dnf install tuigreet -y
#sudo cp $GIT_DIR/greetd/config.toml /etc/greetd/config.toml
#sudo systemctl disable lightdm.service
#sudo systemctl enable greetd.service

sudo sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config