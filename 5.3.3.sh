#!/bin/bash

# Title
echo "Section: 5.3.3"
echo "Title: Ensure sudo log file exists (Automated)"

# Evidence
echo "Evidence:"
echo "Command: grep -rPsi \"^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h*(#.*)?$\" /etc/sudoers*"
echo "Output:"
grep -rPsi "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers*
echo

# Rationale
echo "Rationale:"
echo "Having a custom log file for sudo commands simplifies auditing and provides a dedicated location for sudo logs."
echo

# Compliance
if grep -rPsi "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers* >/dev/null 2>&1; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "Sudo has a custom log file configured."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "Sudo does not have a custom log file configured."

  # Prompt user for remediation
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
#  if [[ "$choice" == [yY] ]]; then
#    echo "Remediating..."
#    echo 'Defaults logfile="/var/log/sudo.log"' |/usr/sbin/visudo -f /etc/sudoers.d/logfile
#    echo "Remediation completed."
#  else
#    echo "No changes have been made."
#  fi
fi

