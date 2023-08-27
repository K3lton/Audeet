#!/bin/bash

# Section: 5.1.3
# Title: Ensure permissions on /etc/cron.hourly are configured (Automated)
# Compliance: [Pass/Fail] (Highlighted in green or red)
# Evidence: Output of the command
# Rationale: Explanation of why this check is performed
# Remediation: Steps to fix the issue

# Check permissions on /etc/cron.hourly
cron_hourly_permissions=$(stat -c "%a" /etc/cron.hourly)
cron_hourly_owner=$(stat -c "%U:%G" /etc/cron.hourly)

# Title
echo "Section: 5.1.3
Title: Ensure permissions on /etc/cron.hourly are configured (Automated)"

# Compliance
if [[ $cron_hourly_permissions == "700" ]] && [[ $cron_hourly_owner == "root:root" ]]; then
  echo -e "Compliance: Pass"
else
  echo -e "Compliance: Fail"
fi

# Evidence
echo "Evidence:"
echo "Command: stat /etc/cron.hourly"
echo "Output:"
stat /etc/cron.hourly
echo

# Rationale
echo "Rationale:"
echo "The /etc/cron.hourly directory contains system cron jobs that need to run on an hourly basis. Restricting read, write, and search access to user and group root is important to prevent unauthorized access or modification of these system cron jobs. It helps maintain the integrity and security of the cron jobs."
echo

# Remediation
echo "Remediation:"
echo "To set ownership and permissions on the /etc/cron.hourly directory, run the following commands:"
echo "# chown root:root /etc/cron.hourly"
echo "# chmod 700 /etc/cron.hourly"
echo

# Explanation of failure
if [[ $cron_hourly_permissions != "700" ]]; then
  echo "Explanation:"
  echo "The permissions on /etc/cron.hourly are currently set to $cron_hourly_permissions instead of the required 700."
  echo
fi

if [[ $cron_hourly_owner != "root:root" ]]; then
  echo "Explanation:"
  echo "The owner/group of /etc/cron.hourly is currently set to $cron_hourly_owner instead of root:root."
  echo
fi

