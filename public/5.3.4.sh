#!/bin/bash

# Title
echo "Section: 5.3.4"
echo "Title: Ensure users must provide password for privilege escalation (Automated)"

# Evidence
echo "Evidence:"
echo "Command: grep -r \"^[^#].*NOPASSWD\" /etc/sudoers*"
echo "Output:"
grep -r "^[^#].*NOPASSWD" /etc/sudoers*
echo

# Rationale
echo "Rationale:"
echo "Requiring users to provide a password for privilege escalation ensures proper authentication and prevents unauthorized access to resources or tasks."
echo

# Compliance
if grep -r "^[^#].*NOPASSWD" /etc/sudoers* >/dev/null 2>&1; then
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "Users are not required to provide a password for privilege escalation (NOPASSWD tag found in sudoers files)."

#  # Prompt user for remediation
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
#  if [[ "$choice" == [yY] ]]; then
#    echo "Remediating..."
#    sudo /usr/sbin/visudo -f /etc/sudoers
#    echo "Remediation completed."
#  else
#    echo "No changes have been made."
#  fi
else
  echo -e "Compliance: \e[32mPass\e[0m"
  echo "Explanation:"
  echo "Users are required to provide a password for privilege escalation."
  fi

