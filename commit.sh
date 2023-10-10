#!/usr/bin/env bash
set -e
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd $GIT_DIR
./backup.sh
git add .
git commit -m "Automated backup: $(date --rfc-3339=s --utc)"
git push origin main
