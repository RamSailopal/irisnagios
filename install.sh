#!/bin/bash
if [[ "$1" == "" ]]
then
	echo "Please pass the IRIS instance name as the first parameter"
	exit
fi
if [[ "$2" == "" ]]
then
	echo "Please pass the IRIS namespace as the second parameter"
	exit
fi
cp irisnagios /usr/local/bin
cp nagiosread.sh /usr/local/bin/nagiosread
iriscmd "$1" "$2" "w \$SYSTEM.OBJ.Load(\"$(pwd)/nagiosread.ro\",\"ck\")"
