#!/bin/bash

# Check permissions on /etc/cron.monthly
cron_monthly_permissions=$(stat -c "%a" /etc/cron.monthly)
cron_monthly_owner=$(stat -c "%U:%G" /etc/cron.monthly)

# Title
echo "Section: 5.1.6 
Title: Ensure permissions on /etc/cron.monthly are configured (Automated)"

# Evidence
echo "Evidence:"
echo "Command: stat /etc/cron.monthly"
echo "Output:"
echo "$(stat /etc/cron.monthly)"
echo

# Rationale
echo "Rationale:"
echo "The /etc/cron.monthly directory contains system cron jobs that need to run on a monthly basis. Restricting read, write, and search access to user and group root is important to prevent unauthorized access or modification of these system cron jobs. It helps maintain the integrity and security of the cron jobs."
echo

# Remediation
echo "Remediation:"
echo "To set ownership and permissions on the /etc/cron.monthly directory, run the following commands:"
echo "chown root:root /etc/cron.monthly"
echo "chmod 700 /etc/cron.monthly"
echo

# Compliance
if [[ $cron_monthly_permissions == "700" ]] && [[ $cron_monthly_owner == "root:root" ]]; then
  echo "Compliance: Pass"
else
  echo "Compliance: Fail"
  echo "Explanation:"
  if [[ $cron_monthly_permissions != "700" ]]; then
    echo "The permissions on /etc/cron.monthly are not set to 700. It is recommended to set the permissions to 700 to restrict access to user and group root only."
  fi
  if [[ $cron_monthly_owner != "root:root" ]]; then
    echo "The owner of /etc/cron.monthly is not set to root:root. It is recommended to set the owner to root:root to ensure proper ownership."
  fi
fi

