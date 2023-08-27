#!/bin/bash

# Check permissions on /etc/cron.d
cron_d_permissions=$(stat -c "%a" /etc/cron.d)
cron_d_owner=$(stat -c "%U:%G" /etc/cron.d)

# Title
echo "Section: 5.1.7
Title: Ensure permissions on /etc/cron.d are configured (Automated)"

# Evidence
echo "Evidence:"
echo "Command: stat /etc/cron.d"
stat /etc/cron.d
echo

# Rationale
echo "Rationale:"
echo "The /etc/cron.d directory contains system cron jobs that need to run in a similar manner to the hourly, daily, weekly, and monthly jobs from /etc/crontab. Restricting read, write, and search access to user and group root is important to prevent unauthorized access or modification of these system cron jobs. It helps maintain the integrity and security of the cron jobs."
echo

# Remediation
echo "Remediation:"
echo "To set ownership and permissions on the /etc/cron.d directory, run the following commands:"
echo "chown root:root /etc/cron.d"
echo "chmod 700 /etc/cron.d"
echo

# Compliance
if [[ $cron_d_permissions == "700" ]] && [[ $cron_d_owner == "root:root" ]]; then
  echo -e "Compliance: \e[32mPass\e[0m"
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  if [[ $cron_d_permissions != "700" ]]; then
    echo "The permissions on /etc/cron.d are not set to 700. It is recommended to set the permissions to 700 to restrict access to user and group root only."
  fi
  if [[ $cron_d_owner != "root:root" ]]; then
    echo "The owner of /etc/cron.d is not set to root:root. It is recommended to set the owner to root:root to ensure proper ownership."
  fi
fi

