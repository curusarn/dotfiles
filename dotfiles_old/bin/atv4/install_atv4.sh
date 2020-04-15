#!/usr/bin/env bash

cd /tmp
[[ -e xscreensaver-aerial ]] && rm -rf xscreensaver-aerial
git clone https://github.com/curusarn/xscreensaver-aerial.git

echo "Copying scripts"
dstpath=/usr/lib/xscreensaver
sudo cp xscreensaver-aerial/atv4-1080.sh $dstpath/atv4-1080
sudo cp xscreensaver-aerial/atv4-4k.sh $dstpath/atv4-4k
sudo chmod a+x $dstpath/atv4-1080
sudo chmod a+x $dstpath/atv4-4k

echo "Running download script"
sudo ~/bin/atv4/download_atv4_videos.sh
