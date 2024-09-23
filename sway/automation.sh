#!/usr/bin/env bash
# config file still must be done by hand to take into account rotation and stuff, but this makes the backgrounds images themselves
# TODO: add config generation

generate() {
    magick background.png -resize ${1}x${2}! background-${1}x${2}.png
    magick composite -gravity center logo.png background-${1}x${2}.png result-${1}x${2}.png
    cp result-${1}x${2}.png ~/.config/sway/backgrounds/${1}x${2}.png
    rm background-*
    rm result-*
}

outputs=$(swaymsg -t get_outputs)

i=0
while [ "$(echo $outputs | jq -r .[$i])" != "null" ]; do
    width=$(echo $outputs | jq -r .[$i].modes.[0].width)
    height=$(echo $outputs | jq -r .[$i].modes.[0].height)
    generate $width $height
    generate $height $width
    ((i++))
done
