#!/usr/bin/env bash
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# only restore niri - for dev purposes
rm -rf $HOME/.config/niri
cp -r $GIT_DIR/niri $HOME/.config/
systemctl --user add-wants niri.service waybar.service
