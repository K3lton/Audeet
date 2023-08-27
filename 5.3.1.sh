#!/bin/bash

# Check if sudo or sudo-ldap is installed
sudo_installed=$(dpkg-query -W sudo sudo-ldap > /dev/null 2>&1 && echo "true" || echo "false")

# Full path to dpkg-query command
dpkg_query_command="/usr/bin/dpkg-query"

# Title
echo "Section: 5.3.1 
Title: Ensure sudo is installed (Automated)"

# Evidence
#echo "Evidence:"
#echo "Command: $dpkg_query_command -W sudo sudo-ldap > /dev/null 2>&1 && $dpkg_query_command -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' sudo sudo-ldap | awk '(\$4==\"installed\" && \$NF==\"installed\") {print \"\n\"\"PASS:\"\"\n\"\"Package \"\"\\\"\"\$1\"\\\"\"\" is installed\"\"\n\"}' || echo -e \"\nFAIL:\nneither \\\"sudo\\\" or \\\"sudo-ldap\\\" package is installed\n\""
#echo "Output:"
#if [ "$sudo_installed" == "true" ]; then
#  echo "$($dpkg_query_command -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' sudo sudo-ldap | awk '(\$4=="installed" && \$NF=="installed") {print "\n""PASS:""\n""Package ""\""$1"\""" is installed""\n"}')"
#else
#  echo -e "\nFAIL:\nneither \"sudo\" or \"sudo-ldap\" package is installed\n"
#fi
#echo

echo "Evidence:"
echo "Command: $dpkg_query_command -W sudo sudo-ldap > /dev/null 2>&1 && $dpkg_query_command -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' sudo sudo-ldap | awk '($4==\"installed\" && $NF==\"installed\") {print \"\nPASS:\nPackage \\\"\" $1 \"\\\" is installed\\n\"}' || echo -e \"\nFAIL:\nneither \\\"sudo\\\" or \\\"sudo-ldap\\\" package is installed\n\""
echo "Output:"
if [ "$sudo_installed" == "true" ]; then
  echo "$($dpkg_query_command -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' sudo sudo-ldap | awk '($4=="installed" && $NF=="installed") {print "\nPASS:\nPackage \\\"" $1 "\\\" is installed\\n"}')"
else
  echo -e "\nFAIL:\nneither \"sudo\" or \"sudo-ldap\" package is installed\n"
fi
echo


# Rationale
echo "Rationale:"
echo "sudo allows a permitted user to execute a command as the superuser or another user. It provides a flexible and secure way to manage privileges and access control on systems."
echo

# Compliance
if [ "$sudo_installed" == "true" ]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "The 'sudo' package is installed."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "The 'sudo' or 'sudo-ldap' package is not installed. Install the appropriate package based on the system's requirements."
fi

## Prompt user for remediation
#if [ "$sudo_installed" == "false" ]; then
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
#  if [[ "$choice" == [yY] ]]; then
#    echo "Remediating..."
#    apt install sudo -y
#    echo "Remediation completed."
#  else
#    echo "No changes have been made."
#  fi
#fi

