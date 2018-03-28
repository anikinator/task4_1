#!/bin/bash

# Linux System Info Script

# Output File
OF="task4_1.out"

# HARDWARE Get Info ////////////////////////////////////////////////
CPU=`lscpu | grep "Model name" | unexpand -a | cut -f 2 | tr -s " "`
RAM=`grep MemTotal /proc/meminfo | tr -s " " | cut -f 2 -d " "`

MB=`dmidecode -s baseboard-product-name`
if [ -z "$MB" ]
	then
		MB="Unknown"
fi

SSN=`dmidecode -s system-serial-number`
if [ -z "$SSN" ]
	then
		SSN="Unknown"
fi

# HARDWARE Print to "$OF" /////////////////////////////////////// 
echo "--- Hardware ---" > "$OF"
echo "CPU:$CPU" >> "$OF"
echo "RAM: $RAM" >> "$OF"
echo "Motherboard: $MB" >> "$OF"
echo "System Serial Number: $SSN" >> "$OF"

# SYSTEM Get Info /////////////////////////////////////////////////
#OSDistr=`lsb_release -a | grep Descr | cut -f2`
OSDistr=`cat /etc/os-release | grep PRE | cut -f2 -d "\""`
KernelV=`uname -r`
InstallDate=`lvm lvdisplay | grep Creat | uniq | cut -f8 -d " "`
HN=`hostname`
Uptime=`uptime -p | cut -c 4-`
ProcRun=`ps -e | wc -l`
UsersLogged=`who | wc -l`

# SYSTEM Print to "$OF" ////////////////////////////////////////
echo "--- System ---" >> "$OF"
echo "OS Distribution: $OSDistr" >> "$OF"
echo "Kernel version: $KernelV" >> "$OF"
echo "Installation date: $InstallDate" >> "$OF"
echo "Hostname: $HN" >> "$OF"
echo "Uptime: $Uptime" >> "$OF"
echo "Process running: $ProcRun" >> "$OF"
echo "User logged in: $UsersLogged" >> "$OF"

# NETWORK Print to "$OF" ////////////////////////////////////////
IF4=`ip -4 -br addr show | tr -s " " | cut -f1,3 -d " " | sed s/' '/': '/`
#IF6=`ip -6 -br addr show | tr -s " " | cut -f1,3 -d " " | sed s/' '/': '/`

echo "--- Network ---" >> "$OF"
echo "$IF4" >> "$OF"
#echo "$IF6" >> "$OF"
