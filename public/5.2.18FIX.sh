#!/bin/bash

#needs fixing

# Check the MaxAuthTries setting
max_auth_tries=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep maxauthtries | awk '{print $2}')

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.18
Title: Ensure SSH MaxAuthTries is set to 4 or less (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep maxauthtries"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep maxauthtries)"
echo

# Rationale
echo "Rationale:"
echo "Setting MaxAuthTries to a low number reduces the risk of successful brute force attacks against the SSH server."
echo

# Compliance
if [[ "$max_auth_tries" -le 4 ]]; then
  echo -e "Compliance: \e[32mPass\e[0m"
  echo "Explanation:"
  echo "SSH MaxAuthTries is set to 4 or less."
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "SSH MaxAuthTries is set to a value greater than 4. Update the /etc/ssh/sshd_config file to set 'MaxAuthTries 4'."
fi

# Prompt user for remediation
#if [[ "$max_auth_tries" -gt 4 ]]; then
 # read -r -p "Do you want to remediate this issue? (y/n): " choice
  #if [[ "$choice" == [yY] ]]; then
   # echo "Remediating..."
    #sed -i 's/^\s*MaxAuthTries.*/MaxAuthTries 4/' /etc/ssh/sshd_config
    #systemctl reload sshd
    #echo "Remediation completed."
#  else
 #   echo "No changes have been made."
 # fi
#fi

