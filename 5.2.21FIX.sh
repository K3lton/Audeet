#!/bin/bash

# Check the LoginGraceTime setting
login_grace_time=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep logingracetime | awk '{print $2}')

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.21
Title: Ensure SSH LoginGraceTime is set to one minute or less (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep logingracetime"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep logingracetime)"
echo

# Rationale
echo "Rationale:"
echo "The LoginGraceTime parameter specifies the time allowed for successful authentication to the SSH server. Setting it to a low value helps minimize the risk of successful brute force attacks and limits the number of concurrent unauthenticated connections."
echo

# Compliance
if [[ "$login_grace_time" -le 60 ]]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "SSH LoginGraceTime is configured with a value of one minute or less."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "SSH LoginGraceTime is not configured with the recommended value. Update the /etc/ssh/sshd_config file to set 'LoginGraceTime 60'."
fi

# Prompt user for remediation
#if [[ "$login_grace_time" -gt 60 ]]; then
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
 # if [[ "$choice" == [yY] ]]; then
   # echo "Remediating..."
   # sed -i 's/^\s*LoginGraceTime.*/LoginGraceTime 60/' /etc/ssh/sshd_config
   # systemctl reload sshd
  #  echo "Remediation completed."
 # else
  #  echo "No changes have been made."
 # fi
#fi

