#!/bin/bash

filename=$(date +"%Y%m%d_%H%M")

HOST="10.0.1.190"
COUNT=100
FRECUENCY=0.2

#resfile="/result.res"
resfile=$filename"_HandoverTest.txt"

echo $resfile
tempfile=$(mktemp)
rm -f $resfile

echo "making "$COUNT" pings to "$HOST 
ping -c $COUNT $HOST -i $FRECUENCY >> $tempfile 2>&1

line=$(cat $tempfile | grep received)
#5 packets transmitted, 5 received, 0% packet loss, time 4007ms

_transmitted=$(echo $line | awk '{print $1}')
_received=$(echo $line | awk -F "transmitted, "  '{print $2}' | awk '{print $1}' )
_loosing=$(echo $line | awk -F "received, " '{print $2}' | awk -F "%" '{print $1}')

echo $line
echo $_transmitted $_received $_loosing

echo -n "$_transmitted $_received $_loosing " >> $resfile
rm -f $tempfile
