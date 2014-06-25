#!/bin/bash

#borramos los ficheros para almacenaje temporal
for fileExist in fileList tiempos newTiempos nueva 
        do
        if [ -f $fileExist ]; then
                rm $fileExist
        fi
        done


# listamos los ficheros con un hand en su nombre
ls -lash *.txt | awk '{print $10}' | grep "_Hand" >> fileList
outcome=0

# listamos los ficheros que nos interesan
for i in $(cat fileList)
do
# i=20140403_1331_HandoverTest.txt
        rm tiempos newTiempos
        ((outcome++))
 #poner titulo
 #echo $i >> tiempos

 #obtenemos solo la columnas de identificacion del mensaje y el tiempo. Eliminamos las lineas en blanco
awk '{print $5, $7}' "$i" | awk -F '=' '{print $2, $3}' | awk -F 'time' '{print $1, $2}' | awk 'NF' >> tiempos

 #cambiamos el separador decimal de puntos a comas
 cat tiempos | sed -e 's/\./,/g' > newTiempos$outcome.tp

count=1
lost=0
FILE=newTiempos$outcome.tp
OUTFILE=outcome$outcome.xls
VAR_OLD=0

while read line;
        do
                #echo "$line"
                tempVar=$(echo $line | awk '{print $1}')
                timesaved=$(echo $line | awk '{print $2}')

                echo $tempVar $timesaved $count

                if [ $count = $tempVar ]; then
                        #echo "iguales"
                        echo $tempVar $timesaved >> $OUTFILE
                else
                        echo $count "n/a" >> $OUTFILE

                        while [ $count -lt $tempVar ]
                        do
                                ((count++))
                                ((lost++))
                                echo $count "n/a" >> $OUTFILE
                                #((count++))
                        done
                        #echo "distintos"

                #Buscamos valores duplicados en los mensajes trasmitidos
                if [ $tempVar = $VAR_OLD ]; then
                        echo "duplicated message identification"
                else
                        ((count++))
                fi
                VAR_OLD=$tempVar

        done < $FILE
done


