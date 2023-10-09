#!/usr/bin/env bash
set -e
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd $GIT_DIR
git add .
git commit -m "Automated backup: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main
