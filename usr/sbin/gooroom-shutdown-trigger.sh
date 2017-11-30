#! /bin/bash

echo "[Gooroom] Starting gooroom-shutdown-trigger.sh"

sleep 1

## Umount webdav
mount | grep WEBStorage

if [ $? = 0 ] ; then
    echo "[Gooroom] umounting WEBStorage"
    while [ "$(/usr/bin/pgrep xfce)" == "0" ]
    do
        sleep 1
    done

    # TODO.
    sleep 1
    for i in $(mount | grep WEBStorage | awk '{print $3}') ; do
        fusermount -u $i
    done
fi
