#!/bin/bash


URL="http://img.myconfinedspace.com/wp-content/uploads/2014/09/welcome-back-commander.png"

DIR=~/pics/wall
IMG="welcome-back-commander.png"
PATH="$DIR/$IMG"

mkdir -p $DIR 2>/dev/null

curl -o "$PATH" "$URL" 

feg --bg-scale "$PATH"

