#!/usr/bin/env bash

cd /tmp
git clone https://github.com/curusarn/xscreensaver-aerial.git

dstpath=/usr/lib/xscreensaver
sudo cp xscreensaver-aerial/atv4-1080.sh $dstpath/atv4-1080
sudo cp xscreensaver-aerial/atv4-4k.sh $dstpath/atv4-4k

sudo ~/bin/atv4/download_atv4_videos.sh
