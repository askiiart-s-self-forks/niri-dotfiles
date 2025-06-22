#!/usr/bin/env bash
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
command_exists() { type "$1" &>/dev/null; }

# only restore niri - for dev purposes
rm -rf $HOME/.config/niri
cp -r $GIT_DIR/niri $HOME/.config/
systemctl --user add-wants niri.service waybar.service
systemctl --user add-wants niri.service swaync.service

rm -rf $HOME/.config/waybar/
mkdir $HOME/.config/waybar/
cp -r $GIT_DIR/waybar/* $HOME/.config/waybar/
