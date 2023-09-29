#!/bin/bash

# Password function with verify password
# User will enter in the password twice, the entered password will be hidden when typed.
# If passwords do not match then they will be asked to enter in password again.

function password() {
    osascript <<EOF
    set pass1 to ""
    set pass2 to ""

    repeat until (pass1 is not "") and (pass1 = pass2)
        set pass1 to text returned of (display dialog "Enter admin password:" default answer "" with hidden answer)
        set pass2 to text returned of (display dialog "Confirm admin password:" default answer "" with hidden answer)
        
        if pass1 is not pass2 then
            display dialog "Passwords do not match. Please re-enter password." buttons {"OK"}
        end if
    end repeat

    return pass1
EOF
}

password()

exit 0
