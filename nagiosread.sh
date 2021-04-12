#!/bin/bash
if [[ "$1" == "" ]]
then
	echo "Pass the IRIS instance name as the first parameter"
	exit
fi
if [[ "$2" == "" ]]
then
	echo "Pass the IRIS namespace as the second parameter"
	exit
fi
if [[ "$3" == "" ]]
then
	echo "Pass the host as the third parameter"
	exit
fi
if [[ "$4" == "" ]]
then
	echo "Pass the name of the service as the fourth parameter"
	exit
fi
if [[ "$5" == "" ]]
then
	dayte=0
else
	dayte="$5"
fi
if [[ "$6" == "" ]]
then
	dayte1=99999999999
else
	dayte1="$6"
fi
if [[ "$dayte" != "0" ]]
then
	dayte=$(awk '{ print mktime($0) }' <<< "$5")
fi
if [[ "$dayte1" != "99999999999" ]]
then
        dayte1=$(awk '{ print mktime($0) }' <<< "$6")
fi
iriscmd "$1" "$2" "d Read^Nagiosread(\"$3\",\"$4\",\"$dayte\",\"$dayte1\")"
