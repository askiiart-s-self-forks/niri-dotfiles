#!/usr/bin/env bash
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

command_exists() { type "$1" &>/dev/null; }

cd $GIT_DIR/distro-specific-scripts/
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
