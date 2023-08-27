#!/bin/bash

# Check permissions on /etc/ssh/sshd_config
sshd_config_permissions=$(stat -c "%a" /etc/ssh/sshd_config)
sshd_config_owner=$(stat -c "%U:%G" /etc/ssh/sshd_config)

# Title
echo "Section: 5.2.1
Title: Ensure permissions on /etc/ssh/sshd_config are configured (Automated)"

# Evidence
echo "Evidence:"
echo "Command: stat /etc/ssh/sshd_config"
echo "Output:"
echo "$(stat /etc/ssh/sshd_config)"
echo

# Rationale
echo "Rationale:"
echo "The /etc/ssh/sshd_config file needs to be protected from unauthorized changes by non-privileged users. By setting appropriate permissions and ownership, the file's integrity and security can be ensured."
echo

# Compliance
if [[ $sshd_config_permissions == "600" ]] && [[ $sshd_config_owner == "root:root" ]]; then
  echo -e "Compliance: Pass"
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  if [[ $sshd_config_permissions != "600" ]]; then
    echo "The permissions on /etc/ssh/sshd_config are not set to 600 (-rw-------)."
  fi
  if [[ $sshd_config_owner != "root:root" ]]; then
    echo "The owner of /etc/ssh/sshd_config is not set to root:root."
  fi
fi

# Prompt user for automated remediation
#if [[ $sshd_config_permissions != "600" ]] || [[ $sshd_config_owner != "root:root" ]]; then
 # read -p "Do you want to automatically remediate the failed compliance checks? (y/n): " choice
  #if [[ $choice == "y" ]]; then
    # Perform automated remediation steps
   # echo "Performing automated remediation..."

    #echo "Running the following commands to set ownership and permissions on /etc/ssh/sshd_config:"
    #echo "# chown root:root /etc/ssh/sshd_config"
#    chown root:root /etc/ssh/sshd_config
 #   echo "# chmod 600 /etc/ssh/sshd_config"
  #  chmod 600 /etc/ssh/sshd_config

   # echo "Automated remediation completed."
 # fi
#fi

