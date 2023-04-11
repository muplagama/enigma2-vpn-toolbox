#!/bin/bash

local_dns=$(cat /etc/resolv.conf | grep nameserver | awk '/nameserver/ {print $2}' | head -n 1)
_endpoint=$(cat /etc/wireguard/wg0.conf | grep End | awk -F '=' '{print $2}' | awk -F':' '{print $1}'| sed -e 's/ //g')
_mydefaultgw=$(/sbin/ip route | awk '/default/ { print $3 }')
ip route add 9.9.9.9 via "$_mydefaultgw"

if [[ $_endpoint =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    _ip=$_endpoint
else
  _ip=$(nslookup -query=A "$_endpoint" 9.9.9.9 | grep Address | sed '/:53$/d' | sed s/^[^0-9]*// | head -n 1)
  echo "hostname  resolved to: $_ip"
fi
ip route del 9.9.9.9

ip route add ${_ip} via $_mydefaultgw

exit 0
