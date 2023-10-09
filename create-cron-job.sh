#!/usr/bin/env bash
set -e
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

(crontab -l 2>/dev/null; echo "0 * * * * $GIT_DIR/commit.sh") | crontab -