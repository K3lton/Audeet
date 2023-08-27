#!/bin/bash

# Title
echo "Section: 5.2.2
Title: Ensure permissions on SSH private host key files are configured (Automated)"

# Rationale
echo "Rationale:"
echo "An SSH private key is one of two files used in SSH public key authentication. In this authentication method, the possession of the private key is proof of identity. Only a private key that corresponds to a public key will be able to authenticate successfully. The private keys need to be stored and handled carefully, and no copies of the private key should be distributed."
echo

# Compliance
l_output=""
l_skgn="ssh_keys" # Group designated to own openSSH keys
l_skgid="$(awk -F: '($1 == "'"$l_skgn"'"){print $3}' /etc/group)"

while read -r l_file l_mode l_owner l_group l_gid; do
  [ -n "$l_skgid" ] && l_cga="$l_skgn" || l_cga="root"
  [ "$l_gid" = "$l_skgid" ] && l_pmask="0137" || l_pmask="0177"
  l_maxperm="$( printf '%o' "$(( 0777 & ~$l_pmask ))" )"

  if [ "$(( $l_mode & $l_pmask ))" -gt 0 ]; then
    l_output="$l_output\n - File: \"$l_file\" is mode \"$l_mode\" should be mode: \"$l_maxperm\" or more restrictive"
  fi

  if [ "$l_owner" != "root" ]; then
    l_output="$l_output\n - File: \"$l_file\" is owned by: \"$l_owner\" should be owned by \"root\""
  fi

  if [ "$l_group" != "root" ] && [ "$l_gid" != "$l_skgid" ]; then
    l_output="$l_output\n - File: \"$l_file\" is owned by group \"$l_group\" should belong to group \"$l_cga\""
  fi
done <<< "$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat -L -c \"%n %#a %U %G %g\" {} +)"

if [ -z "$l_output" ]; then
  echo -e "Compliance: Pass"
  echo "Explanation:"
  echo "All SSH private host key files have the correct permissions, ownership, and group."
else
  echo -e "Compliance: Fail"
  echo "Explanation:"
  echo -e "$l_output\n"
fi

# Prompt user for automated remediation
#if [ -n "$l_output" ]; then
#  read -p "Do you want to automatically remediate the failed compliance checks? (y/n): " choice
#  if [ "$choice" = "y" ]; then
#    # Perform automated remediation steps
#    echo "Performing automated remediation..."
#    
#    while read -r l_file l_mode l_owner l_group l_gid; do
#      [ -n "$l_skgid" ] && l_cga="$l_skgn" || l_cga="root"
#      [ "$l_gid" = "$l_skgid" ] && l_pmask="0137" || l_pmask="0177"
#      l_maxperm="$( printf '%o' "$(( 0777 & ~$l_pmask ))" )"

#      if [ "$(( $l_mode & $l_pmask ))" -gt 0 ]; then
#        echo " - File: \"$l_file\" is mode \"$l_mode\" changing to mode: \"$l_maxperm\""
#        if [ -n "$l_skgid" ]; then
#          chmod u-x,g-wx,o-rwx "$l_file"
#        else
#          chmod u-x,go-rwx "$l_file"
#        fi
#      fi

#      if [ "$l_owner" != "root" ]; then
#        echo " - File: \"$l_file\" is owned by: \"$l_owner\" changing owner to \"root\""
#        chown root "$l_file"
#      fi

#      if [ "$l_group" != "root" ] && [ "$l_gid" != "$l_skgid" ]; then
#        echo " - File: \"$l_file\" is owned by group \"$l_group\" should belong to group \"$l_cga\""
#        chgrp "$l_cga" "$l_file"
#      fi
#    done <<< "$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat -L -c \"%n %#a %U %G %g\" {} +)"

#    echo "Automated remediation completed."
#  fi


