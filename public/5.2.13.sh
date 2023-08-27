#!/bin/bash

# Define the list of approved strong ciphers
approved_ciphers="chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr"

# Check the SSH ciphers
ciphers=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}') " | grep ciphers | awk '{print $2}')

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.13
Title: Ensure only strong Ciphers are used (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep ciphers"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep ciphers)"
echo

# Rationale
echo "Rationale:"
echo "Using strong ciphers in SSH communication ensures confidentiality and integrity of system data."
echo

# Compliance
if [[ -n "$ciphers" ]]; then
  weak_ciphers=""
  for cipher in $ciphers; do
    if [[ "$cipher" == "3des-cbc" || "$cipher" == "aes128-cbc" || "$cipher" == "aes192-cbc" || "$cipher" == "aes256-cbc" ]]; then
      weak_ciphers+=" $cipher"
    fi
  done

  if [[ -z "$weak_ciphers" ]]; then
    echo -e "Compliance: \e[32mPass\e[0m"
    echo "Explanation:"
    echo "Only strong ciphers are used in SSH communication."
  else
    echo -e "Compliance: \e[31mFail\e[0m"
    echo "Explanation:"
    echo "Weak ciphers ($weak_ciphers) are used in SSH communication. Replace them with approved strong ciphers."
  fi
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "No ciphers are configured in SSH. Configure the Ciphers line in /etc/ssh/sshd_config to use approved strong ciphers."
fi

# Prompt user for remediation
#if [[ -n "$weak_ciphers" || -z "$ciphers" ]]; then
 # read -p "Do you want to remediate the failed compliance check? (y/n): " choice
  #if [[ "$choice" == "y" ]]; then
    # Perform remediation steps
   # echo "Performing remediation..."
    
   # if grep -q '^Ciphers' /etc/ssh/sshd_config; then
    #  sed -i 's/^Ciphers.*/Ciphers '"$approved_ciphers"'/' /etc/ssh/sshd_config
   # else
    #  echo "Ciphers $approved_ciphers" >> /etc/ssh/sshd_config
    #fi
    
   # echo "Approved strong ciphers have been configured in /etc/ssh/sshd_config."

   # echo "Restarting SSH service..."
   # systemctl restart sshd

   # echo "Remediation completed."
 # fi
#fi

