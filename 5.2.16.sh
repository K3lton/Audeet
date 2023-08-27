#!/bin/bash

# Check the SSH AllowTcpForwarding setting
allow_tcp_forwarding=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i allowtcpforwarding | awk '{print $2}')

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.16 
Title: Ensure SSH AllowTcpForwarding is disabled (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i allowtcpforwarding"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i allowtcpforwarding)"
echo

# Rationale
echo "Rationale:"
echo "Disabling SSH port forwarding reduces the risk of security breaches and backdoors through unauthorized access or data exfiltration."
echo

# Compliance
if [[ "$allow_tcp_forwarding" == "no" ]]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "SSH AllowTcpForwarding is correctly set to 'no'."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "SSH AllowTcpForwarding is not disabled. Update the /etc/ssh/sshd_config file to set 'AllowTcpForwarding no'."
fi

# Prompt user for remediation
#if [[ "$allow_tcp_forwarding" != "no" ]]; then
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
 # if [[ "$choice" == [yY] ]]; then
  #  echo "Remediating..."
   # sed -i '/^\s*AllowTcpForwarding\s/ d' /etc/ssh/sshd_config
   # echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config
   # systemctl reload sshd
   # echo "Remediation completed."
 # else
  #  echo "No changes have been made."
 # fi
#fi

