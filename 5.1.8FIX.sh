#!/bin/bash

#Check if /etc/cron.deny exists
if [[ -e "/etc/cron.deny" ]]; then
echo "Compliance: Fail"
echo "Explanation:"
echo "/etc/cron.deny file exists. It should be removed to restrict cron access only to authorized users."
echo "Remediation:"
echo "To remove /etc/cron.deny, run the following command:"
echo "rm /etc/cron.deny"
else

#Check permissions on /etc/cron.allow
cron_allow_permissions=$(stat -c "%a" /etc/cron.allow 2>/dev/null)
cron_allow_owner=$(stat -c "%U:%G" /etc/cron.allow 2>/dev/null)

#Title
echo "Section: 5.1.8
Title: Ensure cron is restricted to authorized users (Automated)"

#Evidence
echo "Evidence:"
echo "Command: stat /etc/cron.deny"
echo "Output: No such file or directory"
echo
echo "Command: stat /etc/cron.allow"
echo "Output:"
echo "$(stat /etc/cron.allow 2>/dev/null)"
echo

#Rationale
echo "Rationale:"
echo "Configuring access control for cron helps enforce the policy of allowing only authorized users to schedule cron jobs. It is easier to manage an allow list than a deny list, and removing /etc/cron.deny ensures that only users specified in /etc/cron.allow are allowed to use cron."
echo

#Remediation
echo "Remediation:"
echo "To remove /etc/cron.deny, run the following command:"
echo "rm /etc/cron.deny"
echo "To create /etc/cron.allow, run the following command:"
echo "touch /etc/cron.allow"
echo "To set permissions and ownership for /etc/cron.allow, run the following commands:"
echo "chmod 640 /etc/cron.allow"
echo "chown root:root /etc/cron.allow"
echo

#Compliance
if [[ $cron_allow_permissions == "640" ]] && [[ $cron_allow_owner == "root:root" ]]; then
echo "Compliance: Pass"
else
echo "Compliance: Fail"
echo "Explanation:"
if [[ $cron_allow_permissions != "640" ]]; then
echo "The permissions on /etc/cron.allow are not set to 640. It is recommended to set the permissions to 640 (-rw-r-----) to restrict write access to the group and deny access to others."
fi
if [[ $cron_allow_owner != "root:root" ]]; then
echo "The owner of /etc/cron.allow is not set to root:root. It is recommended to set the owner to root:root to ensure proper ownership."
fi
fi
fi
