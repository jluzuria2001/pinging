#!/bin/bash

filename=$(date +"%Y%m%d_%H%M")

HOST="10.0.1.190"

if [ $# -gt 0 ]; then
        COUNT=$1
        FRECUENCY=$2
else
        echo "Without arguments, using default values."
        COUNT=100
        FRECUENCY=0.2
fi

#resfile="/result.res"
resfile=$filename"_HandoverTest.txt"
summaryFile=$filename"_PingSummary.txt"

echo $resfile
tempfile=$(mktemp)
rm -f $resfile

# Is associated to an AP?
iw dev wlan0 link | grep "Connected"

ap1=`iwconfig wlan0 | grep "Mode" | awk -F "Point: " '{print$2}'`
echo $ap1 >> $summaryFile

echo "making $COUNT pings to $HOST every $FRECUENCY seconds"

#ping -c $COUNT $HOST -i $FRECUENCY >> $tempfile 2>&1
ping -c "$COUNT" "$HOST" -i "$FRECUENCY" >> $resfile

ap2=`iwconfig wlan0 | grep "Mode" | awk -F "Point: " '{print$2}'`
echo $ap2 >> $summaryFile

line=$(cat $resfile | grep received)
#5 packets transmitted, 5 received, 0% packet loss, time 4007ms

_transmitted=$(echo $line | awk '{print $1}')
_received=$(echo $line | awk -F "transmitted, "  '{print $2}' | awk '{print $1}' )
_loosing=$(echo $line | awk -F "received, " '{print $2}' | awk -F "%" '{print $1}')

echo $line
#echo $_transmitted $_received $_loosing

echo "---statistics---" >> $summaryFile
echo "$_transmitted $_received $_loosing " >> $summaryFile
#echo "\n" >> $summaryFile

if [ "$ap1" == "$ap2" ]; then
        echo "No se ha efectuado cambio de AP"
        echo "No se ha efectuado cambio de AP" >> $summaryFile
else
        echo "Se ha producido un cambio de AP"
        echo "Se ha producido un cambio de AP" >> $summaryFile
fi
