#!/bin/bash

# Title
echo "Section: 5.3.2 
Title: Ensure sudo commands use pty (Automated)"

# Evidence
echo "Evidence:"
echo "Command: grep -rPi '^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*"
echo "Output:"
grep -rPi '^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*
echo

# Rationale
echo "Rationale:"
echo "Running sudo commands from a pseudo terminal (pty) can help mitigate certain security risks and prevent malicious background processes from persisting after executing the main program."
echo

# Compliance
if grep -rPi '^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers* >/dev/null 2>&1; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "The sudo configuration is set to require a pseudo terminal (pty) for running commands."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "The sudo configuration does not require a pseudo terminal (pty) for running commands. This can potentially allow malicious background processes to persist."

  # Prompt user for remediation
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
#  if [[ "$choice" == [yY] ]]; then
#    echo "Remediating..."
#    echo "Defaults use_pty" | visudo -f /etc/sudoers.d/pty
#    echo "Remediation completed."
#  else
#    echo "No changes have been made."
#  fi
fi

