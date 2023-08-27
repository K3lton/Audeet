#!/bin/bash

# Check if SSH PAM is enabled
usepam_enabled=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i usepam | awk '{print $2}')

# Title
echo "Section: 5.2.6
Title: Ensure SSH PAM is enabled (Automated)"

# Evidence
echo "Evidence:"
echo "Command: /usr/sbin/sshd -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i usepam"
echo "Output:"
echo "$(/usr/sbin/sshd -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i usepam)"
echo

# Rationale
echo "Rationale:"
echo "Enabling SSH PAM (Pluggable Authentication Module) allows for additional authentication and session management capabilities provided by PAM. It helps in enforcing access restrictions based on various factors and allows for better control over user authentication."
echo

# Compliance
if [[ "$usepam_enabled" == "yes" ]]; then
  echo -e "Compliance: \e[32mPass\e[0m"
  echo "Explanation:"
  echo "SSH PAM is enabled, which allows for enhanced authentication and session management capabilities."
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "SSH PAM is not enabled. Enabling PAM provides additional security and control over user authentication and session management."
fi

# Prompt user for remediation
if [[ "$usepam_enabled" != "yes" ]]; then
  read -p "Do you want to remediate the failed compliance check? (y/n): " choice
  if [[ "$choice" == "y" ]]; then
    # Perform remediation steps
    echo "Performing remediation..."
    
    echo "Setting UsePAM to yes in /etc/ssh/sshd_config"
    sed -i 's/^#*UsePAM.*/UsePAM yes/' /etc/ssh/sshd_config
    
    echo "SSH PAM has been enabled."

    echo "Restarting SSH service..."
    systemctl restart sshd

    echo "Remediation completed."
  fi
fi

