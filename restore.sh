#!/usr/bin/env bash
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

rm -rf $HOME/.config/fish/
rm -rf $HOME/.config/kitty/
rm -rf $HOME/.config/nvim/
rm -f $HOME/.gnupg/gpg-agent.conf
rm -f $HOME/.gnupg/gpg.conf
rm -rf $HOME/.config/VencordDesktop/VencordDesktop/
rm -rf $HOME/.config/i3

cp -r $GIT_DIR/fish/ $HOME/.config/
cp $GIT_DIR/universal-shellrc.txt $HOME/.config/fish/conf.d/universal.fish
sudo mkdir /usr/share/fonts/meslolgs
sudo cp $GIT_DIR/other-files/*.ttf /usr/share/fonts/meslolgs/

cp -r $GIT_DIR/kitty/ $HOME/.config/
cp -r $GIT_DIR/nvim/ $HOME/.config/

mkdir $HOME/.gnupg
cp -r $GIT_DIR/gnupg/* $HOME/.gnupg/

mkdir -p $HOME/.config/VencordDesktop/VencordDesktop/
cp -r $GIT_DIR/VencordDesktop/* $HOME/.config/VencordDesktop/VencordDesktop/

mkdir -p $HOME/.config/Code/User/
cp $GIT_DIR/vscode/keybindings.json $HOME/.config/Code/User/
cp $GIT_DIR/vscode/settings.json $HOME/.config/Code/User/
#for ext in $(cat $GIT_DIR/vscode/extensions.txt); do code --install-extension $ext; done

cp -r $GIT_DIR/i3 $HOME/.config/