#!/bin/bash

_endpoint=$(cat /etc/wireguard/wg0.conf | grep End | awk -F '=' '{print $2}' | awk -F':' '{print $1}'| sed -e 's/ //g')
_mydefaultgw=$(/sbin/ip route | awk '/default/ { print $3 }')

if [[ $_endpoint =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    _ip=$_endpoint
else
  _ip=$(nslookup $_endpoint 1.1.1.1 | awk -F': ' 'NR==6 { print $2 }')
  echo "hostname  resolved to: $_ip"
fi

ip r add ${_ip}/32 via $_mydefaultgw

exit 0
EOF
