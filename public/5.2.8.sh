#!/bin/bash

# Check if SSH HostbasedAuthentication is disabled
hostbasedauthentication=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep hostbasedauthentication | awk '{print $2}')
config_hostbasedauthentication=$(grep -Ei '^\s*HostbasedAuthentication\s+yes' /etc/ssh/sshd_config)

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.8
Title: Ensure SSH HostbasedAuthentication is disabled (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep hostbasedauthentication"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep hostbasedauthentication)"
echo

# Rationale
echo "Rationale:"
echo "Disabling HostbasedAuthentication in SSH helps prevent authentication through trusted hosts via .rhosts files or /etc/hosts.equiv. This provides an additional layer of protection, even if support for .rhosts files is already disabled in /etc/pam.conf."
echo

# Compliance
if [[ "$hostbasedauthentication" == "no" && -z "$config_hostbasedauthentication" ]]; then
  echo -e "Compliance: \e[32mPass\e[0m"
  echo "Explanation:"
  echo "HostbasedAuthentication is disabled, which enhances security by preventing authentication through trusted hosts."
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "HostbasedAuthentication is enabled. Disabling HostbasedAuthentication provides an additional layer of protection by preventing authentication through trusted hosts via .rhosts files or /etc/hosts.equiv."
fi

# Prompt user for remediation
if [[ "$hostbasedauthentication" != "no" || -n "$config_hostbasedauthentication" ]]; then
  read -p "Do you want to remediate the failed compliance check? (y/n): " choice
  if [[ "$choice" == "y" ]]; then
    # Perform remediation steps
    echo "Performing remediation..."
    
    echo "Setting HostbasedAuthentication to no in /etc/ssh/sshd_config"
    sed -i 's/^#*HostbasedAuthentication.*/HostbasedAuthentication no/' /etc/ssh/sshd_config
    
    echo "HostbasedAuthentication has been disabled."

    echo "Restarting SSH service..."
    systemctl restart sshd

    echo "Remediation completed."
  fi
fi

