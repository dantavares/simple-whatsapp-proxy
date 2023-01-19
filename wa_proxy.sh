#!/bin/sh

WA_PORT='5222'

LOCAL_IP=$(ip addr | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
WA_IP=$(dig chat.cdn.whatsapp.net +short)

if [ "$WA_IP" != "" ]
then
	echo "Whatsapp server ip: $WA_IP, using port: $WA_PORT"
	echo "Local IP: $LOCAL_IP"
	iptables -t nat -A PREROUTING -p tcp --dport $WA_PORT -j DNAT --to-destination $WA_IP:$WA_PORT
	iptables -A POSTROUTING -t nat -p tcp --dport $WA_PORT -j SNAT --to-source $LOCAL_IP
	sysctl net.ipv4.ip_forward=1
else
	echo "Error getting whatsapp server ip!"
fi
