#!/usr/bin/env bash
shopt -s extglob # used for not copying config.fish if it's nixos, and for librewolf
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

command_exists() { type "$1" &>/dev/null; }

# fish
rm -rf $HOME/.config/fish/
if command_exists "nixos-rebuild"; then
    cd $GIT_DIR/fish/
    mkdir $HOME/.config/fish/
    cp -r !(config.fish) $HOME/.config/fish/
    cd -
else
    cp -r $GIT_DIR/fish/ $HOME/.config/
fi
fish -c 'fisher update'
fish -c "tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Dark --show_time='24-hour format' --classic_prompt_separators=Vertical --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Many icons' --transient=No"

# kitty
rm -rf $HOME/.config/kitty/
cp -r $GIT_DIR/kitty/ $HOME/.config/

# nvim
rm -rf $HOME/.config/nvim/
cp -r $GIT_DIR/nvim/ $HOME/.config/

# gpg
rm -f $HOME/.gnupg/gpg-agent.conf
rm -f $HOME/.gnupg/gpg.conf
mkdir $HOME/.gnupg
cp -r $GIT_DIR/gnupg/* $HOME/.gnupg/

# vesktop
mkdir $HOME/.config/vesktop
cp -r $GIT_DIR/vesktop/* $HOME/.config/vesktop/

# i3
rm -rf $HOME/.config/i3
cp -r $GIT_DIR/i3 $HOME/.config/

# sway
rm -rf $HOME/.config/sway
cp -r $GIT_DIR/sway $HOME/.config/
outputs=$(swaymsg -t get_outputs)
width=$(echo $outputs | jq -r .[0].modes.[0].width)
height=$(echo $outputs | jq -r .[0].modes.[0].height)
sed -i "s/set \$lockwall \"swaylock -i ~\/\.config\/sway\/backgrounds\/widthxheight\.png\"/set \$lockwall \"swaylock -i ~\/\.config\/sway\/backgrounds\/${width}x${height}\.png\"/g" $HOME/.config/sway/config

# niri
rm -rf $HOME/.config/niri
cp -r $GIT_DIR/niri $HOME/.config/
systemctl --user add-wants niri.service waybar.service
systemctl --user add-wants niri.service swaync.service
exec $GIT_DIR/niri/backgrounds/bg-generation.sh

# greetd (for sway)
if [ -d /etc/greetd ]; then
    sudo rm /etc/greetd/config.toml
    sudo cp $GIT_DIR/greetd/config.toml /etc/greetd/config.toml
fi

# xinitrc
cp $GIT_DIR/other-files/.xinitrc $HOME/.xinitrc

# Claws Mail configs
mkdir $HOME/.claws-mail/
cp $GIT_DIR/claws-mail/clawsrc $HOME/.claws-mail/clawsrc
cp $GIT_DIR/claws-mail/matcherrc $HOME/.claws-mail/matcherrc

# rofi
rm -rf $HOME/.config/rofi/
cp -r $GIT_DIR/rofi $HOME/.config/rofi/

# GTK dark theme
mkdir ~/.config/gtk-3.0
echo -e "[Settings]\ngtk-application-prefer-dark-theme = true" >~/.config/gtk-3.0/settings.ini
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

# fix-gamepad.service
if ! command_exists "nixos-rebuild" && command_exists "systemctl"; then
    sudo cp $GIT_DIR/systemd/fix-gamepad.service /etc/systemd/system/
    #sudo systemctl enable --now fix-gamepad.service
fi

# user systemd services
if ! command_exists "nixos-rebuild" && command_exists "systemctl"; then
    cp $GIT_DIR/user-systemd/* ~/.config/systemd/user/
fi

# fontconfig
rm -rf $HOME/.config/fontconfig/conf.d/
mkdir -p $HOME/.config/fontconfig/conf.d/
cp -r $GIT_DIR/fontconfig/* $HOME/.config/fontconfig/conf.d/

# waybar
# i have no idea why this is here and my waybar config is in my home dir anyways, but only for this script, not the niri one??? but whatever
if ! command_exists "dnf"; then
    echo hi
    rm -rf $HOME/.config/waybar/
    mkdir $HOME/.config/waybar/
    cp -r $GIT_DIR/waybar/* $HOME/.config/waybar/
fi

# sway-runner
# TODO: make this work on nix too
if command_exists "xbps-install"; then
    sudo cp $GIT_DIR/sway-runner /usr/bin/sway-runner
    sudo chown root /usr/bin/sway-runner
fi

# Librewolf
# to make sure a profile exists to apply this to
if [ $(find ~/.librewolf -mindepth 1 -maxdepth 1 -type d -name "*.*" | wc -l) -eq 0 ]; then
    librewolf &
    sleep 1
    pkill librewolf
    sleep 1
fi

cd ~/.librewolf
for dir in $(find . -mindepth 1 -maxdepth 1 -type d -name "*.*"); do
    cp -r $GIT_DIR/librewolf/!(prefs.js) $dir
    while read line; do
        if ! grep -q "$line" $dir/prefs.js; then
            echo "$line" | tee -a $dir/prefs.js
        fi
    done <$GIT_DIR/librewolf/prefs.js
done

# WezTerm
wezterm shell-completion --shell fish >~/.config/fish/completions/wezterm.fish
cp $GIT_DIR/wezterm.lua ~/.wezterm.lua
gsettings set org.cinnamon.desktop.default-applications.terminal exec wezterm-gui

# Git config
cp $GIT_DIR/gitconfig ~/.gitconfig

# VS code
mkdir -p $HOME/.config/Code/User/
mkdir -p $HOME/.vscode/
cp $GIT_DIR/vscode/keybindings.json $HOME/.config/Code/User/
cp $GIT_DIR/vscode/settings.json $HOME/.config/Code/User/
if command_exists "code"; then
    code $(for ext in $(cat $GIT_DIR/vscode/extensions.txt); do echo -n "--install-extension $ext "; done)
    cp $GIT_DIR/vscode/argv.json $HOME/.vscode/argv.json
elif command_exists "code-oss"; then
    code-oss $(for ext in $(cat $GIT_DIR/vscode/extensions.txt); do echo -n "--install-extension $ext "; done)
    cp $GIT_DIR/vscode/argv.json $HOME/.vscode-oss/argv.json
fi

echo "restore.sh done!"

# default applications
xdg-settings set default-web-browser librewolf.desktop
