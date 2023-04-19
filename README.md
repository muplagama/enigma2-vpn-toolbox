# enigma2-vpn-toolbox

### Requirements:
- a wireguard configuration
      or 
- a openvpn configuation & username / password

### Installation:
- connect to CLI
- proof installation of bash & curl (eg. opkg install bash curl)
- grap the commands and execute

```
wget -qO /tmp/enigma-vpn-installer https://raw.githubusercontent.com/muplagama/enigma2-vpn-toolbox/main/enigma-vpn-installer 
```
```
chmod +x /tmp/enigma-vpn-installer; /tmp/enigma-vpn-installer
```

```
+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+
|E|n|i|g|m|a|2| |N|e|t|w|o|r|k| |T|o|o|l|b|o|x|
+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+
                                   by tnl.ninja
                                               
WireGuard installation possible!
OpenVPN installation possible!

##### Menu #####

1) WireGuard install                     // opkg based systems 
2) OpenVPN install                       // opkg based systems

0) Exit

choose an Option: 

```
### post installation

```
to control use the "vpn" command

vpn start wireguard|openvpn                     // to start a vpn connection (killswitch can be start oprional)
vpn stop wireguard|openvpn                      // to stop a vpn connection     
vpn enable wireguard|openvpn                    // to enable autostart
vpn disable wireguard|openvpn                   // to stop vpn connection and disable autostart
vpn remove wireguard|openvpn                    // to stop vpn connection and remove complete vpn installation
vpn newconf wireguard|openvpn                   // to replace or renew vpn config files
vpn status                                      // to check vpn status now
vpn setdns                                      // to change dns settings (hardcoded) eg. cloudflare, quad9, google, adguard 


```

### Donate: ###
BTC: 1JgfTbJtRUTHPo2W56KmjmLvsZkg7MvrVk
