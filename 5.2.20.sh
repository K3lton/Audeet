#!/bin/bash

# Check the MaxSessions setting
max_sessions=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxsessions | awk '{print $2}')

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.20 
Title: Ensure SSH MaxSessions is set to 10 or less (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i maxsessions"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i maxsessions)"
echo

# Rationale
echo "Rationale:"
echo "The MaxSessions parameter limits the number of open sessions permitted from a given connection, protecting against denial-of-service attacks."
echo

# Compliance
if [[ "$max_sessions" -le 10 ]]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "SSH MaxSessions is configured with a value of 10 or less."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "SSH MaxSessions is not configured with the recommended value. Update the /etc/ssh/sshd_config file to set 'MaxSessions 10'."
fi

# Prompt user for remediation
#if [[ "$max_sessions" -gt 10 ]]; then
 # read -r -p "Do you want to remediate this issue? (y/n): " choice
 # if [[ "$choice" == [yY] ]]; then
 #   echo "Remediating..."
  #  sed -i 's/^\s*MaxSessions.*/MaxSessions 10/' /etc/ssh/sshd_config
   # systemctl reload sshd
    #echo "Remediation completed."
#  else
 #   echo "No changes have been made."
 # fi
#fi

