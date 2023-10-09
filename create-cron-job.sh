#!/usr/bin/env bash
set -e
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
crontab -l | grep -q "* * * * * $GIT_DIR/commit.sh" || (crontab -l 2>/dev/null; echo "* * * * * $GIT_DIR/commit.sh") | crontab -