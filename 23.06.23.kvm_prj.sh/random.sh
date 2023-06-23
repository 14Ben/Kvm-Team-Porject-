#!/bin/bash

instance_name=`echo $NAME`
random=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | sed 1q`

vol_Name=`echo "${instance_name}_${random}.img"`

echo $vol_Name
