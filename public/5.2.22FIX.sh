#!/bin/bash

# Check the ClientAliveInterval and ClientAliveCountMax settings
client_alive_interval=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep clientaliveinterval | awk '{print $2}')
client_alive_count_max=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep clientalivecountmax | awk '{print $2}')

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.22 
Title: Ensure SSH Idle Timeout Interval is configured (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep clientaliveinterval"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep clientaliveinterval)"
echo
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep clientalivecountmax"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep clientalivecountmax)"
echo

# Rationale
echo "Rationale:"
echo "The ClientAliveInterval and ClientAliveCountMax parameters control the timeout of SSH sessions. Setting appropriate values helps prevent resource exhaustion and potential abuse of idle connections. The recommended example is a 45-second timeout."
echo

# Compliance
if [[ "$client_alive_interval" -gt 0 && "$client_alive_count_max" -gt 0 ]]; then
  echo -e "Compliance: \e[32mPass\e[0m"
  echo "Explanation:"
  echo "SSH ClientAliveInterval and ClientAliveCountMax are configured with appropriate values."
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "SSH ClientAliveInterval and/or ClientAliveCountMax are not configured with the recommended values. Update the /etc/ssh/sshd_config file to set 'ClientAliveInterval' and 'ClientAliveCountMax' according to site policy."
fi

# Prompt user for remediation
#if [[ "$client_alive_interval" -eq 0 || "$client_alive_count_max" -eq 0 ]]; then
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
#  if [[ "$choice" == [yY] ]]; then
#    echo "Remediating..."
#    sed -i 's/^\s*ClientAliveInterval.*/ClientAliveInterval 15/' /etc/ssh/sshd_config
#    sed -i 's/^\s*ClientAliveCountMax.*/ClientAliveCountMax 3/' /etc/ssh/sshd_config
#    systemctl reload sshd
#    echo "Remediation completed."
#  else
#    echo "No changes have been made."
#  fi
#fi

