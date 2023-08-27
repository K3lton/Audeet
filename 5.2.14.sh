#!/bin/bash

# Define the list of approved strong MAC algorithms
approved_macs="hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256"

# Check the SSH MAC algorithms
macs=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i "MACs" | awk '{print $2}')

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.14
Title: Ensure only strong MAC algorithms are used (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i \"MACs\""
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i \"MACs\")"
echo

# Rationale
echo "Rationale:"
echo "Using strong MAC algorithms in SSH communication ensures integrity and security of system data."
echo

# Compliance
if [[ -n "$macs" ]]; then
  weak_macs=""
  for mac in $macs; do
    if [[ "$mac" == "hmac-md5" || "$mac" == "hmac-md5-96" || "$mac" == "hmac-ripemd160" || "$mac" == "hmac-sha1" || "$mac" == "hmac-sha1-96" || "$mac" == "umac-64@openssh.com" || "$mac" == "umac-128@openssh.com" || "$mac" == "hmac-md5-etm@openssh.com" || "$mac" == "hmac-md5-96-etm@openssh.com" || "$mac" == "hmac-ripemd160-etm@openssh.com" || "$mac" == "hmac-sha1-etm@openssh.com" || "$mac" == "hmac-sha1-96-etm@openssh.com" || "$mac" == "umac-64-etm@openssh.com" || "$mac" == "umac-128-etm@openssh.com" ]]; then
      weak_macs+=" $mac"
    fi
  done

  if [[ -z "$weak_macs" ]]; then
    echo -e "Compliance: Pass"
    echo "Explanation:"
    echo "Only strong MAC algorithms are used in SSH communication."
  else
    echo -e "Compliance: Fail"
    echo "Explanation:"
    echo "Weak MAC algorithms ($weak_macs) are used in SSH communication. Replace them with approved strong MAC algorithms."
  fi
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "No MAC algorithms are configured in SSH. Configure the MACs line in /etc/ssh/sshd_config to use approved strong MAC algorithms."
fi

# Prompt user for remediation
#if [[ -n "$weak_macs" || -z "$macs" ]]; then
 # read -r -p "Do you want to remediate this issue? (y/n): " choice
 # if [[ "$choice" == [yY] ]]; then
  #  echo "Remediating..."
   # sed -i '/^\s*MACs\s/ d' /etc/ssh/sshd_config
  #  echo "MACs $approved_macs" >> /etc/ssh/sshd_config
  #  systemctl reload sshd
  #  echo "Remediation completed."
 # else
  #  echo "No changes have been made."
 # fi
#fi

