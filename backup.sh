#!/usr/bin/env bash
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

command_exists() { type "$1" &>/dev/null; }

# fish
rm -rf $GIT_DIR/fish
cp -r $HOME/.config/fish/ $GIT_DIR
if command_exists "nixos-rebuild"; then
    rm $GIT_DIR/fish/config.fish
    mv $GIT_DIR/fish/config.fish.backup $GIT_DIR/fish/config.fish
fi

# kitty
rm -rf $GIT_DIR/kitty
cp -r $HOME/.config/kitty/ $GIT_DIR
cp -r $HOME/.config/nvim/ $GIT_DIR

# nvim
rm -rf $GIT_DIR/nvim
cp -r $HOME/.config/nvim/ $GIT_DIR

# gpg
rm -rf $GIT_DIR/gnupg
mkdir $GIT_DIR/gnupg
cp $HOME/.gnupg/gpg.conf $GIT_DIR/gnupg/
cp $HOME/.gnupg/gpg-agent.conf $GIT_DIR/gnupg/

# Vesktop
rm -rf $GIT_DIR/vesktop
cp -r $HOME/.config/vesktop/ $GIT_DIR
rm -rf $GIT_DIR/vesktop/sessionData
rm -rf $GIT_DIR/vesktop/Crashpad
rm -rf $GIT_DIR/vesktop/vencordDist
rm -f $GIT_DIR/vesktop/Singleton*
rm -f $GIT_DIR/vesktop/state.json
rm -f $GIT_DIR/vesktop/.updaterId

# VS code
rm -rf $GIT_DIR/vscode
mkdir $GIT_DIR/vscode
if command_exists "code"; then
    code --list-extensions >$GIT_DIR/vscode/extensions.txt
    cp $HOME/.config/Code/User/keybindings.json $GIT_DIR/vscode/keybindings.json
    cp $HOME/.config/Code/User/settings.json $GIT_DIR/vscode/settings.json
    cp $HOME/.vscode/argv.json $GIT_DIR/vscode/argv.json
elif command_exists "code-oss"; then
    code-oss --list-extensions >$GIT_DIR/vscode/extensions.txt
    cp $HOME/.config/Code/User/keybindings.json $GIT_DIR/vscode/keybindings.json
    cp $HOME/.config/Code/User/settings.json $GIT_DIR/vscode/settings.json
    cp $HOME/.vscode-oss/argv.json $GIT_DIR/vscode/argv.json
fi

# i3
rm -rf $GIT_DIR/i3
cp -r $HOME/.config/i3/ .

# sway
rm -rf $GIT_DIR/sway
cp -r $HOME/.config/sway/ .
outputs=$(swaymsg -t get_outputs)
width=$(echo $outputs | jq -r .[0].modes.[0].width)
height=$(echo $outputs | jq -r .[0].modes.[0].height)
sed -i "s/set \$lockwall \"swaylock -i ~\/\.config\/sway\/backgrounds\/${width}x${height}\.png\"/set \$lockwall \"swaylock -i ~\/\.config\/sway\/backgrounds\/widthxheight\.png\"/g" $GIT_DIR/sway/config

# greetd (for sway)
if [ -d /etc/greetd ]; then
    rm -rf $GIT_DIR/greetd/
    cp -r /etc/greetd/ $GIT_DIR/
fi

# Claws Mail configs
rm -rf $GIT_DIR/claws-mail
mkdir $GIT_DIR/claws-mail
cp $HOME/.claws-mail/clawsrc $GIT_DIR/claws-mail/clawsrc
cp $HOME/.claws-mail/matcherrc $GIT_DIR/claws-mail/matcherrc

# xinitrc
cp $HOME/.xinitrc $GIT_DIR/other-files/.xinitrc

# fix-gamepad.service
if ! command_exists "nixos-rebuild" && command_exists "systemctl"; then
    cp /etc/systemd/system/fix-gamepad.service $GIT_DIR/systemd/fix-gamepad.service
fi

# rofi
rm -rf $GIT_DIR/rofi/
cp -r $HOME/.config/rofi/ $GIT_DIR/rofi/

# fontconfig
rm -rf $GIT_DIR/fontconfig
mkdir $GIT_DIR/fontconfig
cp -r $HOME/.config/fontconfig/conf.d/* $GIT_DIR/fontconfig/

# waybar
rm -rf $GIT_DIR/waybar/
mkdir $GIT_DIR/waybar/
cp -r $HOME/.config/waybar/* $GIT_DIR/waybar/

# sway runner
# TODO: make this work on nix stuff
if command_exists "xbps-install"; then
    cp /usr/bin/sway-runner $GIT_DIR/
    sudo chown $(whoami) sway-runner
fi

# Wezterm
cp ~/.wezterm.lua $GIT_DIR/wezterm.lua