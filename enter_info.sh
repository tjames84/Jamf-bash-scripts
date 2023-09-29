#!/bin/bash

# Enter_info function with text with confirmation
# takes two arguments that are stings to explain what the user needs to enter
# User will enter text and once entered will be asked to confirm what was entered
# if the user selects No it will loop back and have them enter in the text again until Yes is clicked
# this can be used in a bash script with the input saved as a Variable to be used later in the script.

function enter_info() {
    message="$1"
    message2="$2"
    osascript <<EOF
    set input to ""
    set user_confirmed to False

    repeat until user_confirmed
        set input to text returned of (display dialog "$message" default answer input)
        set confirm_dialog to display dialog "You entered: " & input & "
        $message2" buttons {"Yes", "No"}
        if the button returned of the confirm_dialog is "Yes" then
            set user_confirmed to true
        end if

    end repeat

    return input
EOF
}

enter_info()

exit 0
