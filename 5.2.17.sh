#!/bin/bash

# Check the SSH banner setting
banner=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep banner | awk '{print $2}')

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.17
Title: Ensure SSH warning banner is configured (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep banner"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep banner)"
echo

# Rationale
echo "Rationale:"
echo "Configuring an SSH warning banner helps communicate the site's policy regarding connection and can assist in the prosecution of trespassers."
echo

# Compliance
if [[ "$banner" == "/etc/issue.net" ]]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "SSH warning banner is correctly configured."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "SSH warning banner is not configured. Update the /etc/ssh/sshd_config file to set 'Banner /etc/issue.net'."
fi

# Prompt user for remediation
#if [[ "$banner" != "/etc/issue.net" ]]; then
 # read -r -p "Do you want to remediate this issue? (y/n): " choice
  #if [[ "$choice" == [yY] ]]; then
  #  echo "Remediating..."
  #  sed -i '/^\s*Banner\s/ d' /etc/ssh/sshd_config
  #  echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
  #  systemctl reload sshd
  #  echo "Remediation completed."
#  else
 #   echo "No changes have been made."
 # fi
#fi

