#!/bin/bash

loggedInUser=$(stat -f%Su /dev/console)
userUID=$(id -u ${loggedInUser})

ComputerName=`/bin/launchctl asuser "$userUID" sudo -iu $loggedInUser /usr/bin/osascript <<EOT
tell application "System Events"
    activate
    set ComputerName to text returned of (display dialog "Please Input Computer Name" default answer "" with icon 2)
end tell
EOT`

#Set New Computer Name
echo $ComputerName
sudo -S scutil --set HostName $ComputerName
sudo -S scutil --set LocalHostName $ComputerName
sudo -S scutil --set ComputerName $ComputerName

#Rename "Machintosh HD" to the computer host name
echo "Renaming Hard Drive"
sudo -S diskutil rename / $ComputerName
sudo -S diskutil rename /System/Volumes/Data "$ComputerName - Data"

echo ""
echo "Rename Successful : $(HostName) "
echo ""

sudo jamf recon

COUNTER=1

while [ $COUNTER -lt 11 ]; 
do
	echo The counter is $COUNTER
	sleep 1
	let COUNTER=COUNTER+1 
done

# The message you want to display
message="Please restart the computer"

# The title of the pop-up window
title="Restart Computer"

# The button label
button_label="Restart"

# Display the pop-up window with the restart button
osascript -e 'display dialog "'"$message"'" buttons {"'"$button_label"'"} default button 1 with title "'"$title"'"' -e 'if button returned of result = "'"$button_label"'" then tell app "System Events" to restart'


# sudo -S shutdown -r now
