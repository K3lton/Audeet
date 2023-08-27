#!/bin/bash

# Section: 5.1.2
# Title: Ensure permissions on /etc/crontab are configured (Automated)
# Compliance: [Pass/Fail] (Highlighted in green or red)
# Evidence: Output of the command
# Rationale: Explanation of why this check is performed
# Remediation: Steps to fix the issue

# Check permissions on /etc/crontab
crontab_permissions=$(stat -c "%a" /etc/crontab)
crontab_owner=$(stat -c "%U:%G" /etc/crontab)

# Title
echo " Section: 5.1.2
Title: Ensure permissions on /etc/crontab are configured (Automated)"

# Compliance
if [[ $crontab_permissions == "600" ]] && [[ $crontab_owner == "root:root" ]]; then
  echo -e "Compliance: Pass"
else
  echo -e "Compliance: Fail"
fi

# Evidence
echo "Evidence:"
echo "Command: stat /etc/crontab"
echo "Output:"
stat /etc/crontab
echo

# Rationale
echo "Rationale:"
echo "The /etc/crontab file is used by cron to control its own jobs. Ensuring correct permissions on this file is important to prevent unauthorized access and privilege escalation. Incorrect permissions could allow unprivileged users to modify or read sensitive system jobs information."
echo

# Remediation
echo "Remediation:"
echo "To set ownership and permissions on /etc/crontab, run the following commands:"
echo "# chown root:root /etc/crontab"
echo "# chmod 600 /etc/crontab"
echo

# Explanation of failure
if [[ $crontab_permissions != "600" ]]; then
  echo "Explanation:"
  echo "The permissions on /etc/crontab are currently set to $crontab_permissions instead of the required 600."
  echo
fi

if [[ $crontab_owner != "root:root" ]]; then
  echo "Explanation:"
  echo "The owner/group of /etc/crontab is currently set to $crontab_owner instead of root:root."
  echo
fi

