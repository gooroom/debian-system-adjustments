#! /bin/bash
#
# Check webdav mountpoint and umount it at system shutdown

#- xfce on gooroom-1.0
WINDOW_MANAGER=gnome-flashback

echo "[Gooroom] Starting gooroom-shutdown-trigger.sh"

sleep 1

# Check the webdav mountpoint in pam_mount.conf.xml
# - mountpoint=/home/$USER/WEBStorage
if [ -e /etc/security/pam_mount.conf.xml ]; then
    WEBStorage=$(grep path /etc/security/pam_mount.conf.xml \
                           | awk -F "\"" '{print $6}' \
                           | awk -F "/" '{print $4}')
else
    exit -1;
fi

if [ -n "$WEBStorage" ]; then
    mount | grep $WEBStorage

    echo "[Gooroom] umounting $WEBStorage"
    while [ "$(/usr/bin/pgrep $WINDOW_MANAGER)" == "0" ]
    do
        sleep 1
    done

    # TODO. 
    # Get the actual login id (%USER) with WEBStorage information
    for i in $(mount | grep $WEBStorage | awk '{print $3}') ; do
        fusermount -u $i
    done
else
    exit -1;
fi

exit 0;
