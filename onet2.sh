#!/bin/bash

#  recibe 4 parametros
#	$1 IP Address
#	$2 Tiempo en segundos a apagar la interfaz desde el inicio de la prueba
#

ROUTER=$1
TIMER=$2

echo "waiting $2 seconds"
sleep "$2"
echo "shutting down wifi interface in $1"
#ssh root@"$ROUTER" "uci set wireless.radio0.disabled=1; uci commit wireless && wifi"
ssh root@"$ROUTER" "bash updown.sh DOWN"
