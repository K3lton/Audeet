#!/bin/bash

# Check current SSH LogLevel
current_loglevel=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep loglevel | awk '{print $2}')

# Title
echo "Section: 5.2.5
Title: Ensure SSH LogLevel is appropriate (Automated)"

# Evidence
echo "Evidence:"
echo "Command: /usr/sbin/sshd -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep loglevel"
echo "Output:"
echo "$(/usr/sbin/sshd -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep loglevel)"
echo

# Rationale
echo "Rationale:"
echo "Configuring the appropriate SSH LogLevel helps in recording the necessary login and logout activity for monitoring and incident response purposes. Using DEBUG level is not recommended as it may expose sensitive information."
echo

# Compliance
if [[ "$current_loglevel" == "VERBOSE" || "$current_loglevel" == "INFO" ]]; then
  echo -e "Compliance: \e[32mPass\e[0m"
  echo "Explanation:"
  echo "The current SSH LogLevel is set to $current_loglevel, which is appropriate for logging login and logout activity."
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "The current SSH LogLevel is set to $current_loglevel, which is not recommended. It should be set to VERBOSE or INFO to ensure appropriate logging of SSH activity."
fi

# Prompt user for remediation
if [[ "$current_loglevel" != "VERBOSE" && "$current_loglevel" != "INFO" ]]; then
  read -p "Do you want to remediate the failed compliance check? (y/n): " choice
  if [[ "$choice" == "y" ]]; then
    # Perform remediation steps
    echo "Performing remediation..."
    
    echo "Setting LogLevel to VERBOSE in /etc/ssh/sshd_config"
    sed -i 's/^#*LogLevel.*/LogLevel VERBOSE/' /etc/ssh/sshd_config
    
    echo "SSH LogLevel has been set to VERBOSE."

    echo "Restarting SSH service..."
    systemctl restart sshd

    echo "Remediation completed."
  fi
fi

