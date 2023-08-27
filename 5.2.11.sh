#!/bin/bash

# Check if SSH IgnoreRhosts is enabled
ignorerhosts=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}') " | grep ignorerhosts | awk '{print $2}')
config_ignorerhosts=$(grep -Ei '^\s*IgnoreRhosts\s+no\b' /etc/ssh/sshd_config)

# Full path to sshd command
sshd_command="/usr/sbin/sshd"

# Title
echo "Section: 5.2.11
Title: Ensure SSH IgnoreRhosts is enabled (Automated)"

# Evidence
echo "Evidence:"
echo "Command: $sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep ignorerhosts"
echo "Output:"
echo "$($sshd_command -T -C user=root -C host=\"$(hostname)\" -C addr=\"$(grep $(hostname) /etc/hosts | awk '{print $1}')\" | grep ignorerhosts)"
echo

# Rationale
echo "Rationale:"
echo "Enabling IgnoreRhosts parameter ensures that .rhosts and .shosts files are not used for RhostsRSAAuthentication or HostbasedAuthentication, forcing users to enter a password when authenticating with SSH."
echo

# Compliance
if [[ "$ignorerhosts" == "yes" && -z "$config_ignorerhosts" ]]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "IgnoreRhosts is enabled, which enhances security by preventing the use of .rhosts and .shosts files for authentication."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "IgnoreRhosts is disabled. Enabling IgnoreRhosts enhances security by preventing the use of .rhosts and .shosts files for authentication."
fi

# Prompt user for remediation
#if [[ "$ignorerhosts" != "yes" || -n "$config_ignorerhosts" ]]; then
 # read -p "Do you want to remediate the failed compliance check? (y/n): " choice
#  if [[ "$choice" == "y" ]]; then
    # Perform remediation steps
 #   echo "Performing remediation..."
    
  #  echo "Setting IgnoreRhosts to yes in /etc/ssh/sshd_config"
   # sed -i 's/^#*IgnoreRhosts.*/IgnoreRhosts yes/' /etc/ssh/sshd_config
    
   # echo "IgnoreRhosts has been enabled."

   # echo "Restarting SSH service..."
   # systemctl restart sshd

    #echo "Remediation completed."
 # fi
#fi
#!/bin/bash

# Check if SSH IgnoreRhosts is enabled
ignorerhosts=$(/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}') " | grep ignorerhosts | awk '{print $2}')
config_ignorerhosts=$(grep -Ei '^\s*IgnoreRhosts\s+no\b' /etc/ssh/sshd_config)

