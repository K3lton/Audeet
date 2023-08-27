#!/bin/bash

#Section: 5.1.1
#Title: Ensure cron daemon is enabled and running (Automated)
# Compliance: [Pass/Fail] (Highlighted in green or red)
# Evidence: Output of the commands
# Rationale: Explanation of why this check is performed
# Remediation: Steps to fix the issue

# Check if cron daemon is enabled
is_enabled=$(systemctl is-enabled cron 2>/dev/null)

# Check if cron daemon is running
cron_status=$(systemctl is-active cron)

# Title
echo " Section: 5.1.1
Title: Ensure cron daemon is enabled and running (Automated)"

# Compliance
if [ "$is_enabled" = "enabled" ] && [ "$cron_status" = "active" ]; then
  echo -e "\e[32mCompliance: Pass\e[0m"
else
  echo -e "\e[31mCompliance: Fail\e[0m"
fi

# Evidence
echo "Evidence:"
echo "Command: systemctl is-enabled cron"
echo "Output: $is_enabled"
echo
echo "Command: systemctl is-active cron"
echo "Output: $cron_status"
echo

# Rationale
echo "Rationale:"
echo "The cron daemon is used to execute batch jobs on the system. While there may not be user jobs that need to be run on the system, the system does have maintenance jobs that may include security monitoring that have to run, and cron is used to execute them."
echo

# Remediation
echo "Remediation:"
echo "To enable and start cron, run the following command:"
echo "# systemctl --now enable cron"

