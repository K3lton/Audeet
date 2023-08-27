#!/bin/bash

# Title
echo "Section: 5.5.1.1 
Title: Ensure minimum days between password changes is configured (Automated)"

# Configuration file
config_file="/etc/login.defs"

# Evidence
echo "Evidence:"
echo "Command: grep -E '^PASS_MIN_DAYS' $config_file"
echo "Output:"
grep -E '^PASS_MIN_DAYS' "$config_file"
echo

# Rationale
echo "Rationale:"
echo "The PASS_MIN_DAYS parameter in $config_file should be set to 1 or more days to prevent users from changing their password too frequently."
echo

# Compliance
pass_min_days=$(grep -E '^PASS_MIN_DAYS' "$config_file" | awk '{print $2}')
if [[ "$pass_min_days" -ge 1 ]]; then
  echo "Compliance: Pass"
  echo "Explanation:"
  echo "The PASS_MIN_DAYS parameter is set to $pass_min_days, which conforms to the site policy."
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "The PASS_MIN_DAYS parameter is not set to 1 or more days."

  # Prompt user for remediation
  read -r -p "Do you want to remediate this issue? (y/n): " choice
  if [[ "$choice" == [yY] ]]; then
    echo "Remediating..."
    sudo sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 1/' "$config_file"
    echo "Remediation completed."
  else
    echo "No changes have been made."
  fi
fi

echo

# Check user parameters

# Evidence
echo "Evidence - User parameters:"
echo "Command: awk -F : '(/^[^:]+:[^!*]/ && $4 < 1){print $1 " " $4}' /etc/shadow"
echo "Output:"
awk -F : '(/^[^:]+:[^!*]/ && $4 < 1){print $1 " " $4}' /etc/shadow
echo

# Rationale
echo "Rationale:"
echo "The PASS_MIN_DAYS parameter for each user should be 1 or more days to match the configuration in $config_file."
echo

# Compliance
invalid_users=$(awk -F : '(/^[^:]+:[^!*]/ && $4 < 1){print $1}' /etc/shadow)
if [[ -z "$invalid_users" ]]; then
  echo "Compliance: Pass"
  echo "Explanation:"
  echo "All users' PASS_MIN_DAYS conform to the site policy (1 or more days)."
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "The following users have PASS_MIN_DAYS less than 1: $invalid_users"

  # Prompt user for remediation
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
#  if [[ "$choice" == [yY] ]]; then
#    echo "Remediating..."
#    for user in $invalid_users; do
#      sudo chage --mindays 1 "$user"
#    done
#    echo "Remediation completed."
#  else
#    echo "No changes have been made."
#  fi
fi


