#! /bin/bash

#clear terminal
clear

#color for font
green="\033[0;32m"
GREEN="\033[0;42m"
red="\033[0;31m"
RED="\033[0;41m"
yellow="\033[0;33m"
YELLOW="\033[0;43m"
clr="\033[0m"

#echo reminder
echo -e "${red}!!! Reminder: Please ensure audit script is run as root user !!!${clr}"
echo -e "${red} !! The audit scripts may take longer to run for those with lesser CPUs and small RAMS !!${clr}\n"
echo -e "\nLegend:\n              Pass: ${GREEN}     ${clr}\n              Fail: ${RED}     ${clr}\nCannot be Accessed: ${YELLOW}     ${clr}\n"

if [ -f /tmp/data.txt ]; then
        rm /tmp/data.txt
fi


# Initialize counters to echo total compliance
total_audit=0
pass_count=0
fail_count=0
Cannot_be_Accessed_count=0

#initialize failed audits
failed_audits=""


#echo audit section,title,compliance status in manual table format
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                              Table for compliance status                                                   |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
echo "|Section  | Title                                                                                       | Compliance Status  |"
echo "|---------|---------------------------------------------------------------------------------------------|------------------  |"
echo "|123456789| Example of the audit section title name                                                     | pass or fail       |"

#########################################################################################################################
#start of CIS section 6 audit
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                6 System Maintenance                                                        |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                             6.1 System File Permissions                                                    |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################

#6.1.1
#define file
file="/etc/passwd"

#Define audit command line to run to check for compliance and use as evidence
audit=$(stat /etc/passwd | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#Define desired permission/access of password file
desired_permission="644"

#Define desired uid of password file
desired_uid=0

#Define desired gid of password file
desire_gid=0

	#check permission,uid,gid
	permission=$(stat -c %a "$file")
	uid=$(stat -c %u "$file")
	gid=$(stat -c %g "$file")
	if [[ "$permission" -eq "$desired_permission" && "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" ]]; then
		echo -e "|6.1.1    | Ensure permissions on /etc/passwd are configured (Automated)                                | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.1.1    | Ensure permissions on /etc/passwd are configured (Automated)                                | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.1.1 "
	fi
#########################################################################################################################
#6.1.2
#Define file
file="/etc/passwd-"

#Define audit command to run and check for compliance using for evidence
audit=$(stat /etc/passwd- | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#Define desired permission/access of file
desired_permission="644"

#Define desired uid of file
desired_uid=0

#Define desired gid of file
desired_gid=0

	#check for permission,uid,gid
	permission=$(stat -c %a "$file")
	uid=$(stat -c %u "$file")
	gid=$(stat -c %g "$file")
	if [[ "$permission" -le "$desired_permission" && "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" ]]; then
		echo -e "|6.1.2    | Ensure permissions on /etc/passwd- are configured (Automated)                               | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
	        echo -e "${RED}|6.1.2    | Ensure permissions on /etc/passwd- are configured (Automated)                               | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.1.2 "
	fi
#########################################################################################################################
#6.1.3
#Define file
file="/etc/group"

#Define audit command to run and check for compliance using for evidence
audit=$(stat /etc/group | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#Define desired permission/access of file
desired_permission="644"

#Define desired uid of file
desired_uid=0

#Define desired gid of file
desired_gid=0

	#check for permission,uid,gid
	permission=$(stat -c %a "$file")
	uid=$(stat -c %u "$file")
	gid=$(stat -c %g "$file")
	if [[ "$permission" -eq "$desired_permission" && "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" ]]; then
		echo -e "|6.1.3    | Ensure permissions on /etc/group are configured (Automated)                                 | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.1.3    | Ensure permissions on /etc/group are configured (Automated)                                 | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.1.3 "
	fi
#########################################################################################################################
#6.1.4
#define file
file="/etc/group-"

#define audit command to run and check for compliance using for evidence
audit=$(stat /etc/group- | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#define desired permission/access of file
desired_permission="644"

#define desired uid of file
desired_uid=0

#define desired gid of file
desired_gid=0

	#check for permission,uid,gid
	permission=$(stat -c %a "$file")
	uid=$(stat -c %u "$file")
	gid=$(stat -c %g "$file")
	if [[ $permission -le "$desired_permission" && "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" ]]; then
		echo -e "|6.1.4    | Ensure permissions on /etc/group- are configured (Automated)                                | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.1.4    | Ensure permissions on /etc/group- are configured (Automated)                                | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.1.4 "
	fi
#########################################################################################################################
#6.1.5
#define file
file="/etc/shadow"

#define audit command to run an check for compliance using for evidence
audit=$(stat /etc/shadow | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#define desired permission/access of file
desired_permission="640"

#define desired uid of file
desired_uid=0

#define desired gid of file
desired_gid=0,42

        #check for permission,uid,gid`
        permission=$(stat -c %a "$file")
        uid=$(stat -c %u "$file")
        gid=$(stat -c %g "$file")
        if [[ $permission -le "$desired_permission" && "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" ]]; then
		echo -e "|6.1.5    | Ensure permissions on /etc/shadow are configured (Automated)                                | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.1.5    | Ensure permissions on /etc/shadow are configured (Automated)                                | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.1.5 "
	fi
#########################################################################################################################
#6.1.6
#define file
file="/etc/shadow-"

#define audit command to run an check for compliance using for evidence
audit=$(stat /etc/shadow- | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#define desired permission/access of file
desired_permission="640"

#define desired uid of file
desired_uid=0

#define desired gid of file
desired_gid=0,42

        #check for permission,uid,gid
        permission=$(stat -c %a "$file")
        uid=$(stat -c %u "$file")
        gid=$(stat -c %g "$file")
	 if [[ $permission -le "$desired_permission" && "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" ]]; then
		echo -e "|6.1.6    | Ensure permissions on /etc/shadow- are configured (Automated)                               | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.1.6    | Ensure permissions on /etc/shadow- are configured (Automated)                               | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.1.6 "
	fi
#########################################################################################################################
#6.1.7
#define file to check
file="/etc/gshadow"

#define audit command to run an check for compliance using for evidence
audit=$(stat /etc/gshadow | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#define desired permission/access of file
desired_permission="640"

#define desired uid of file
desired_uid=0

#define desired gid of file
desired_gid=0,42

        #check for permission,uid,gid
        permission=$(stat -c %a "$file")
        uid=$(stat -c %u "$file")
        gid=$(stat -c %g "$file")
        if [[ $permission -le "$desired_permission" && "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" ]]; then
		echo -e "|6.1.7    | Ensure permissions on /etc/gshadow are configured (Automated)                               | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.1.7    | Ensure permissions on /etc/gshadow are configured (Automated)                               | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.1.7 "
	fi
#########################################################################################################################
#6.1.8
#define file
file="/etc/gshadow-"

#define audit command to run an check for compliance using for evidence
audit=$(stat /etc/gshadow- | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#define desired permission/access of file
desired_permission="640"

#define desired uid of file
desired_uid=0

#define desired gid of file
desired_gid=0,42

        #check for permission,uid,gid
        permission=$(stat -c %a "$file")
        uid=$(stat -c %u "$file")
        gid=$(stat -c %g "$file")
        if [[ $permission -le "$desired_permission" && "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" ]]; then
		echo -e "|6.1.8    | Ensure permissions on /etc/gshadow- are configured (Automated)                              | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.1.8    | Ensure permissions on /etc/gshadow- are configured (Automated)                              | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.1.8 "
	fi
#########################################################################################################################
#6.1.9
# Define the command and capture the output
 audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002)

#check if any world-writable files are found
if [[ -z "$audit" ]]; then
    	echo -e "|6.1.9    | Ensure no world writable files exist (Automated)                                            | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.1.9    | Ensure no world writable files exist (Automated)                                            | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.1.9 "
fi
#########################################################################################################################
#6.1.10
#define audit command
audit=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser)

#check if user has permission to search files and directories
if [[ -z "$audit" ]]; then
	echo -e "|6.1.10   | Ensure no unowned files or directories exist (Automated)                                    | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.1.10   | Ensure no unowned files or directories exist (Automated)                                    | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.1.10 "
fi
#########################################################################################################################
#6.1.11
#define audit command
audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup)

#check if the user has permission to search files or directories
if [[ -z "$audit" ]]; then
	echo -e "|6.1.11   | Ensure no ungrouped files or directories exist (Automated)                                  | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.1.11   | Ensure no ungrouped files or directories exist (Automated)                                  | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.1.11 "
fi
#########################################################################################################################
#6.1.12
#define audit command
audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000)

#check if user has permissions to search and list SUID executables
if [[ -z $audit ]]; then
	echo -e "|6.1.12   | Audit SUID executables (Manual)                                                             | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.1.12   | Audit SUID executables (Manual)                                                             | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.1.12 "
fi
#########################################################################################################################
#6.1.13
#define audit command
audit=$( df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000)

#check if user has permissions to search and list SGID executables
if [[ -z "$audit" ]]; then
	echo -e "|6.1.13   | Audit SGID executables (Manual)                                                             | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.1.13   | Audit SGID executables (Manual)                                                             | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.1.13 "
fi
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                           6.2 Local User and Group Settings                                                |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################
#6.2.1
#define audit command
audit=$(awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd)

#check if /etc/passwd use shadowed passwords
if [[ -z "$audit" ]]; then
	echo -e "|6.2.1    | Ensure accounts in /etc/passwd use shadowed passwords (Automated)                           | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.2.1    | Ensure accounts in /etc/passwd use shadowed passwords (Automated)                           | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.1 "
fi
#########################################################################################################################
#6.2.2
#define audit command
audit=$(awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow)

#check /etc/shadow password fields are not empty
if  [[ -z "$audit" ]]; then
	echo -e "|6.2.2    | Ensure /etc/shadow password fields are not empty (Automated)                                | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.2.2    | Ensure /etc/shadow password fields are not empty (Automated)                                | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.2 "
fi
#########################################################################################################################
#6.2.3
#define audit command/script
audit=$(for i in $(cut -s -d: -f4 /etc/passwd | sort -u); do
	grep -q -P "^.*?:[^:]*:$i:" /etc/group
	if [ $? -ne 0 ]; then
		echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"
	fi
done
)

#check all groups in /etc/passwd exist in /etc/group
if [[ -z "$audit" ]]; then
	echo -e "|6.2.3    | Ensure all groups in /etc/passwd exist in /etc/group (Automated)                            | ${green}Pass${clr}               |"
	((pass_count++))
	((total_audit++))
else
	echo -e "${RED}|6.2.3    | Ensure all groups in /etc/passwd exist in /etc/group (Automated)                            | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.3 "
fi
#########################################################################################################################
#6.2.4
#define audit command
audit1=$(awk -F: '($1=="shadow") {print $NF}' /etc/group)
audit2=$(awk -F: -v GID="$(awk -F: '($1=="shadow") {print $3}' /etc/group)" '($4==GID) {print $1}' /etc/passwd)

#check shadow group is empty
if [[ -z "$audit1" ]]; then
	if [[ -z "$audit2" ]]; then
		echo -e "|6.2.4    | Ensure shadow group is empty (Automated)                                                    | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.2.4    | Ensure shadow group is empty (Automated)                                                    | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.2.4 "
	fi
else
	echo -e "${RED}|6.2.4    | Ensure shadow group is empty (Automated)                                                    | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.4 "
fi
#########################################################################################################################
#6.2.5
#define audit command
audit=$(cut -f3 -d":" /etc/passwd | sort -n | uniq -c | while read x ; do
	[ -z "$x" ] && break
	set - $x
	if [ $1 -gt 1 ]; then
		users=$(awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs)
		echo "Duplicate UID ($2): $users"
	fi
	done
)

#check no duplicate UIDs exist
if [[ -z "$audit" ]]; then
	echo -e "|6.2.5    | Ensure no duplicate UIDs exist (Automated)                                                  | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.2.5    | Ensure no duplicate UIDs exist (Automated)                                                  | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.5 "
fi
#########################################################################################################################
#6.2.6
#define audit command
audit=$(cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do
	echo "Duplicate GID ($x) in /etc/group"
	done
)

#check no duplicate GIDs exist
if [[ -z "$audit" ]]; then
	echo -e "|6.2.6    | Ensure no duplicate GIDs exist (Automated)                                                  | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.2.6    | Ensure no duplicate GIDs exist (Automated)                                                  | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.6 "
fi
#########################################################################################################################
#6.2.7
#audit
audit=$(cut -d: -f1 /etc/passwd | sort | uniq -d | while read -r x; do
	echo "Duplicate login name $x in /etc/passwd"
	done
)

#check no duplicate user names exist
if  [[ -z "$audit" ]]; then
	echo -e "|6.2.7    | Ensure no duplicate user names exist (Automated)                                            | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.2.7    | Ensure no duplicate user names exist (Automated)                                            | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.7 "
fi
#########################################################################################################################
#6.2.8
#audit
audit=$(cut -d: -f1 /etc/group | sort | uniq -d | while read -r x; do
	echo "Duplicate group name $x in /etc/group"
	done
)

#check no duplicate group names exist
if [[ -z "$audit" ]]; then
	echo -e "|6.2.8    | Ensure no duplicate group names exist (Automated)                                           | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.2.8    | Ensure no duplicate group names exist (Automated)                                           | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.8 "
fi
#########################################################################################################################
#6.2.9
#audit
audit=$(
RPCV="$(sudo -Hiu root env | grep '^PATH' | cut -d= -f2)"
echo "$RPCV" | grep -q "::" && echo "root's path contains a empty directory (::)"
echo "$RPCV" | grep -q ":$" && echo "root's path contains a trailing (:)"
for x in $(echo "$RPCV" | tr ":" " "); do
	if [ -d "$x" ]; then
		ls -ldH "$x" |awk '$9 == "." {print "PATH contains current working directory (.)"}
		$3 != "root" {print $9, "is not owned by root"}
		substr($1,6,1) != "-" {print $9, "is group writable"}
		substr($1,9,1) != "-" {print $9, "is world writable"}'
	else
		echo "$x is not a directory"
	fi
done
)

#check root path integrity
if [[ -z "$audit" ]]; then
	echo -e "|6.2.9    | Ensure root PATH Integrity (Automated)                                                      | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.2.9    | Ensure root PATH Integrity (Automated)                                                      | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.9 "
fi
#########################################################################################################################
#6.2.10
#audit
audit=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)

#desired_output
desired_output="root"

#check root is the only UID 0 account
if [[ "$audit" -eq "$desired_output"  ]]; then
	echo -e "|6.2.10   | Ensure root is the only UID 0 account (Automated)                                           | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
	echo -e "${RED}|6.2.10   | Ensure root is the only UID 0 account (Automated)                                           | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="6.2.10 "
fi
#########################################################################################################################
#6.2.11
#check if all local interactive user home directories exist
{
	output=""
        valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
        awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
        [ ! -d "$home" ] && output="$output\n  -User \"$user\" home directory \"$home\" doesn't exist"
done)
        if [ -z "$output" ]; then
		echo -e "|6.2.11   | Ensure local interactive user home directories exist (Automated)                            | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.2.11   | Ensure local interactive user home directories exist (Automated)                            | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.2.11 "
	fi
}
#########################################################################################################################
#6.2.12
#check local interactive users own their own home directories
{
	output=""
	valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
	awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
	owner="$(stat -L -c "%U" "$home")"
	[ "$owner" != "$user" ] && output="$output\n  -User \"$user\" home directory \"$home\" is owned by user \"$owner\""
done)
	if [ -z "$output" ]; then
		echo -e "|6.2.12   | Ensure local interactive users own their home directories (Automated)                       | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	else
		echo -e "${RED}|6.2.12   | Ensure local interactive users own their home directories (Automated)                       | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.2.12 "
	fi
}
#########################################################################################################################
#6.2.13
#check if local interactive user home directories are mode 750 or more restrictive
{
	output=""
	perm_mask='0027'
	maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
	valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
	awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
	if [ -d "$home" ]; then
		mode=$( stat -L -c '%#a' "$home" )
		[ $(( $mode & $perm_mask )) -gt 0 ] && output="$output\n-User $user home directory: \"$home\" is too permissive: \"$mode\" (should be: \"$maxperm\" or more restrictive)"
		fi
	done)
	if [[ -n "$output" ]]; then
		echo -e "${RED}|6.2.13   | Ensure local interactive user home directories are mode 750 or more restrictive (Automated) | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.2.13 "
	else
		echo -e "|6.2.13   | Ensure local interactive user home directories are mode 750 or more restrictive (Automated) | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	fi
}
#########################################################################################################################
#6.2.14
#check no local interactive user has .netrc files
{
	output="" output2=""
	perm_mask='0177'
	maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
	valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
	awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
	if [ -f "$home/.netrc" ]; then
		mode="$( stat -L -c '%#a' "$home/.netrc" )"
		if [ $(( $mode & $perm_mask )) -gt 0 ]; then
			output="$output\n  -User \"$user\" file: \"$home/.netrc\" is too permissive: \"$mode\" (should be: \"$maxperm\" or more restrictive)"
		else
			output2="$output2\n  -User \"$user\" file: \"$home/.netrc\" exists and has file mode: \"$mode\" (should be: \"$maxperm\" or more restrictive)"
		fi
	fi
done)
	if [ -z "$output" ]; then
		if [ -z "$output2" ]; then
			echo -e "|6.2.14   | Ensure no local interactive user has .netrc files (Automated)                               | ${green}Pass${clr}               |"
			((total_audit++))
			((pass_count++))
		else
			echo -e "${RED}|6.2.14   | Ensure no local interactive user has .netrc files (Automated)                               | Fail               |${clr}"
			((total_audit++))
			((fail_count++))
			failed_audits+="6.2.14 "
		fi
	else
		echo -e "${RED}|6.2.14   | Ensure no local interactive user has .netrc files (Automated)                               | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.2.14 "
	fi
}
#########################################################################################################################
#6.2.15
#check no local interactive user has .forward files
{
	output=""
	fname=".forward"
	valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
	awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
	[ -f "$home/$fname" ] && output="$output\n  -User \"$user\" file: \"$home/$fname\" exists"
done)
	if [ -z "$output" ]; then
		echo -e "|6.2.15   | Ensure no local interactive user has .forward files (Automated)                             | ${green}Pass${clr}               |"
		((pass_count++))
		((total_audit++))
	else
		echo -e "${RED}|6.2.15   | Ensure no local interactive user has .forward files (Automated)                             | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.2.15 "
	fi
}
#########################################################################################################################
#6.2.16
#check no local interactive user has .rhosts files
{
	output=""
	fname=".rhosts"
	valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
	awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
	[ -f "$home/$fname" ] && output="$output\n  -User \"$user\" file: \"$home/$fname\" exists"
done)
	if [ -z "$output" ]; then
		echo -e "|6.2.16   | Ensure no local interactive user has .rhosts files (Automated)                              | ${green}Pass${clr}               |"
		((pass_count++))
		((total_audit++))
	else
		echo -e "${RED}|6.2.16   | Ensure no local interactive user has .rhosts files (Automated)                              | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.2.16 "
	fi
}
#########################################################################################################################
#6.2.17
#check local interactive user dot files are not group or world writable
{
	output=""
	perm_mask='0022'
	maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
	valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|'-))$"
	awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
	for dfile in $(find "$home" -type f -name '.*'); do
		mode=$( stat -L -c '%#a' "$dfile" )
		[ $(( $mode & $perm_mask )) -gt 0 ] && output="$output\n-User $user file: \"$dfile\" is too permissive: \"$mode\" (should be: \"$maxperm\" or more restrictive)"
		done
	done)
	if [ -n "$output" ]; then
		echo -e "${RED}|6.2.17   | Ensure local interactive user dot files are not group or world writable (Automated)         | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="6.2.17 "
	else
		echo -e "|6.2.17   | Ensure local interactive user dot files are not group or world writable (Automated)         | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
	fi
}
#########################################################################################################################
#end of CIS section 6 audit
#########################################################################################################################


#echo total compliance
echo -e "|---------|---------------------------------------------------------------------------------------------|--------------------|"
echo -e "                                                                                       Total Audit     :| $total_audit     "
echo -e "                                                                                       Total Compliance:| ${green}Pass${clr} Count: ${green}$pass_count${clr}/$total_audit"
echo -e "                                                                                                        | ${red}Fail${clr} Count: ${red}$fail_count${clr}/$total_audit"
echo -e "                                                                                                        | ${yellow}Cannot be Accessed${clr} Count: ${yellow}$Cannot_be_Accessed_count${clr}/$total_audit"
echo -e "|---------|---------------------------------------------------------------------------------------------|----------------------\n"


echo $pass_count >> /tmp/data.txt
echo $fail_count >> /tmp/data.txt
echo $Cannot_be_Accessed_count >> /tmp/data.txt
echo $total_audit >> /tmp/data.txt
