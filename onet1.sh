#!/bin/bash

#  recibe 2 parametros
#	$3 Numero de pings
#	$4 Frecuencia de envio


# este dice al pinging en el cliente que realize $3 pings cada $4 segundos.

# pings al cliente
ssh usuario-grc@10.0.1.175 "bash /home/usuario-grc/pinging.sh $1 $2" 
