#!/bin/bash

# Section: 5.1.5
# Title: Ensure permissions on /etc/cron.weekly are configured (Automated)
# Compliance: [Pass/Fail] (Highlighted in green or red)
# Evidence: Output of the command
# Rationale: Explanation of why this check is performed
# Remediation: Steps to fix the issue

# Check permissions on /etc/cron.weekly
cron_weekly_permissions=$(stat -c "%a" /etc/cron.weekly)
cron_weekly_owner=$(stat -c "%U:%G" /etc/cron.weekly)

# Title
echo "Section: 5.1.5
Title: Ensure permissions on /etc/cron.weekly are configured (Automated)"

# Evidence
echo "Evidence:"
echo "Command: stat /etc/cron.weekly"
echo "Output:"
stat /etc/cron.weekly
echo

# Rationale
echo "Rationale:"
echo "The /etc/cron.weekly directory contains system cron jobs that need to run on a weekly basis. Restricting read, write, and search access to user and group root is important to prevent unauthorized access or modification of these system cron jobs. It helps maintain the integrity and security of the cron jobs."
echo

# Remediation
echo "Remediation:"
echo "To set ownership and permissions on the /etc/cron.weekly directory, run the following commands:"
echo "# chown root:root /etc/cron.weekly"
echo "# chmod 700 /etc/cron.weekly"
echo

# Compliance
if [[ $cron_weekly_permissions == "700" ]] && [[ $cron_weekly_owner == "root:root" ]]; then
  echo -e "Compliance: Pass"
else
  echo -e "Compliance: Fail"

  # Explanation of failure
  echo "Explanation:"
  if [[ $cron_weekly_permissions != "700" ]]; then
    echo "The permissions on /etc/cron.weekly are currently set to $cron_weekly_permissions instead of the required 700."
  fi

  if [[ $cron_weekly_owner != "root:root" ]]; then
    echo "The owner/group of /etc/cron.weekly is currently set to $cron_weekly_owner instead of root:root."
  fi
fi

