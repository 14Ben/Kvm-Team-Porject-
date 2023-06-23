#!/bin/bash
function snoopy() {
	clear
	echo -e "  ,-~~-.___.
 / |  '     \         
(  )         0  
 \_/-, ,----'            
    ====           // 
   /  \-'~;    /~~~(O)
  /  __/~|   /       |     
=(  _____| (_________|\n"
}


function main() {
    snoopy
    echo "+----------------------+"
    echo "|  1NsT4NCe GeNEr4t0R  |"
    echo "+----------------------+"
    echo ""
    echo -n "Instance Name : "
    read instance_name
  
    snoopy
    echo "+--------------------+"
    echo "|      OS IMAGE      |"
    echo "+--------------------+"
    echo "| 1. Ubuntu          |"
    echo "| 2. CentOS 7        |"
    echo "| 3. Cirrus          |"
    echo "+--------------------+"
    echo -n "OS Image : "
    read instance_image
    
    snoopy
    echo "+--------------------+"
    echo "|       FLAVOR       |"
    echo "+--------------------+"
    echo "| 1. M1.Small        |"
    echo "| 2. M1.Medium       |"
    echo "+--------------------+"
    echo -n "Flavor : "
    read instance_flavor
}

main
