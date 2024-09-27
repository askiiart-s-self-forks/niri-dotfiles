#!/usr/bin/env bash

command_exists() { type "$1" &>/dev/null; }

cd distro-specific-scripts/
distro=""

if command_exists "pacman"; then
    distro="arch"
elif command_exists "dnf" || command_exists "rpm-ostree"; then
    distro="fedora"
elif command_exists "xbps-install"; then
    distro="void"
else
    exit
fi

./${distro}-${XDG_CURRENT_DESKTOP}.sh
