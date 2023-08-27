#!/bin/bash

# Section: 5.1.4
# Title: Ensure permissions on /etc/cron.daily are configured (Automated)
# Compliance: [Pass/Fail] (Highlighted in green or red)
# Evidence: Output of the command
# Rationale: Explanation of why this check is performed
# Remediation: Steps to fix the issue

# Check permissions on /etc/cron.daily
cron_daily_permissions=$(stat -c "%a" /etc/cron.daily)
cron_daily_owner=$(stat -c "%U:%G" /etc/cron.daily)

# Title
echo "Section: 5.1.4
Title: Ensure permissions on /etc/cron.daily are configured (Automated)"

# Compliance
if [[ $cron_daily_permissions == "700" ]] && [[ $cron_daily_owner == "root:root" ]]; then
  echo -e "\e[32mCompliance: Pass\e[0m"
else
  echo -e "\e[31mCompliance: Fail\e[0m"

  # Remediation
  echo "Remediation:"
  echo "To set ownership and permissions on the /etc/cron.daily directory, run the following commands:"
  echo "# chown root:root /etc/cron.daily"
  echo "# chmod 700 /etc/cron.daily"
fi

# Evidence
echo "Evidence:"
echo "Command: stat /etc/cron.daily"
echo "Output:"
stat /etc/cron.daily
echo

# Rationale
echo "Rationale:"
echo "The /etc/cron.daily directory contains system cron jobs that need to run on a daily basis. Restricting read, write, and search access to user and group root is important to prevent unauthorized access or modification of these system cron jobs. It helps maintain the integrity and security of the cron jobs."
echo

# Explanation of failure
if [[ $cron_daily_permissions != "700" ]]; then
  echo "Explanation:"
  echo "The permissions on /etc/cron.daily are currently set to $cron_daily_permissions instead of the required 700."
  echo
fi

if [[ $cron_daily_owner != "root:root" ]]; then
  echo "Explanation:"
  echo "The owner/group of /etc/cron.daily is currently set to $cron_daily_owner instead of root:root."
  echo
fi

