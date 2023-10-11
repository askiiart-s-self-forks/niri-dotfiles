#!/usr/bin/env bash
set -e
GIT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
(crontab -l 2>/dev/null; echo "* * * * * $GIT_DIR/commit.sh") | crontab -

############################################################################
# NOTE: commit signing must be turned off, or not require any interaction. #
############################################################################