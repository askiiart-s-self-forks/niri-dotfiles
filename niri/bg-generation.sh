#!/usr/bin/env bash
# config file still must be done by hand to take into account rotation and stuff, but this makes the backgrounds images themselves
# TODO: add config generation

generate() {
    magick background.png -resize ${1}x${2}! background-${1}x${2}.png
    magick composite -gravity center logo.png background-${1}x${2}.png result-${1}x${2}.png
    cp result-${1}x${2}.png ~/.config/niri/backgrounds/${1}x${2}.png
    rm background-*
    rm result-*
}

first_output=$(niri msg --json outputs | jq "$(jq 'keys_unsorted | .[0]')")
width=$(niri msg --json outputs | jq -r ".'$first_output'.modes.[0].width)
height=$(niri msg --json outputs | jq -r ".'$first_output'.modes.[0].height)
generate $width $height

# TODO: per-display background generation
# (currently no background since don't know how to do per-display, just blank)