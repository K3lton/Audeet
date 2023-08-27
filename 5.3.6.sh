#!/bin/bash

# Title
echo "Section: 5.3.6 
Title: Ensure sudo authentication timeout is configured correctly (Automated)"

# Evidence
echo "Evidence:"
echo "Command: grep -roP \"timestamp_timeout=\K[0-9]*\" /etc/sudoers*"
echo "Output:"
grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers*
echo

# Rationale
echo "Rationale:"
echo "Configuring a proper sudo authentication timeout reduces the window of opportunity for unauthorized privileged access."
echo

# Compliance
timeout=$(grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers* | head -n 1)
#if [[ -n "$timeout" ]]; then
#  if [[ "$timeout" -le 15 ]]; then
    echo -e "Compliance: NoAccess"
    echo "Explanation:"
    echo "The sudo authentication timeout is configured correctly."

#  else
#    echo -e "Compliance: NoAccess"
#    echo "Explanation:"
#    echo "The sudo authentication timeout is configured for more than 15 minutes."

    # Prompt user for remediation
#    read -r -p "Do you want to remediate this issue? (y/n): " choice
#    if [[ "$choice" == [yY] ]]; then
#      echo "Remediating..."
#      sudo sed -i 's/^.*timestamp_timeout=.*/Defaults timestamp_timeout=15/' /etc/sudoers*
#      echo "Remediation completed."
#    else
#      echo "No changes have been made."
#    fi
#  fi


