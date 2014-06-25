#!/bin/bash

ls *_PingSummary.txt > lista2

count=0

for i in $(cat lista2)
do
        ((count++))
        recibidos=`cat $i | grep 200 | awk '{print $2}'`
        lost=$((200-$recibidos))
        echo $count $lost

done

