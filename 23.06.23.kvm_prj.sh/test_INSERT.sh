#!/bin/bash

## virt-build
### disk-size 커스터마이징
### user & passwd 커스터마이징

NAME="testvm"
IMG="1"
FLAVOR="1"
host_ip="192.168.1.101"
vol_Name="testVolume"
SIZE="15"
USER="testUser"
PASSWD="testPASSWD"

# volumeTBL에 넣기
mysql kvmdb -u root -ptest1234 -e "INSERT INTO volumeTBL VALUES (NULL, '${vol_Name}', ${SIZE})"

# userTBL에 넣기
mysql kvmdb -u root -ptest1234 -e "INSERT INTO userTBL VALUES ('${USER}', '${PASSWD}')"

# instanceTBL에 넣기
HOST_ID=$(mysql kvmdb -u root -ptest1234 -N -se "SELECT id FROM hostTBL WHERE ip='${host_ip}'")
VOLUME_ID=$(mysql kvmdb -u root -ptest1234 -N -se "SELECT volid FROM volumeTBL WHERE volname='${vol_Name}'")
mysql kvmdb -u root -ptest1234 -e "INSERT INTO instanceTBL VALUES (NULL, '${NAME}', ${IMG}, ${FLAVOR}, ${HOST_ID}, ${VOLUME_ID}, '${USER}')"
