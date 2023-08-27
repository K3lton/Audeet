#!/bin/bash

# Check if /etc/at.deny exists
if [[ -f "/etc/at.deny" ]]; then
  at_deny_exists=true
else
  at_deny_exists=false
fi

# Check permissions on /etc/at.allow
at_allow_permissions=$(stat -c "%a" /etc/at.allow)
at_allow_owner=$(stat -c "%U:%G" /etc/at.allow)

# Title
echo "Section: 5.1.9
Title: Ensure at is restricted to authorized users (Automated)"

# Evidence
echo "Evidence:"
echo "Command: stat /etc/at.deny"
if [[ $at_deny_exists == true ]]; then
  echo "Output: File exists"
else
  echo "Output: File does not exist"
fi
echo "Command: stat /etc/at.allow"
echo "Output:"
echo "$(stat /etc/at.allow)"
echo

# Rationale
echo "Rationale:"
echo "The /etc/at.allow file allows specific users to use the at service. By controlling access through an allow list, the policy of restricting at job scheduling to authorized users is enforced. Managing an allow list is easier and less error-prone than managing a deny list. It reduces the risk of inadvertently granting at job scheduling privileges to unauthorized users."
echo

# Remediation
if [[ $at_deny_exists == true || $at_allow_permissions != "640" || $at_allow_owner != "root:root" ]]; then
  echo "Remediation:"
  if [[ $at_deny_exists == true ]]; then
    echo "- Remove the /etc/at.deny file"
  fi
  echo "- Create the /etc/at.allow file"
  echo "- Set permissions and ownership for /etc/at.allow"
  echo
fi

# Compliance
if [[ $at_deny_exists == false ]] && [[ $at_allow_permissions == "640" ]] && [[ $at_allow_owner == "root:root" ]]; then
  echo -e "Compliance: \e[32mPass\e[0m"
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  if [[ $at_deny_exists == true ]]; then
    echo "The /etc/at.deny file exists. It is recommended to remove the file to restrict at to authorized users."
  fi
  if [[ $at_allow_permissions != "640" ]]; then
    echo "The permissions on /etc/at.allow are not set to 640. It is recommended to set the permissions to 640 to restrict access to read and write for the owner, and read for the group."
  fi
  if [[ $at_allow_owner != "root:root" ]]; then
    echo "The owner of /etc/at.allow is not set to root:root. It is recommended to set the owner to root:root to ensure proper ownership."
  fi
fi

## Perform automated remediation if compliance failed
#if [[ $at_deny_exists == true || $at_allow_permissions != "640" || $at_allow_owner != "root:root" ]]; then
 # read -p "Do you want to automatically remediate the failed compliance checks? (y/n): " choice
  #if [[ $choice == "y" ]]; then
   # echo "Performing automated remediation..."
  
    #if [[ $at_deny_exists == true ]]; then
     # echo "- Removing the /etc/at.deny file..."
      #rm /etc/at.deny
      #echo "  Done."
   # fi
  
   # echo "- Creating the /etc/at.allow file..."
   # touch /etc/at.allow
   # echo "  Done."
  
   # echo "- Setting permissions and ownership for /etc/at.allow..."
   # chmod 640 /etc/at.allow
   # chown root:root /etc/at.allow
   # echo "  Done."
  
   # echo "Automated remediation completed."
#  fi
#fi

