#!/usr/bin/env bash
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# fish
rm -rf $HOME/.config/fish/
cp -r $GIT_DIR/fish/ $HOME/.config/
cp $GIT_DIR/universal-shellrc.txt $HOME/.config/fish/conf.d/universal.fish

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
rm -rf $HOME/.config/VencordDesktop/VencordDesktop/
mkdir -p $HOME/.config/VencordDesktop/VencordDesktop/
cp -r $GIT_DIR/VencordDesktop/* $HOME/.config/VencordDesktop/VencordDesktop/

# VS code
mkdir -p $HOME/.config/Code/User/
cp $GIT_DIR/vscode/keybindings.json $HOME/.config/Code/User/
cp $GIT_DIR/vscode/settings.json $HOME/.config/Code/User/
#for ext in $(cat $GIT_DIR/vscode/extensions.txt); do code --install-extension $ext; done

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

echo "restore.sh done!"