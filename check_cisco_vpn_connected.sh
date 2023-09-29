#!/bin/bash

function display_message() {

    message1="${1:-Operation has completed.}"
    message2="${2:-Complete}"
    time="${3:-15}"

    osascript <<EOF
    tell application "System Events"
        display dialog "$message1" buttons {"Ok"} with title "$message2" giving up after "$time"
    end tell
EOF
}

# Check if Cisco AnyConnect VPN is active
vpn_status=`sudo /opt/cisco/anyconnect/bin/vpn status | grep ">> state:" | head -1`

if [[  $vpn_status =~ "Connected" ]]; then
    display_message "Cisco AnyConnect VPN is active."

    # Get the IP address from the VPN client
    vpn_ip=$(ifconfig | grep -A 1 'utun[0-9]' | awk '/inet / {print $2}')
    
    if [[  $vpn_status =~ "Connected" ]]; then
        display_message "VPN IP address: $vpn_ip"
    else
        display_message "Unable to retrieve VPN IP address."
    fi
else
    display_message "Cisco AnyConnect VPN is not active."
fi


# # Check if Cisco AnyConnect VPN is active
vpn_status=`sudo /opt/cisco/anyconnect/bin/vpn status | grep ">> state:" | head -1`

if [[  $vpn_status =~ "Connected" ]]; then
    echo "Cisco AnyConnect VPN is active."

    # Get the IP address from the VPN client
    vpn_ip=$(ifconfig | grep -A 1 'utun[0-9]' | awk '/inet / {print $2}')
    
    if [[  $vpn_status =~ "Connected" ]]; then
        echo "VPN IP address: $vpn_ip"
    else
        echo "Unable to retrieve VPN IP address."
    fi
else
    echo "Cisco AnyConnect VPN is not active."
fi

exit 0
