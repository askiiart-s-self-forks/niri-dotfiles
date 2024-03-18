#!/usr/bin/env bash
shopt -s extglob
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
cp $GIT_DIR/universal-shellrc.txt $HOME/.config/fish/conf.d/universal.fish
fish -c 'fisher update'

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

# Install catppuccin GTK theme
# TODO: Add automatic catppuccin GTK updates - would be easy, but no version numbering once install, need to figure that out
ctp_version="v0.7.1"
variant="Catppuccin-Mocha-Standard-Mauve-Dark"
if [ ! -e ~/.themes/$variant ] && ! command_exists "nixos-rebuild"; then
    mkdir -p ~/.themes &&
        curl -L https://github.com/catppuccin/gtk/releases/download/$ctp_version/$variant.zip -o ~/.themes/catppuccin.zip &&
        unzip ~/.themes/catppuccin.zip -d ~/.themes/ &&
        rm -rf ~/.themes/catppuccin.zip

    # gtk 4
    rm -rf $HOME/.config/gtk-4.0
    ln -sf "${HOME}/.themes/${variant}/gtk-4.0/" "${HOME}/.config/gtk-4.0"
fi

# VS code
mkdir -p $HOME/.config/Code/User/
mkdir -p $HOME/.vscode/
cp $GIT_DIR/vscode/keybindings.json $HOME/.config/Code/User/
cp $GIT_DIR/vscode/settings.json $HOME/.config/Code/User/
for ext in $(cat $GIT_DIR/vscode/extensions.txt); do code --install-extension $ext; done
cp $GIT_DIR/vscode/argv.json $HOME/.vscode/argv.json

echo "restore.sh done!"
