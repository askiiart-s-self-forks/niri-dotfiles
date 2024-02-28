#!/usr/bin/env bash
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

rm -rf $GIT_DIR/fish
cp -r $HOME/.config/fish/ $GIT_DIR
mv $GIT_DIR/fish/conf.d/universal.fish $GIT_DIR/universal-shellrc.txt

# kitty
rm -rf $GIT_DIR/kitty
cp -r $HOME/.config/kitty/ $GIT_DIR
cp -r $HOME/.config/nvim/ $GIT_DIR
cp -r $HOME/.config/VencordDesktop/VencordDesktop/ $GIT_DIR

# nvim
rm -rf $GIT_DIR/nvim
cp -r $HOME/.config/nvim/ $GIT_DIR

# gpg
rm -rf $GIT_DIR/gnupg
mkdir $GIT_DIR/gnupg
cp $HOME/.gnupg/gpg.conf $GIT_DIR/gnupg/
cp $HOME/.gnupg/gpg-agent.conf $GIT_DIR/gnupg/

# Vesktop
rm -rf $GIT_DIR/VencordDesktop
cp -r $HOME/.config/VencordDesktop/VencordDesktop/ $GIT_DIR

# VS code
rm -rf $GIT_DIR/vscode
mkdir $GIT_DIR/vscode
code --list-extensions >$GIT_DIR/vscode/extensions.txt
cp $HOME/.config/Code/User/keybindings.json $GIT_DIR/vscode/keybindings.json
cp $HOME/.config/Code/User/settings.json $GIT_DIR/vscode/settings.json
cp $HOME/.vscode/argv.json $GIT_DIR/vscode/argv.json

# i3
rm -rf $GIT_DIR/i3
cp -r $HOME/.config/i3/ .

# sway
rm -rf $GIT_DIR/sway
cp -r $HOME/.config/sway/ .

# greetd (for sway)
if [ -d /etc/greetd ]; then
    rm $GIT_DIR/greetd/config.toml
    cp /etc/greetd/config.toml $GIT_DIR/greetd/
fi

# Claws Mail configs
rm -rf $GIT_DIR/claws-mail
mkdir $GIT_DIR/claws-mail
cp $HOME/.claws-mail/clawsrc $GIT_DIR/claws-mail/clawsrc
cp $HOME/.claws-mail/matcherrc $GIT_DIR/claws-mail/matcherrc

# xinitrc
cp $HOME/.xinitrc $GIT_DIR/other-files/.xinitrc
