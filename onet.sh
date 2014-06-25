#!/bin/bash

#  recibe 4 parametros
#	$1 IP Address  (e.g., 10.0.1.1)
#	$2 Tiempo en segundos a apagar la interfaz desde el inicio de la prueba  (e.g., 10)
#	$3 Numero de pings  (e.g., 100)
#	$4 Frecuencia de envio  (e.g., 0.2)
#	$5 La dirección MAC del AP al que tiene que estar conectado inicialmente  (e.g., 00:0C:42:66:51:93)
#			para simplificar utilizamos la palabras Alix o Tplink para conectarse al router respectivo
#
# el comando completo seria: [$./init.sh 10.0.1.1 10 200 0.2 Tplink]
#     El mismo que apagaria el AP con dirección 10.0.1.1 despues de 10 segundos
#     haciendo 200 pings desde el cliente al server cada 0.2 segundos
#     el cliente estaria inicialmente conectado a Tplink


StartAll() {
        echo "1"
        ssh root@10.0.1.2 "bash updown.sh UP"
	sleep 5
        echo "2"
        ssh root@10.0.1.1 "bash updown.sh UP"
}
UpAlix() {
        echo "Starting up Alix"
	ssh root@10.0.1.2 "bash updown.sh UP"
}
DownAlix() {
        echo "Shutting down Alix"
	ssh root@10.0.1.2 "bash updown.sh DOWN"
}
UpTplink() {
        echo "Starting up Tplink"
        ssh root@10.0.1.1 "bash updown.sh UP"
}
DownTplink() {
        echo "Shutting down Tplink"
        ssh root@10.0.1.1 "bash updown.sh DOWN"
}
StopAll() {
#        ssh root@10.0.1.1 "uci set wireless.radio0.disabled=1; uci commit wireless && wifi"
#        ssh root@10.0.1.2 "uci set wireless.radio0.disabled=1; uci commit wireless && wifi"
	echo "stop all"
}

###------------------------------void(main)

c=1
while [ $c -le 10 ]
do
	echo "Welcome to $c test"

# 1. Encender los AP's
#echo "Turning up the AP's"
#StartAll

# 1.1 Conectarse al AP inicial
#ssh usuario-grc@10.0.1.175 "bash /home/usuario-grc/connectap.sh $5"

# 2." $3" pings al cliente cada "$4" segundos
bash /home/jorlu/onet1.sh $3 $4 &

# 3. apagar el AP "$1" despues de "$2" segundos
bash /home/jorlu/onet2.sh $1 $2

# 4. Encender los AP's - reconfigurar
#StartAll
sleep 45
DownTplink
sleep 10
StartAll
sleep 15
echo "End of test "
(( c++ ))
done
