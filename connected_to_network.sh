#!/bin/bash

# this was created for a extenstion attribute in Jamf Pro 

# Function to verify network access by pinging a network resource (e.g., a server within the domain)

function verify_network_access {

    network_resource="8.8.8.8"  # Replace with the network resource you want to ping
    
    if ping -c 1 "$network_resource" &> /dev/null; 
	then
        echo "connected"  # Network access is successful
    else
        echo "not connected"  # Network access failed
    fi
}

is_connected=$(verify_network_access)

echo "<result>$is_connected</result>"
