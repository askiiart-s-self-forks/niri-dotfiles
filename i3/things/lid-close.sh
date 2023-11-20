#/usr/bin/env bash

source $HOME/.Xdbus
grep -q closed /proc/acpi/button/lid/LID0/state
if [ $? = 0 ]; then
    i3lock -c 202f56
fi
