#!/bin/bash

# Title

echo "Section: 5.3.5"
echo "Title: Ensure re-authentication for privilege escalation is not disabled globally (Automated)"

# Evidence
echo "Evidence:"
echo "Command: grep -r \"^[^#].*!authenticate\" /etc/sudoers*"
echo "Output:"
grep -r "^[^#].*!authenticate" /etc/sudoers*
echo

# Rationale
echo "Rationale:"
echo "Requiring users to re-authenticate for privilege escalation ensures proper authentication and prevents unauthorized access to resources or tasks."
echo

# Compliance
if grep -r "^[^#].*!authenticate" /etc/sudoers* >/dev/null 2>&1; then
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "Re-authentication for privilege escalation is disabled globally (!authenticate tag found in sudoers files)."

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
  echo "Re-authentication for privilege escalation is not disabled globally."
fi

