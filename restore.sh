#!/usr/bin/env bash
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# fish
rm -rf $HOME/.config/fish/
cp -r $GIT_DIR/fish/ $HOME/.config/
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
rm -rf $HOME/.config/vesktop/
mkdir -p $HOME/.config/vesktop/
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
cp $GIT_DIR/claws-mail/clawsrc $HOME/.claws-mail/clawsrc
cp $GIT_DIR/claws-mail/matcherrc $HOME/.claws-mail/matcherrc

# rofi
rm -rf $HOME/.config/rofi/
mkdir $HOME/.config/rofi/
cp -r $GIT_DIR/rofi $HOME/.config/rofi/

# VS code
mkdir -p $HOME/.config/Code/User/
mkdir -p $HOME/.vscode/
cp $GIT_DIR/vscode/keybindings.json $HOME/.config/Code/User/
cp $GIT_DIR/vscode/settings.json $HOME/.config/Code/User/
for ext in $(cat $GIT_DIR/vscode/extensions.txt); do code --install-extension $ext; done
cp $GIT_DIR/vscode/argv.json $HOME/.vscode/argv.json

echo "restore.sh done!"
