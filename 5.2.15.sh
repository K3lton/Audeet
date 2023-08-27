#!/bin/bash

# Define the list of approved strong Key Exchange algorithms
approved_kex="curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256"

# Check the SSH Key Exchange algorithms
kex_algorithms=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep kexalgorithms | awk '{print $2}')

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.15
Title: Ensure only strong Key Exchange algorithms are used (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep kexalgorithms"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep kexalgorithms)"
echo

# Rationale
echo "Rationale:"
echo "Using strong Key Exchange algorithms in SSH communication ensures the security and integrity of the key exchange process."
echo

# Compliance
if [[ -n "$kex_algorithms" ]]; then
  weak_kex=""
  for kex in $kex_algorithms; do
    if [[ "$kex" == "diffie-hellman-group1-sha1" || "$kex" == "diffie-hellman-group14-sha1" || "$kex" == "diffie-hellman-group-exchange-sha1" ]]; then
      weak_kex+=" $kex"
    fi
  done

  if [[ -z "$weak_kex" ]]; then
    echo -e "Compliance: Pass"
    echo "Explanation:"
    echo "Only strong Key Exchange algorithms are used in SSH communication."
  else
    echo -e "Compliance: Fail"
    echo "Explanation:"
    echo "Weak Key Exchange algorithms ($weak_kex) are used in SSH communication. Replace them with approved strong Key Exchange algorithms."
  fi
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "No Key Exchange algorithms are configured in SSH. Configure the KexAlgorithms line in /etc/ssh/sshd_config to use approved strong Key Exchange algorithms."
fi

# Prompt user for remediation
#if [[ -n "$weak_kex" || -z "$kex_algorithms" ]]; then
 # read -r -p "Do you want to remediate this issue? (y/n): " choice
 # if [[ "$choice" == [yY] ]]; then
  #  echo "Remediating..."
   # sed -i '/^\s*KexAlgorithms\s/ d' /etc/ssh/sshd_config
   # echo "KexAlgorithms $approved_kex" >> /etc/ssh/sshd_config
   # systemctl reload sshd
   # echo "Remediation completed."
 # else
  #  echo "No changes have been made."
 # fi
#fi

