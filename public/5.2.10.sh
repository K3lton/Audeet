#!/bin/bash

# Check if SSH PermitUserEnvironment is disabled
permituserenvironment=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}') " | grep permituserenvironment | awk '{print $2}')
config_permituserenvironment=$(grep -Ei '^\s*PermitUserEnvironment\s+yes' /etc/ssh/sshd_config)

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.10
Title: Ensure SSH PermitUserEnvironment is disabled (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep permituserenvironment"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep permituserenvironment)"
echo

# Rationale
echo "Rationale:"
echo "Disabling PermitUserEnvironment prevents users from setting environment variables through the SSH daemon. This helps prevent potential security bypasses and unauthorized execution of malicious programs."
echo

# Compliance
if [[ "$permituserenvironment" == "no" && -z "$config_permituserenvironment" ]]; then
  echo -e "Compliance: \e[32mPass\e[0m"
  echo "Explanation:"
  echo "PermitUserEnvironment is disabled, which enhances security by preventing users from setting environment variables through SSH."
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "PermitUserEnvironment is enabled. Disabling PermitUserEnvironment helps prevent potential security bypasses and unauthorized execution of malicious programs."
fi

# Prompt user for remediation
#if [[ "$permituserenvironment" != "no" || -n "$config_permituserenvironment" ]]; then
#  read -p "Do you want to remediate the failed compliance check? (y/n): " choice
 # if [[ "$choice" == "y" ]]; then
  #  # Perform remediation steps
   # echo "Performing remediation..."
    
    #echo "Setting PermitUserEnvironment to no in /etc/ssh/sshd_config"
   # sed -i 's/^#*PermitUserEnvironment.*/PermitUserEnvironment no/' /etc/ssh/sshd_config
    
   # echo "PermitUserEnvironment has been disabled."

    #echo "Restarting SSH service..."
   # systemctl restart sshd

   # echo "Remediation completed."
  #fi
#fi

