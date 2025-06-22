#!/usr/bin/env bash
# only restore niri - for dev purposes
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
command_exists() { type "$1" &>/dev/null; }

# niri conf
rm -rf $HOME/.config/niri
cp -r $GIT_DIR/niri $HOME/.config/
$GIT_DIR/niri/backgrounds/bg-generation.sh

# waybar conf
rm -rf $HOME/.config/waybar/
mkdir $HOME/.config/waybar/
cp -r $GIT_DIR/waybar/* $HOME/.config/waybar/

# user systemd services
if ! command_exists "nixos-rebuild" && command_exists "systemctl"; then
    cp $GIT_DIR/user-systemd/* ~/.config/systemd/user/
fi

## systemd services for niri
# sed for swaybg configuration
main_output=$(niri msg --json outputs | jq 'to_entries | max_by(.value.logical.width) | .key')
width=$(niri msg --json outputs | jq -r ".$main_output.modes.[0].width")
height=$(niri msg --json outputs | jq -r ".$main_output.modes.[0].height")
sed -i "s/widthxheight.png/${width}x${height}.png/g" $HOME/.config/systemd/user/swaybg.service

# actually do systemd stuff
systemctl --user daemon-reload
systemctl --user add-wants niri.service waybar.service
systemctl --user add-wants niri.service swaync.service
systemctl --user add-wants niri.service swaybg.service
