#!/bin/bash

# Title
echo "Section: 5.3.7 
Title: Ensure access to the su command is restricted (Automated)"

# Evidence
echo "Evidence:"
echo "Command: grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su"
echo "Output:"
grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su
echo

# Rationale
echo "Rationale:"
echo "Restricting access to the su command and using sudo instead provides better control over privileged access and improved logging and auditing capabilities."
echo

# Compliance
su_config=$(grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su)
if [[ -n "$su_config" ]]; then
  group_name=$(echo "$su_config" | awk -F'group=' '{print $2}' | awk '{print $1}')
  echo "Compliance: Pass"
  echo "Explanation:"
  echo "The access to the su command is restricted to the group: $group_name"
  
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "The access to the su command is not restricted."

  # Verify empty group
  #group_users=$(grep "^$group_name:" /etc/group | awk -F':' '{print $4}')
  #if [[ -z "$group_users" ]]; then
  #  echo "The group $group_name does not contain any users."
  #else
   # echo "The group $group_name contains users: $group_users"
#    # Prompt user for remediation
#    read -r -p "Do you want to remediate this issue? (y/n): " choice
#    if [[ "$choice" == [yY] ]]; then
#      echo "Remediating..."
#      sudo groupdel "$group_name"
#      echo "Remediation completed."
#    else
#      echo "No changes have been made."
#    fi
#  fi

  #echo -e "Compliance: Fail"
  #echo "Explanation:"
  #echo "The access to the su command is not restricted."


#  # Prompt user for remediation
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
#  if [[ "$choice" == [yY] ]]; then
#    echo "Remediating..."
#    sudo groupadd sugroup
#    sudo sed -i '/^#.*pam_wheel.so/s/^#//' /etc/pam.d/su
#    sudo sed -i 's/^.*pam_wheel.so.*/auth required pam_wheel.so use_uid group=sugroup/' /etc/pam.d/su
#    echo "Remediation completed."
#  else
#    echo "No changes have been made."
#  fi
fi

