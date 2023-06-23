#!/bin/bash

mysql kvmdb -t -uroot -ptest1234 -e "SELECT instanceTBL.id AS 'instance id', instanceTBL.vmname AS 'name', imgTBL.OS, flavorTBL.CPU, flavorTBL.RAM, hostTBL.name AS 'host', volumeTBL.volsize AS 'disk', instanceTBL.username
FROM instanceTBL
	INNER JOIN hostTBL
		ON instanceTBL.hostid=hostTBL.id
	INNER JOIN flavorTBL
		ON instanceTBL.flavor=flavorTBL.id
	INNER JOIN volumeTBL
		ON instanceTBL.volid=volumeTBL.volid
	INNER JOIN imgTBL
		ON instanceTBL.osimg=imgTBL.id
ORDER BY instanceTBL.id DESC
LIMIT 1; "
