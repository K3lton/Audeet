#!/bin/bash

# Check the MaxStartups setting
#max_startups=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxstartups | awk '{print $2}')

max_startups=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxstartups | awk '{print $2}' | grep -v "none")
# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.19 
Title: Ensure SSH MaxStartups is configured (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i maxstartups"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep -i maxstartups)"
echo

# Rationale
echo "Rationale:"
echo "The MaxStartups parameter is used to limit the number of concurrent unauthenticated connections to the SSH daemon, preventing denial-of-service attacks."
echo

# Compliance
if [[ "$max_startups" == "10:30:60" ]]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "SSH MaxStartups is configured with the value '10:30:60' or more restrictive."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "SSH MaxStartups is not configured with the recommended value. Update the /etc/ssh/sshd_config file to set 'MaxStartups 10:30:60'."
fi

# Prompt user for remediation
#if [[ "$max_startups" != "10:30:60" ]]; then
 # read -r -p "Do you want to remediate this issue? (y/n): " choice
  #if [[ "$choice" == [yY] ]]; then
   # echo "Remediating..."
    #sed -i 's/^\s*MaxStartups.*/MaxStartups 10:30:60/' /etc/ssh/sshd_config
   # systemctl reload sshd
   # echo "Remediation completed."
 # else
 #   echo "No changes have been made."
 # fi
#fi
# Prompt user for remediation
# Prompt user for remediation
#if [[ "$max_startups" != "10:30:60" ]]; then
 # read -r -p "Do you want to remediate this issue? (y/n): " choice
 # if [[ "$choice" == [yY] ]]; then
  #  echo "Remediating..."
   # if grep -qE '^\s*#*\s*MaxStartups' /etc/ssh/sshd_config; then
    #  # MaxStartups is commented out
   ##   sed -i 's/^\s*#*\s*MaxStartups.*/MaxStartups 10:30:60/' /etc/ssh/sshd_config
 #   else
      # MaxStartups is not commented out
  #    if grep -qE '^\s*MaxStartups\s+10:30:100' /etc/ssh/sshd_config; then
   #     # MaxStartups value is set to 10:30:100, change it to 10:30:60
    #    sed -i 's/^\s*MaxStartups\s+10:30:100/MaxStartups 10:30:60/' /etc/ssh/sshd_config
  #    elif ! grep -qE '^\s*MaxStartups' /etc/ssh/sshd_config; then
        # MaxStartups line exists but value is different, update it to 10:30:60
   #     sed -i 's/^\s*MaxStartups.*/MaxStartups 10:30:60/' /etc/ssh/sshd_config
   #   fi
    #fi
   # systemctl reload sshd
   # echo "Remediation completed."
 # else
  #  echo "No changes have been made."
  #fi
#fi

