#!/bin/bash

host1="192.168.1.101"
host2="192.168.1.102"

host1_cpuidle=`ssh $host1 "sar 1 1 | tail -n 1" | gawk '{print $8}'`
host2_cpuidle=`ssh $host2 "sar 1 1 | tail -n 1" | gawk '{print $8}'`

host1_cpuusage=`echo "scale=2; 100 - $host1_cpuidle" | bc`
host2_cpuusage=`echo "scale=2; 100 - $host2_cpuidle" | bc`

host1_intcpu=`echo "$host1_cpuusage * 100" | bc | gawk -F. '{print $1}'`
host2_intcpu=`echo "$host2_cpuusage * 100" | bc | gawk -F. '{print $1}'`

if [ $host1_intcpu -ge $host2_intcpu ]
then
	echo $host1
else
	echo $host2
fi
