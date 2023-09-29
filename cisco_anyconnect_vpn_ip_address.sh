#!/bin/bash

# Check if Cisco AnyConnect VPN is active
vpn_status=`sudo /opt/cisco/anyconnect/bin/vpn status | grep ">> state:" | head -1`

if [[  $vpn_status =~ "Connected" ]]; then
    echo "Cisco AnyConnect VPN is active."

    # Get the IP address from the VPN client
    vpn_ip=$(ifconfig | grep -A 1 'utun[0-9]' | awk '/inet / {print $2}')
    
    if [[  $vpn_status =~ "Connected" ]]; then
        echo "$vpn_ip"
    else
        echo "Not Connect to VPN"
    fi
else
    echo "Not Connect to VPN"
fi

exit 0
