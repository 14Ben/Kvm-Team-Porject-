#!/bin/bash
function topBar() {
        clear
	echo "+----------------------+"
        echo "|  1NsT4NCe GeNEr4t0R  |"
        echo "+----------------------+"

	echo -e "  ,-~~-.___."
	echo -e " / |  '     \         It was a dark and stormy night...."
	echo -e "(  )         0              "
	echo -e " \_/-, ,----'            "
	echo -e "    ====           //                     "
	echo -e "   /  \-'~;    /~~~(O)"
	echo -e "  /  __/~|   /       |     "
	echo -e "=(  _____| (_________|   W<"

}

topBar_CONFIRM() {

clear
echo "+-------------------------------+"
echo "|  Virtual Machine Information  |"
echo "+-------------------------------+"
echo ""

IMG_QU=$(mysql kvmdb -N -u root -ptest1234 -e "SELECT CPU,RAM FROM flavorTBL WHERE id = $FLAVOR")
instance_CPU=$(echo $IMG_QU | gawk '{print $1}')
instance_RAM=$(echo $IMG_QU | gawk '{print $2}')
instance_OS=$(mysql kvmdb -N -u root -ptest1234 -e "SELECT OS FROM imgTBL WHERE id = $IMG")
instance_disk=$SIZE
mysql kvmdb -t -u root -ptest1234 -e "SELECT '${NAME}' AS 'VMNAME', ${instance_CPU} AS 'CPU', ${instance_RAM} AS 'RAM', ${SIZE} AS 'DISK SIZE', '${instance_OS}' AS 'OS' "
}

getIMG() {
echo -e "\n"
mysql kvmdb -u root -ptest -e "SELECT * FROM imgTBL"
echo -e "\n"
}

getFLAVOR() {
echo -e "\n"
mysql kvmdb -u root -ptest -e "SELECT * FROM flavorTBL"
echo -e "\n"
}
IMG_MAX=$(mysql kvmdb -u root -ptest1234 -B -N -e "SELECT id  FROM imgTBL ORDER BY id DESC LIMIT 1")
FLAVOR_MAX=$(mysql kvmdb -u root -ptest1234 -B -N -e "SELECT id  FROM flavorTBL ORDER BY id DESC LIMIT 1")
