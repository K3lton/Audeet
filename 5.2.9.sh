#!/bin/bash

# Check if SSH PermitEmptyPasswords is disabled
permitemptypasswords=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}') " | grep permitemptypasswords | awk '{print $2}')
config_permitemptypasswords=$(grep -Ei '^\s*PermitEmptyPasswords\s+yes' /etc/ssh/sshd_config)

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.9
Title: Ensure SSH PermitEmptyPasswords is disabled (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep permitemptypasswords"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep permitemptypasswords)"
echo

# Rationale
echo "Rationale:"
echo "Disabling PermitEmptyPasswords in SSH prevents login to accounts with empty password strings. This reduces the probability of unauthorized access to the system."
echo

# Compliance
if [[ "$permitemptypasswords" == "no" && -z "$config_permitemptypasswords" ]]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "PermitEmptyPasswords is disabled, which enhances security by disallowing remote shell access to accounts with empty passwords."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "PermitEmptyPasswords is enabled. Disabling PermitEmptyPasswords reduces the probability of unauthorized access by disallowing login to accounts with empty password strings."
fi

## Prompt user for remediation
#if [[ "$permitemptypasswords" != "no" || -n "$config_permitemptypasswords" ]]; then
#  read -p "Do you want to remediate the failed compliance check? (y/n): " choice
#  if [[ "$choice" == "y" ]]; then
#    # Perform remediation steps
#    echo "Performing remediation..."
#    
#    echo "Setting PermitEmptyPasswords to no in /etc/ssh/sshd_config"
#    sed -i 's/^#*PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
#    
#    echo "PermitEmptyPasswords has been disabled."

#    echo "Restarting SSH service..."
#    systemctl restart sshd

#    echo "Remediation completed."
#  fi
#fi

