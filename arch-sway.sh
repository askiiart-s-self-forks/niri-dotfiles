#!/usr/bin/env bash
if [ $(whoami) == "root" ]; then
    echo "Run as a normal user, not root"
    exit 1
fi
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# gnome-keyring is for VS Code
yay -S gnome-keyring lxqt-policykit --noconfirm --needed
yay -S waybar rofi swaylock swaybg swaync clipman wdisplays kanshi --noconfirm --needed
yay -S pipewire-pulse pavucontrol blueman bluetooth-support qpwgraph --noconfirm --needed
yay -S brightnessctl wl-clipboard --noconfirm --needed
yay -S eom nemo gnome-calculator gedit wireguard-tools iperf3 zstd network-manager-applet gparted --noconfirm --needed
# for screenshots and color picker
yay -S slurp grim zenity imagemagick --noconfirm --needed

sudo systemctl enable --now NetworkManager

# Install catppuccin grub theme
git clone --depth=1 https://github.com/catppuccin/grub
sudo cp -r ./grub/src/* /usr/share/grub/themes/
rm -rf grub/
sudo sed -i 's/#GRUB_THEME="\/path\/to\/gfxtheme"/GRUB_THEME=\/usr\/share\/grub\/themes\/catppuccin-mocha-grub-theme\/theme.txt/g' /etc/default/grub
sudo sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/g' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# greetd, replaced by ly which should be preinstalled
#yay -S greetd --noconfirm --needed
#sudo cp $GIT_DIR/greetd/config.toml /etc/greetd/config.toml
#sudo systemctl enable greetd.service

# make GUI stuff work when running as root (e.g. gparted)
yay -S xorg-xhost --noconfirm --needed
xhost +SI:localuser:root

# Enable MultiProfile for bluetooth (enables more than just headset-quality support on thing that support many audio profiles)
sudo sed -i 's/#MultiProfile = off/MultiProfile = multiple/g' /etc/bluetooth/main.conf
sudo systemctl restart bluetooth.service
