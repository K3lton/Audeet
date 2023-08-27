#!/bin/bash

# Check if SSH X11 forwarding is disabled
x11forwarding=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}') " | grep -i x11forwarding | awk '{print $2}')
config_x11forwarding=$(grep -Ei '^\s*X11Forwarding\s+yes' /etc/ssh/sshd_config)

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.12
Title: Ensure SSH X11 forwarding is disabled (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i x11forwarding"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i x11forwarding)"
echo

# Rationale
echo "Rationale:"
echo "Disabling X11 forwarding unless there is an operational requirement to use X11 applications directly reduces the risk of compromising the remote X11 servers."
echo

# Compliance
if [[ "$x11forwarding" == "no" && -z "$config_x11forwarding" ]]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "X11 forwarding is disabled, reducing the risk of compromising remote X11 servers."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "X11 forwarding is enabled. Disabling X11 forwarding reduces the risk of compromising remote X11 servers."
fi

# Prompt user for remediation
#if [[ "$x11forwarding" != "no" || -n "$config_x11forwarding" ]]; then
 # read -p "Do you want to remediate the failed compliance check? (y/n): " choice
 # if [[ "$choice" == "y" ]]; then
  #  # Perform remediation steps
   # echo "Performing remediation..."
    
   # echo "Setting X11Forwarding to no in /etc/ssh/sshd_config"
   # sed -i 's/^#*X11Forwarding.*/X11Forwarding no/' /etc/ssh/sshd_config
    
   # echo "X11Forwarding has been disabled."

   # echo "Restarting SSH service..."
   # systemctl restart sshd

   # echo "Remediation completed."
#  fi
#fi

