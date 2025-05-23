#!/bin/bash

#monitoring the free fs space disk
FU=$(df -h | egrep -v "Filesystem|tmpfs" | grep sda6 | awk '{print $5}' |tr -d %)

TO="gangulyriju123@gmail.com"

if [[ $FU -ge 6 ]]
then
	echo "Warning, disk space is low - $FU %"  | mail -s "Disk SPACE ALERT!" $TO
else
	echo "All good"
fi
