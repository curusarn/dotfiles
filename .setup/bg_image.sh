#!/bin/bash


img_url="http://img.myconfinedspace.com/wp-content/uploads/2014/09/welcome-back-commander.png"

img_dir=~/pics/wall
img_name="welcome-back-commander.png"
img_path="$img_dir/$img_name"

mkdir -p $img_dir 

/usr/bin/curl -o "$img_path" "$img_url" 

feh --bg-scale "$img_path"

