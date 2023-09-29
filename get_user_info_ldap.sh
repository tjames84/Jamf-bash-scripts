#!/bin/bash

# LDAP server URL
LDAP_SERVER="ldap://ldap.example.com"

# LDAP bind DN and password
LDAP_BIND_DN="CN=username_here,OU=ou_here,DC=name,DC=example,DC=com"
LDAP_PASSWORD="your_password_here"

# LDAP search base DN
SEARCH_BASE="ou=example_internal,ou=example_people,dc=name,dc=example,dc=com"

# Get the short name and full name of the currently logged in user
loggedInUser=$(stat -f%Su /dev/console)

current_user=$(ls -l /dev/console | awk '{ print $3 }')

# Enter the username to search for
username="$current_user"

user_info=$(ldapsearch -x -H "$LDAP_SERVER" -D "$LDAP_BIND_DN" -w "$LDAP_PASSWORD" "(sAMAccountName=${username})") -b "$SEARCH_BASE"

# Use ldapsearch to retrieve user information from Active Directory
# user_info=$(ldapsearch -x -h "${domain}" -b "${ldap_base}" "(sAMAccountName=${username})")
# echo "$user_info"

# Extract the user's full name, email address, and phone number from the LDAP search results
full_name=$(echo "${user_info}" | grep "^name: " | awk -F ": " '{print $2}')
email=$(echo "${user_info}" | grep "^mail: " | awk -F ": " '{print $2}')
phone=$(echo "${user_info}" | grep "^telephoneNumber: " | awk -F ": " '{print $2}')
department=$(echo "${user_info}" | awk -F ': ' '/^department:/ {print $2}')
office=$(echo "${user_info}" | awk -F ': ' '/^physicalDeliveryOfficeName:/ {print $2}')

building=$(echo "$office" | cut -d'-' -f1 | tr -d '[:space:]')
room=$(echo "$office" | cut -d'-' -f2 | tr -d '[:space:]')

# Print the user's information
echo "Full Name: ${full_name}"
echo "Email: ${email}"
echo "Phone Number: ${phone}"
echo "Department: ${department}"
echo "building: ${building}"
echo "Room: ${room}"

# Update user information in Jamf Pro
#jamf recon -endUsername "$current_user" -realname "$full_name" -email "$email"  -department "$department" -building "$building" -room "$room"

exit 0
