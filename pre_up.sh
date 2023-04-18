#!/bin/bash -x
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
local_dns=$(cat /etc/resolv.conf | grep nameserver | awk '/nameserver/ {print $2}' | head -n 1)

if [ -e /etc/openvpn/*.conf ]; then
        binary=openvpn
elif [ -e /etc/wireguard/*.conf ]; then
        binary=wireguard
fi

if  [ ! -e /etc/$binary/route_default ]; then
        ip route show default | grep default > /etc/$binary/route_default
fi

if  [ -n "$binary" ]; then
        _mydefaultgw=$(grep default /etc/$binary/route_default | awk '/default/ {print $3}')
                if [[ $binary == "openvpn" ]]; then
                        _endpoint=$(grep -i remote /etc/$binary/*.conf | grep -vE 'cert|-random' |awk -F 'remote' '{print$2}' |awk '{print $1}' | head -n 1)
                        ip route add $local_dns via "$_mydefaultgw"
                                if [[ $_endpoint =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                                        _ip=$_endpoint
                                        else
                                        _ip=$(nslookup -query=A "$_endpoint" $local_dns | grep Address | sed '/:53$/d' | sed s/^[^0-9]*// | head -n 1)
                                        echo "hostname  resolved to: $_ip"
                                fi
                          route_set=$(ip route show | grep ${_ip})
                                if [ -z "$route_set" ]; then
                                ip route add ${_ip} via $_mydefaultgw
                                fi
                elif [[ $binary == "wireguard" ]]; then
                        _endpoint=$(grep Endpoint /etc/$binary/*.conf | awk -F'=' '{print $2}' | awk -F# '{gsub(/ /,"");print ($1) }' | awk -F ':' '{print $1}')
                        ip route add $local_dns via "$_mydefaultgw"
                                if [[ $_endpoint =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                                        _ip=$_endpoint
                                        else
                                        _ip=$(nslookup -query=A "$_endpoint" $local_dns | grep Address | sed '/:53$/d' | sed s/^[^0-9]*// | head -n 1)
                                        echo "hostname  resolved to: $_ip"
                                fi
                        route_set=$(ip route show | grep ${_ip})
                                if [ -z "$route_set" ]; then
                                ip route add ${_ip} via $_mydefaultgw
fi
                else
                        echo "no endpoint-config found"
                fi

else
        echo "no binary set"
fi
exit 0
