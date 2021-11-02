#!/bin/bash
#
# USB key daemon watcher
#
# This script looks for an specific USB pen drive attached to the machine every 10 secs. No matter the files inside even if formatted. Used by DPC operators,
# just plug the key and the system halts. You can change the action, so instead of halting, you can perform a backup, or whatever. Obviously you have to
# replace the serial numbers and vendors with yours.
# 
# You also need the beep command line tool. If you don't want, just comment the line
#

usb_dev=/proc/bus/usb/devices
serials="AA04012700009522 AA04012700009590 AA04012700009274 AA04012700009487 AA04012700009492 AA04012700009617 AA04012700008853 AA04012700009480 AA04012700009687"
vendor="P:  Vendor=090c ProdID=1000 Rev=11.00"
while [ 1 ] ; do
 serial=`cat $usb_dev | grep "$vendor" -A3 | tr -s " " | cut -d "=" -f2 | cut -d " " -f7`
 if [ "$serial" != "" ] ; then
  if [ "`echo $serials | grep $serial`" != "" ] ; then
   beep -f 1000 -n -f 2000 -n -f 1500
   logger system halted by usb key
   halt
   exit 0
  fi
 fi
 sleep 10;
done

