#!/bin/bash

if [[ $EUID -ne 0 ]]
then
	echo "This script must be run as root"
	exit 1
fi

# Allocate hugepages
echo 8200 > /proc/sys/vm/nr_hugepages

# Pin CPU cores
cset set -c 0 -s system
cset proc -m -f root -t system
cset proc -k -f root -t system

# If having issues with cpuset
# head /sys/fs/cgroup/cpuset/{,machine.slice/}cpuset.{mems,cpus}
# cat /sys/fs/cgroup/cpuset/cpuset.cpus > /sys/fs/cgroup/cpuset/machine.slice/cpuset.cpus

# Launch vm
virsh start win10

# Sleeploop until vm is done
while [[ $(virsh list --name | grep win10) ]]
do
	sleep 5
done

# Unpin CPU cores
cset set -d system

# Free hugepages
echo 0 > /proc/sys/vm/nr_hugepages

echo "VM stopped"
exit 0
