#!/bin/bash
HOSTIP=$1
VMNAME=$2
FLAVORID=$3
VOLNAME=$4

FLAVOR_Q=$(mysql -u root -ptest1234 kvmdb -N -se "SELECT cpu,ram FROM flavorTBL where id=${FLAVORID}")
CPU=$(echo $FLAVOR_Q | gawk '{print $1}')
RAM=$(echo $FLAVOR_Q | gawk '{print $2}')

ssh $HOSTIP "virt-install --name ${VMNAME} --vcpus $CPU --ram $RAM \
--network bridge:vswitch0,model=virtio,virtualport_type=openvswitch \
--network bridge:vswitch10,model=virtio,virtualport_type=openvswitch \
--disk /shared/${VOLNAME} \
--graphics none \
--import
"
