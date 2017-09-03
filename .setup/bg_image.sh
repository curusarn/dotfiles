#!/bin/bash


img_url="https://imgur.com/download/QlMbZ4B"

img_dir=~/pics/wall
img_name="simplistic-galaxy-planets.jpg"
#img_name="welcome-back-commander.png"
img_path="$img_dir/$img_name"

mkdir -p $img_dir 

/usr/bin/curl -o "$img_path" "$img_url" 

feh --bg-scale "$img_path"

