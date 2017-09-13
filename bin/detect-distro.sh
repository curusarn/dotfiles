#!/bin/bash

distId=`lsb_release -a 2>&1 |grep "Distributor ID" | \
        cut -d':' -f2 |tr -d ' \t'|tr '[:upper:]' '[:lower:]'`

case $distId in
    arch|antergos)
        echo arch
        exit 0
    ;;
    debian|ubuntu)
        echo debian
        exit 0
    ;;
    *)
        # fuck it
        echo UNKNOWN
        exit 1
    ;;
esac
