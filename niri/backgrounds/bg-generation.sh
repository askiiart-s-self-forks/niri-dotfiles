#!/usr/bin/env bash
# config file still must be done by hand to take into account rotation and stuff, but this makes the backgrounds images themselves
# TODO: add config generation
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd $SCRIPT_DIR

generate() {
    magick background.png -resize ${1}x${2}! background-${1}x${2}.png
    magick composite -gravity center logo.png background-${1}x${2}.png result-${1}x${2}.png
    mv result-${1}x${2}.png ${1}x${2}.png
    rm background-*
}

mkdir ~/.config/niri/backgrounds/
# assumes the display with the greatest width is the main output
main_output=$(niri msg --json outputs | jq 'to_entries | max_by(.value.width) | .key')
width=$(niri msg --json outputs | jq -r ".'$output'.modes.[0].width")
height=$(niri msg --json outputs | jq -r ".'$first_output'.modes.[0].height")
generate $width $height

# TODO: per-display background generation
# (currently no background since don't know how to do per-display, just blank)