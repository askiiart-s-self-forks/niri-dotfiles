#!/usr/bin/env sh
set -e
xset s dpms 0 0 0
i3lock --color 202f56 --ignore-empty-password --show-failed-attempts --nofork
xset s off -dpms
