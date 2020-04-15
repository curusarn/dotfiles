#!/bin/bash

# load default screenlayout if set
# aka run `~/.screenlayout/default.sh` if (is executable and) exists

[[ -x ~/.screenlayout/default.sh ]] && ~/.screenlayout/default.sh

