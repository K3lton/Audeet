#!/bin/bash

# Title
echo "Section: 5.4.1 
Title: Ensure password creation requirements are configured (Automated)"

# Password Length

# Evidence
echo "Evidence:"
echo "Command: grep '^\s*minlen\s*' /etc/security/pwquality.conf"
echo "Output:"
grep '^\s*minlen\s*' /etc/security/pwquality.conf
echo

# Rationale
echo "Rationale:"
echo "Setting password length requirements helps ensure strong passwords and protect systems from brute force attacks."
echo

# Compliance
minlen=$(grep '^\s*minlen\s*' /etc/security/pwquality.conf | awk -F'=' '{print $2}' | tr -d '[:space:]')
if [[ "$minlen" == "14" ]]; then
  echo "Compliance: Pass"
  echo "Explanation:"
  echo "The minimum password length is set to 14 characters."
else
  echo -e "Compliance: \e[31mFail\e[0m"
  echo "Explanation:"
  echo "The minimum password length is not set to 14 characters."

  # Prompt user for remediation
  read -r -p "Do you want to remediate this issue? (y/n): " choice
  if [[ "$choice" == [yY] ]]; then
    echo "Remediating..."
    sudo sed -i 's/^\s*#\?\s*minlen\s*.*/minlen = 14/' /etc/security/pwquality.conf
    echo "Remediation completed."
  else
    echo "No changes have been made."
  fi
fi

echo

# Password Complexity

# Evidence - Option 1
echo "Evidence - Option 1:"
echo "Command: grep '^\s*minclass\s*' /etc/security/pwquality.conf"
echo "Output:"
grep '^\s*minclass\s*' /etc/security/pwquality.conf
echo

# Evidence - Option 2
echo "Evidence - Option 2:"
echo "Command: grep -E '^\s*[duol]credit\s*' /etc/security/pwquality.conf"
echo "Output:"
grep -E '^\s*[duol]credit\s*' /etc/security/pwquality.conf
echo

# Rationale
echo "Rationale:"
echo "Setting password complexity requirements helps ensure strong passwords with a mix of character classes."
echo

# Compliance
minclass=$(grep '^\s*minclass\s*' /etc/security/pwquality.conf | awk -F'=' '{print $2}' | tr -d '[:space:]')
dcredit=$(grep -E '^\s*dcredit\s*' /etc/security/pwquality.conf | awk -F'=' '{print $2}' | tr -d '[:space:]')
ucredit=$(grep -E '^\s*ucredit\s*' /etc/security/pwquality.conf | awk -F'=' '{print $2}' | tr -d '[:space:]')
ocredit=$(grep -E '^\s*ocredit\s*' /etc/security/pwquality.conf | awk -F'=' '{print $2}' | tr -d '[:space:]')
lcredit=$(grep -E '^\s*lcredit\s*' /etc/security/pwquality.conf | awk -F'=' '{print $2}' | tr -d '[:space:]')

if [[ "$minclass" == "4" ]]; then
  echo "Compliance - Option 1: Pass"
  echo "Explanation - Option 1:"
  echo "The minimum number of required character classes for the new password is set to 4."
else
  echo -e "Compliance - Option 1: \e[31mFail\e[0m"
  echo "Explanation - Option 1:"
  echo "The minimum number of required character classes for the new password is not set to 4."

  # Prompt user for remediation
  read -r -p "Do you want to remediate this issue? (y/n): " choice
  if [[ "$choice" == [yY] ]]; then
    echo "Remediating..."
    sudo sed -i 's/^\s*#\?\s*minclass\s*.*/minclass = 4/' /etc/security/pwquality.conf
    echo "Remediation completed."
  else
    echo "No changes have been made."
  fi
fi

if [[ "$dcredit" == "-1" && "$ucredit" == "-1" && "$ocredit" == "-1" && "$lcredit" == "-1" ]]; then
  echo "Compliance - Option 2: Pass"
  echo "Explanation - Option 2:"
  echo "There is at least one occurrence of each character class requirement: digit, uppercase, lowercase, and special character."
else
  echo -e "Compliance - Option 2: \e[31mFail\e[0m"
  echo "Explanation - Option 2:"
  echo "One or more character class requirements are missing."

#  # Prompt user for remediation
#  read -r -p "Do you want to remediate this issue? (y/n): " choice
#  if [[ "$choice" == [yY] ]]; then
#    echo "Remediating..."
#    sudo sed -i 's/^\s*#\?\s*dcredit\s*.*/dcredit = -1/' /etc/security/pwquality.conf
#    sudo sed -i 's/^\s*#\?\s*ucredit\s*.*/ucredit = -1/' /etc/security/pwquality.conf
#    sudo sed -i 's/^\s*#\?\s*ocredit\s*.*/ocredit = -1/' /etc/security/pwquality.conf
#    sudo sed -i 's/^\s*#\?\s*lcredit\s*.*/lcredit = -1/' /etc/security/pwquality.conf
#    echo "Remediation completed."
#  else
#    echo "No changes have been made."
#  fi
fi

