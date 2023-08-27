#!/bin/bash

# Title
echo "Section: 5.2.4
Title: Ensure SSH access is limited (Automated)"

# Audit
audit_output=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -Pi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$')
config_output=$(grep -rPi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$' /etc/ssh/sshd_config*)

# Evidence
echo "Evidence:"
echo "Command: /usr/sbin/sshd -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -Pi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$'"
echo "Output:"
echo "$audit_output"
echo
echo "Command: grep -rPi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$' /etc/ssh/sshd_config*"
echo "Output:"
echo "$config_output"
echo

# Rationale
echo "Rationale:"
echo "Limiting SSH access to specific users and groups helps ensure that only authorized users can remotely access the system."
echo

# Compliance
if [[ -n "$audit_output" || -n "$config_output" ]]; then
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "The SSH access configuration allows either specific users or groups to access the system. It should be reviewed to ensure that only authorized users or groups are granted SSH access."
else
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "The SSH access configuration restricts SSH access to specific users and groups, ensuring that only authorized users can remotely access the system."
fi

# Prompt user for automated remediation
#if [[ -n "$audit_output" || -n "$config_output" ]]; then
#  read -p "Do you want to automatically remediate the failed compliance checks? (y/n): " choice
#  if [[ $choice == "y" ]]; then
#    # Perform automated remediation steps
#    echo "Performing automated remediation..."

#    # Update the SSH access configuration
#    echo "Please edit the /etc/ssh/sshd_config file or an included configuration file to set one or more of the parameters as follows:"
#    echo "- AllowUsers <userlist>"
#    echo "- AllowGroups <grouplist>"
#    echo "- DenyUsers <userlist>"
#    echo "- DenyGroups <grouplist>"

#    echo "Automated remediation completed."
#  fi
#fi

