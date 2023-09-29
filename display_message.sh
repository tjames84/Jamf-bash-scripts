#!/bin/bash

# display_message function
# takes 2 arguments that informs what has happened and adds a title to the pop up window
# has default options if no value is given

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

# display_message( $message1 $message2 $time )
display_message()

exit 0
