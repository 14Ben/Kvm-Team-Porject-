#!/bin/bash

IMG=$1
#IMG=1

os=$(mysql kvmdb -u root -ptest1234 -N -se "SELECT OS FROM imgTBL WHERE id=${IMG}")

echo "$os"

