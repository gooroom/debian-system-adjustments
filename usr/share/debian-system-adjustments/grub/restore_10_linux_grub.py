#!/usr/bin/python
import os
import commands
import hashlib

try:
    if os.path.exists("/etc/grub.d/10_linux"):
        # Restore upstream /etc/grub/10_linux if it matches the obsolete 10_linux set by earlier adjustments
        md5sum = hashlib.md5(open('/etc/grub.d/10_linux', 'rb').read()).hexdigest()
        if (md5sum == "efdd023801037cd4d6fd3c486813556c" and os.path.exists("/usr/share/debian-system-adjustments/grub/10_linux_grub_2.02~beta2-22")):
            os.system("cp /usr/share/debian-system-adjustments/grub/10_linux_grub_2.02~beta2-22 /etc/grub.d/10_linux")
            print ("Restored /etc/grub.d/10_linux to upstream version 2.02~beta2-22")

        # Update the label in /etc/grub.d/10_linux
        if os.path.exists("/etc/gooroom/info"):
            gooroom_grub_title = commands.getoutput("grep GRUB_TITLE /etc/linuxgooroom/info | awk -F = '{print $2}'")
        else:
            gooroom_grub_title = "Gooroom OS"
        os.system("sed -i -e 's@OS=\"${GRUB_DISTRIBUTOR}\"@OS=\"%s\"@g' /etc/grub.d/10_linux" % gooroom_grub_title)
except Exception, detail:
    print ("Couldn't restore /etc/grub.d/10_linux: %s" % detail)
