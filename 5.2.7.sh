#!/bin/bash

# Check if SSH root login is disabled
permitrootlogin=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitrootlogin | awk '{print $2}')
config_permitrootlogin=$(grep -Ei '^\s*PermitRootLogin\s+no' /etc/ssh/sshd_config)

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.7
Title: Ensure SSH root login is disabled (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep permitrootlogin"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep permitrootlogin)"
echo

# Rationale
echo "Rationale:"
echo "Disabling SSH root login is a security best practice as it reduces the risk of unauthorized access and enhances accountability by requiring system administrators to authenticate using their own individual accounts before escalating to root."
echo

# Compliance
if [[ "$permitrootlogin" == "no" && -n "$config_permitrootlogin" ]]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "SSH root login is disabled, which is recommended for improved security and accountability."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "SSH root login is enabled. Disabling SSH root login helps mitigate the risk of unauthorized access and enhances system security."
fi

## Prompt user for remediation
#if [[ "$permitrootlogin" != "no" || -z "$config_permitrootlogin" ]]; then
#  read -p "Do you want to remediate the failed compliance check? (y/n): " choice
#  if [[ "$choice" == "y" ]]; then
#    # Perform remediation steps
#    echo "Performing remediation..."
#    
#    echo "Setting PermitRootLogin to no in /etc/ssh/sshd_config"
#    sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
#    
#    echo "SSH root login has been disabled."

#    echo "Restarting SSH service..."
#    systemctl restart sshd

#    echo "Remediation completed."
#  fi
#fi

