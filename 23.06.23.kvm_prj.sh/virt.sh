#!/bin/bash

IMG=$1
PASSWD=$2
SIZE=`echo "${3}G"`
vol_Name=$4
HOSTIP=$5
os=$(mysql kvmdb -u root -ptest1234 -N -se "SELECT OS FROM imgTBL WHERE id=${IMG}")

########## IMG virt_builder ##########

ssh $HOSTIP "virt-builder ${os} --format qcow2 \
--size ${SIZE} -o /shared/${vol_Name} \
--root-password password:${PASSWD}"
