#!/bin/sh
swaylock -f -i ~/.config/sway/background.png
systemctl suspend
iwctl station wlan0 connect Wifey
