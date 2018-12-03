#!/bin/bash

# Clean up all demo changes
echo -e "
Cleaning up changes made by demo ...
"

yum remove -y rear genisoimage syslinux
rm -rf /tmp/rescue_system
rm -rf /etc/rear
rm -rf /var/lib/rear
rm -rf /var/log/rear
rm -rf /mnt/tmp/demos
