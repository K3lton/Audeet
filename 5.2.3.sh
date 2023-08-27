#!/bin/bash

# Title
echo "Section: 5.2.3
Title: Ensure permissions on SSH public host key files are configured (Automated)"

# Audit
echo "Audit:"
echo "Command: find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat {} \\;"
echo "Output:"
find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat {} \;
echo

# Rationale
echo "Rationale:"
echo "An SSH public key is one of two files used in SSH public key authentication. In this authentication method, a public key is a key that can be used for verifying digital signatures generated using a corresponding private key. Only a public key that corresponds to a private key will be able to authenticate successfully."
echo

# Compliance
ssh_pub_keys=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub')

if [ -z "$ssh_pub_keys" ]; then
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo "No SSH public host key files were found."
else
  failed_files=()
  while IFS= read -r ssh_pub_key; do
    permissions=$(stat -c "%a" "$ssh_pub_key")
    if [[ "$permissions" != "644" ]]; then
      failed_files+=("$ssh_pub_key")
    fi
  done <<< "$ssh_pub_keys"

  if [ "${#failed_files[@]}" -eq 0 ]; then
    echo -e "Compliance: Pass"
    echo "Explanation:"
    echo "All SSH public host key files have the correct permissions (644)."
  else
    echo -e "Compliance: Fail"
    echo "Explanation:"
    for failed_file in "${failed_files[@]}"; do
      permissions=$(stat -c "%a" "$failed_file")
      echo "The permissions on \"$failed_file\" are set to \"$permissions\". They should be set to 644 (-rw-r--r--)."
    done
  fi
fi

# Prompt user for automated remediation
#if [ "${#failed_files[@]}" -gt 0 ]; then
#  read -p "Do you want to automatically remediate the failed compliance checks? (y/n): " choice
#  if [[ $choice == "y" ]]; then
#    # Perform automated remediation steps
#    echo "Performing automated remediation..."

#    for failed_file in "${failed_files[@]}"; do
#      echo "Running the following commands to set permissions and ownership on \"$failed_file\":"
#      echo "# chmod 644 \"$failed_file\""
#      chmod 644 "$failed_file"
#      echo "# chown root:root \"$failed_file\""
#      chown root:root "$failed_file"
#    done

#    echo "Automated remediation completed."
#  fi
#fi

