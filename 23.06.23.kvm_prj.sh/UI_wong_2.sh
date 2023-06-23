#!/bin/bash
. /MGMT/Utils.sh

while [ 1 ]
do
topBar
echo -e "\n"
echo -n "Instance Name : "
read INPUT

################### 가상머신 이름 입력
while [ 1 ]
do
	if [ ${#INPUT} -le 10  ] && [ ${#INPUT} -ge 1  ]
	then	
			NAME=${INPUT}
		break
	fi
	topBar
	echo -e "\n"
	echo -e "Wrong! Please Input correct instance name!\n"
	echo -n "Insatnce Name : "
	read INPUT
done
################### 가상 머신 이미지 선택

topBar
getIMG
echo -n "Please Select Base OS Image : "
read INPUT

while [ 1  ]
do
	if [ $INPUT -le $IMG_MAX  ] && [ $INPUT -ge 1  ]
	then
		IMG=$INPUT
		break
	fi
	topBar
	getIMG
	echo "Wrong! Please Select correct OS Base Image!\n"
	echo -n "Please Select Base OS Image : "
	read INPUT
done

##################### 가상 머신 Flavor 선택
topBar
getFLAVOR
echo -n "Please Select the flavor : "
read INPUT

while [ 1 ]
do
        if [ $INPUT -le $FLAVOR_MAX  ] && [ $INPUT -ge 1  ]
        then
                FLAVOR=$INPUT
                break
        fi
        topBar
        getFLAVOR
        echo "Wrong! Please Select correct flavor!\n"
        echo -n "Please Select Base OS Image :  "
        read INPUT
done

##################### 가상 머신 Disk Size 선택
topBar
echo -e "\n\n"
echo -n " Please input disk size [5(G) ~ 20(G)]: "
read INPUT

while [ 1 ]
do
        if [ $INPUT -le 20  ] && [ $INPUT -ge 5  ]
        then
                SIZE=$INPUT
                break
        fi
        topBar
	echo -e "\n"
        echo "Wrong! please input correct disk size!"
	echo -n " Please input disk size [5(G) ~ 20(G)]: "
        read INPUT
done

##################### 가상 머신 USER 선택
topBar
echo -e "\n"
echo -n "Please input default user when VM is installed (MAX 10 length): "
read INPUT
while [ 1 ]
do
        if [ ${#INPUT} -le 10  ] && [ ${#INPUT} -ge 1  ]
        then
                        USER=${INPUT}
                break
        fi
        topBar
	echo -e "\n"
        echo "Wrong! Please input correct Username!"
        echo -n "Please input default user when VM is installed (MAX 10 length): "
        read INPUT
done

##################### PASSWD 선택
echo -e "\n"
echo -n "Please input Root Password (MIN 1): "
read -s INPUT
while [ 1 ]
do
        if [ ${#INPUT} -ge 1  ]
        then
                        PASSWD=${INPUT}
                break
        fi
        topBar
	echo -e "\n"
        echo "Password is nothing. Please input password!"
	echo -n "Please input Root Password (MIN 1): "
        read -s INPUT
done

topBar_CONFIRM

echo "Did you want to install Virtual Machine?? [Y/N] "
echo -n "If you want to reconfigure input [r|R] "
read -n 1 INPUT
echo -e "\n"
case $INPUT in
        Y | y) 
                break;;
        N | n) exit 1 ;;
        R | r) continue ;;
        * ) exit 99 ;;
esac

done
##########################################3

random=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | sed 1q`
vol_Name=`echo "${NAME}_${random}.img"`
HOSTIP=`/root/wong/cpu_check.sh`
#virt.sh에IMG변수 전달 <<-----------230623_1033_14Ben
./virt.sh $IMG $PASSWD $SIZE $vol_Name $HOSTIP
./virt-install.sh $HOSTIP $NAME $FLAVOR $vol_Name

################ DB INSERT

# volumeTBL에 넣기
mysql kvmdb -u root -ptest1234 -e "INSERT INTO volumeTBL VALUES (NULL, '${vol_Name}', ${SIZE})"

# userTBL에 넣기
mysql kvmdb -u root -ptest1234 -e "INSERT INTO userTBL VALUES ('${USER}', '${PASSWD}')"

# instanceTBL에 넣기
HOST_ID=$(mysql kvmdb -u root -ptest1234 -N -se "SELECT id FROM hostTBL WHERE ip='${HOSTIP}'")
VOLUME_ID=$(mysql kvmdb -u root -ptest1234 -N -se "SELECT volid FROM volumeTBL WHERE volname='${vol_Name}'")
mysql kvmdb -u root -ptest1234 -e "INSERT INTO instanceTBL VALUES (NULL, '${NAME}', ${IMG}, ${FLAVOR}, ${HOST_ID}, ${VOLUME_ID}, '${USER}')"

./chae.sh
