#!/bin/bash
RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

iface=$(ip -o link show | awk -F': ' '{print $2}' | grep wg; ip -o link show | awk -F': ' '{print $2}' | grep tun)
        if  [ -n "$iface" ]; then
                vpn_country=$(curl -s ipinfo.io/country)
                vpn_city=$(curl -s ipinfo.io/city)
                echo -e "${GREEN}// VPN Interface $iface is up //${NC}"
                echo -e "${GREEN}// Location: $vpn_city/$vpn_country //${NC}"
                echo ""
                echo "//info for more details type: vpn status"
        else
                echo -e "${RED}VPN Interface is down${NC}"
        fi
