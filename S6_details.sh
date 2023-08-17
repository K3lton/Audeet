#! /bin/bash

#clear terminal
clear

#color font
red="\033[0;31m"
clr="\033[0m"

#function to display in-depth details of the section 6 failed audits
display_failed_audits() {
	#run the section 6 audit script and capture the output
	output=$(./S6_audit.sh)

	#Extract the failed audits from the output
	failed_audits=$(echo "$output" | sed -e 's/\x1B\[[0-9;]*[JKmsu]//g' -e 's/^\s*Fail:\s*//' | awk '/Fail/ && !/Fail Count:/ {print}')

	#Check if there are any failed audits
        if [[ -z  "$failed_audits" ]]; then
                echo "\nNo failed audits found.\n"
                return
        fi


	#Initialize the output file to output the in-depth details
	output_file="S6_in_depth_details.txt"

	#Loop through each failed audit and display in-depth details
	while IFS= read -r audit; do
		#Initialize extraction of value of the "section" from the "audit" output
		#"audit" is a variable that contains lines from the "failed_audits" output
		section=$(echo "$audit" | awk '{sub(/^\|/, ""); print $1}')

		# Customize the output based on the section
                case "$section" in

			"6.1.1")
                #output specific details for 6.1.1
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.1.1 Ensure permissions on /etc/passwd are configured (Automated)\n" | tee -a "$output_file"
                audit611=$(stat /etc/passwd | grep -E 'Access:|Uid:|Gid:' | sed '2d')
                echo -e "Evidence: \n$audit611\n" | tee -a "$output_file"
                echo -e "Rationale: \nIt is critical to ensure that the /etc/passwd file is protected from unauthorized write access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRun the following commands to set ownership and permissions for /etc/passwd:\n1. chown root:root /etc/passwd\n2. chmod u-x,go-wx /etc/passwd\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that UID and GID are both 0/root and Access is 644 for the file /etc/passwd, since the evidence displayed is unable to verify the audit, therefore the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.2")
                #output specific details for 6.1.2
                echo -e "#########################################################################################################################\n" >> "$output_file"
		echo -e "Title: 6.1.2 Ensure permissions on /etc/passwd- are configured (Automated)\n" | tee -a "$output_file"
		audit612=$(stat /etc/passwd- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
		echo -e "Evidence: \n$audit612\n" | tee -a "$output_file"
		echo -e "Rationale: \nIt is critical to ensure that the /etc/passwd- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.\n" | tee -a "$output_file"
		echo -e "Remediation: \nRun the following commands to set ownership and permissions for /etc/passwd-:\n1. chown root:root /etc/passwd-\n2. chmod u-x,go-wx /etc/passwd-\n" | tee -a "$output_file"
		echo -e "Explanation: \nThis audit is to verify that UID and GID are both 0/root and Access is 644 or more restrictive for the file /etc/passwd-, since the evidence displayed is unable to verify the audit, therefore the compliance is a fail.\n" | tee -a "$output_file"
		echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.3")
                #output specific details for 6.1.3
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
		echo -e "Title: 6.1.3 Ensure permissions on /etc/group are configured (Automated)\n" | tee -a "$output_file"
		audit613=$(stat /etc/group | grep -E 'Access:|Uid:|Gid:' | sed '2d')
		echo -e "Evidence: \n$audit613\n" | tee -a "$output_file"
		echo -e "Rationale: \nThe /etc/group file needs to be protected from unauthorized changes by non-privileged users, but needs to be readable as this information is used with many non-privileged programs.\n" | tee -a "$output_file"
		echo -e "Remediation: \nRun the follwing command to set ownership and permissions for /etc/group:\n 1.chown root:root /etc/group\n2. chmod u-x,go-wx /etc/group\n" | tee -a "$output_file"
		echo -e "Explanation: \nThis audit is to verify that UID and GID are both 0/root and Access is 644 for the file /etc/group, since the evidence displayed is unable to verify the audit, therefore the compliance is a fail.\n" | tee -a "$output_file"
		echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.4")
                #output specific details for 6.1.4
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
		echo -e "Title: 6.1.4 Ensure permissions on /etc/group- are configured (Automated)\n" | tee -a "$output_file"
		audit614=$(stat /etc/group- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
		echo -e "Evidence: \n$audit614\n" | tee -a "$output_file"
		echo -e "Rationale: \nIt is critical to ensure that the /etc/group- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.\n" | tee -a "$output_file"
		echo -e "Remediation: \nRun the following command to set ownership and permissions for /etc/group-:\n1. chown root:root /etc/group-\n2. chmod u-x,go-wx /etc/group-\n" | tee -a "$output_file"
		echo -e "Explanation: \nThis audit is to verify that UID and GID are both 0/root and Access is 644 or more restrictive for the file /etc/group-, since the evidence displayed is unable to verify the audit, therefore the compliance is a fail.\n" | tee -a "$output_file"
		echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.5")
                #output specific details for 6.1.5
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.1.5 Ensure permissions on /etc/shadow are configured (Automated)\n" | tee -a "$output_file"
		audit615=$(stat /etc/shadow | grep -E 'Access:|Uid:|Gid:' | sed '2d')
                echo -e "Evidence: \n$audit615\n" | tee -a "$output_file"
                echo -e "Rationale: \nIf attackers can gain read access to the /etc/shadow file, they can easily run a password cracking program against the hashed password to break it. Other security information that is stored in the /etc/shadow file (such as expiration) could also be useful to subvert the user accounts.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRun the following command to set ownership and permissions for /etc/shadow:\n1. chown root:root /etc/shadow\n2. chown root:shadow /etc/shadow\n3. chmod u-x,g-wx,o-rwx /etc/shadow\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that UID is 0/root, GID is 0/root or <gid>/shadow, and Access is 640 or more restrictive for the file /etc/shadow, since the evidence displayed is unable to verify the audit, therefore the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.6")
                #output specific details for 6.1.6
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.1.6 Ensure permissions on /etc/shadow- are configured (Automated)\n" | tee -a "$output_file"
		audit616=$(stat /etc/shadow- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
                echo -e "Evidence: \n$audit616\n" | tee -a "$output_file"
                echo -e "Rationale: \nIt is critical to ensure that the /etc/shadow- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRun the following command to set ownership and permissions for /etc/shadow-:\n1. chown root:root /etc/shadow-\n2. chown root:shadow /etc/shadow-\n3. chmod u-x,g-wx,o-rwx /etc/shadow-\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that UID is 0/root, GID is 0/root or <gid>/shadow, and Access is 640 or more restrictive for the file /etc/shadow-, since the evidence displayed is unable to verify the audit, therefore the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.7")
                #output specific details for 6.1.7
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.1.7 Ensure permissions on /etc/gshadow are configured (Automated)\n" | tee -a "$output_file"
		audit617=$(stat /etc/gshadow | grep -E 'Access:|Uid:|Gid:' | sed '2d')
                echo -e "Evidence: \n$audit617\n" | tee -a "$output_file"
                echo -e "Rationale: \nIf attackers can gain read access to the /etc/gshadow file, they can easily run a password cracking program against the hashed password to break it. Other security information that is stored in the /etc/gshadow file (such as group administrators) could also be useful to subvert the group.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRun the following commands to set ownership and permissions for /etc/gshadow:\n1. chown root:root /etc/gshadow\n2. chown root:shadow /etc/gshadow\n3. chmod u-x,g-wx,o-rwx /etc/gshadow\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that UID is 0/root, GID is 0/root or <gid>/shadow, and Access is 640 or more restrictive for the file /etc/gshadow, since the evidence displayed is unable to verify the audit, therefore the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.8")
                #output specific details for 6.1.8
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title:  6.1.8 Ensure permissions on /etc/gshadow- are configured (Automated)\n" | tee -a "$output_file"
		audit618=$(stat /etc/gshadow- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
                echo -e "Evidence: \n$audit618\n" | tee -a "$output_file"
                echo -e "Rationale: \nIt is critical to ensure that the /etc/gshadow- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRun the following commands to set ownership and permissions for /etc/gshadow-:\n1. chown root:root /etc/gshadow-\n2. chown root:shadow /etc/gshadow-\n3. chmod u-x,g-wx,o-rwx /etc/gshadow-\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that UID is 0/root, GID is 0/root or <gid>/shadow, and Access is 640 or more restrictive for the file /etc/gshadow-, since the evidence displayed is unable to verify the audit, therefore the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.9")
                #output specific details for 6.1.9
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.1.9 Ensure no world writable files exist (Automated)\n" | tee -a "$output_file"
		audit619=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002)
                echo -e "Evidence: \n$audit619\n" | tee -a "$output_file"
                echo -e "Rationale: \nData in world-writable files can be modified and compromised by any user on the system. World writable files may also indicate an incorrectly written script or program that could potentially be the cause of a larger compromise to the system's integrity.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRun the following command to remove write access for the 'other' category:\n1. chmod o-w <filename>\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that there are no world-writable files in the system, since the evidence displayed return files that are world-writable, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.10")
                #output specific details for 6.1.10
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.1.10 Ensure no unowned files or directories exist (Automated)\n" | tee -a "$output_file"
		audit6110=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser)
		echo -e "Evidence: \n$audit6110\n" | tee -a "$output_file"
                echo -e "Rationale: \nA new user who is assigned the deleted user's user ID or group ID may then end up "owning" these files, and thus have more access on the system than was intended.\n" | tee -a "$output_file"
                echo -e "Remediation: \nLocate files that are owned by users or groups not listed in the system configuration files, and reset the ownership of these files to some active user on the system as appropriate.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that there are no unowned files or directories in the system, since the evidence displayed return files or directories that are unowned, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
		;;

		"6.1.11")
                #output specific details for 6.1.11
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.1.11 Ensure no ungrouped files or directories exist (Automated)\n" | tee -a "$output_file"
		audit6111=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup)
                echo -e "Evidence: \n$audit6111\n" | tee -a "$output_file"
                echo -e "Rationale: \nA new user who is assigned the deleted user's user ID or group ID may then end up "owning" these files, and thus have more access on the system than was intended.\n" | tee -a "$output_file"
                echo -e "Remediation: \nLocate files that are owned by users or groups not listed in the system configuration files, and reset the ownership of these files to some active user on the system as appropriate.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that there are no ungrouped files or directories in the system, since the evidence displayed return files or directories that are ungrouped, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;


                "6.1.12")
                # Output specific details for 6.1.12
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.1.12 Audit SUID executables (Manual)\n" | tee -a "$output_file"
                audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000)
                echo -e "Evidence: \n$audit\n" | tee -a "$output_file"
                echo -e "Rationale: \nThere are valid reasons for SUID programs, but it is important to identify and review such programs to ensure they are legitimate.\n" | tee -a "$output_file"
                echo -e "Remediation: \nEnsure that no rogue SUID programs have been introduced into the system. Review the files returned by the action in the Audit section and confirm the integrity of these binaries.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify if there are any SUID executables in the system, since the evidence displayed return SUID executables, therefore there is a need to identify and review them to ensure that they are legitimate and compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                "6.1.13")
                # Output specific details for 6.1.13
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.1.13 Audit SGID executables (Manual)\n" | tee -a "$output_file"
                audit=$( df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000)
                echo -e "Evidence: \n$audit\n" | tee -a "$output_file"
                echo -e "Rationale: \nThere are valid reasons for SGID programs, but it is important to identify and review such programs to ensure they are legitimate. Review the files returned by the action in the audit section and check to see if system binaries have a different md5 checksum than what from the package. This is an indication that the binary may have been replaced.\n" | tee -a "$output_file"
                echo -e "Remediation: \nEnsure that no rogue SGID programs have been introduced into the system. Review the files returned by the action in the Audit section and confirm the integrity of these binaries.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to veriy if there are any SGID executables, since the evidencce displayed return SGID executables, therefore there is a need to identify and review them to ensure that they are legitimate and compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.1")
                #output specific details for 6.2.1
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.1 Ensure accounts in /etc/passwd use shadowed passwords (Automated)\n" | tee -a "$output_file"
		audit621=$(awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd)
                echo -e "Evidence: \n$audit621\n" | tee -a "$output_file"
                echo -e "Rationale: \nThe /etc/passwd file also contains information like user ID's and group ID's that are used by many system programs. Therefore, the /etc/passwd file must remain world readable. In spite of encoding the password with a randomly-generated one-way hash function, an attacker could still break the system if they got access to the /etc/passwd file. This can be mitigated by using shadowed passwords, thus moving the passwords in the /etc/passwd file to /etc/shadow. The /etc/shadow file is set so only root will be able to read and write. This helps mitigate the risk of an attacker gaining access to the encoded passwords with which to perform a dictionary attack.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRun the following command to set accounts to use shadowed  passwords:\n1. sed -e 's/^\([a-zA-Z0-9_]*\):[^:]*:/\1:x:/' -i /etc/passwd\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that accounts in /etc/passwd use shadowed passwords, since the evidence displayed return accounts that do no use shadowed passwords, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.2")
                #output specific details for 6.2.2
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.2 Ensure /etc/shadow password fields are not empty (Automated)\n" | tee -a "$output_file"
		audit622=$(awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow)
                echo -e "Evidence: \n$audit622\n" | tee -a "$output_file"
                echo -e "Rationale: \nAll accounts must have passwords or be locked to prevent the account from being used by an unauthorized user.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRun the following command to lock the account until it can be determined why it does not have a password and set password for account:\n1. passwd -l <username>\n2. passwd <username>\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that /etc/shadow password fields are not empty, since the evidence displayed return that there is an empty password field in /etc/shadow, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.3")
                #output specific details for 6.2.3
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.3 Ensure all groups in /etc/passwd exist in /etc/group (Automated)\n" | tee -a "$output_file"
		audit623=$(for i in $(cut -s -d: -f4 /etc/passwd | sort -u); do
	grep -q -P "^.*?:[^:]*:$i:" /etc/group
	if [ $? -ne 0 ]; then
		echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"
	fi
done)
                echo -e "Evidence: \n$audit623\n" | tee -a "$output_file"
                echo -e "Rationale: \nGroups defined in the /etc/passwdfile but not in the /etc/groupfile pose a threat to system security since group permissions are not properly managed.\n" | tee -a "$output_file"
                echo -e "Remediation: \nAnalyze the output of the Audit in "Evidence" step above and perform the appropriate action to correct any discrepancies found.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that all groups in /etc/passwd exist in /etc/group, since the evidence displayed return that there is/are groups in /etc/passwd that do no exist in /etc/group, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.4")
                #output specific details for 6.2.4
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.4 Ensure shadow group is empty (Automated)\n" | tee -a "$output_file"
		audit6241=$(awk -F: '($1=="shadow") {print $NF}' /etc/group)
		audit6242=$(awk -F: -v GID="$(awk -F: '($1=="shadow") {print $3}' /etc/group)" '($4==GID) {print $1}' /etc/passwd)
                echo -e "Evidence: \n$audit6241\n$audit6242\n" | tee -a "$output_file"
                echo -e "Rationale: \nAny users assigned to the shadow group would be granted read access to the /etc/shadow file. If attackers can gain read access to the /etc/shadow file, they can easily run a password cracking program against the hashed passwords to break them. Other security information that is stored in the /etc/shadow file (such as expiration) could also be useful to subvert additional user accounts.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRun the following commands to remove all user from the shadow group / change the primary group of any users with shadow as their primary group:\n1. sed -ri 's/(^shadow:[^:]*:[^:]*:)([^:]+$)/\1/' /etc/group\n2. usermod -g <primary group> <user>\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that the shadow group is empty, since the evidence displayed return users in the shadow group, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.5")
                #output specific details for 6.2.5
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.5 Ensure no duplicate UIDs exist (Automated)\n" | tee -a "$output_file"
		audit625=$(cut -f3 -d":" /etc/passwd | sort -n | uniq -c | while read x ; do
	[ -z "$x" ] && break
	set - $x
	if [ $1 -gt 1 ]; then
		users=$(awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs)
		echo "Duplicate UID ($2): $users"
	fi
	done)
                echo -e "Evidence: \n$audit625\n" | tee -a "$output_file"
                echo -e "Rationale: \nUsers must be assigned unique UIDs for accountability and to ensure appropriate access protections.\n" | tee -a "$output_file"
                echo -e "Remediation: \nBased on the results of the audit script, establish unique UIDs and review all files owned by the shared UIDs to determine which UID they are supposed to belong to.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that no duplicate UIDs exist, since the evidence displayed return duplicated UIDs, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.6")
                #output specific details for 6.2.6
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.6 Ensure no duplicate GIDs exist (Automated)\n" | tee -a "$output_file"
		audit626=$(cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do
	echo "Duplicate GID ($x) in /etc/group"
	done)
                echo -e "Evidence: \n$audit626\n" | tee -a "$output_file"
                echo -e "Rationale: \nUser groups must be assigned unique GIDs for accountability and to ensure appropriate access protections.\n" | tee -a "$output_file"
                echo -e "Remediation: \nBased on the results of the audit script, establish unique GIDs and review all files owned by the shared GID to determine which group they are supposed to belong to. Run the grpck command to check for other inconsistencies in the /etc/group file.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that no duplicate GIDs exist, since the evidece displayed return duplicate GIDs, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.7")
                #output specific details for 6.2.7
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.7 Ensure no duplicate user names exist (Automated)\n" | tee -a "$output_file"
		audit627=$(cut -d: -f1 /etc/passwd | sort | uniq -d | while read -r x; do
	echo "Duplicate login name $x in /etc/passwd"
	done)
                echo -e "Evidence: \n$audit627\n" | tee -a "$output_file"
                echo -e 'Rationale: \nIf a user is assigned a duplicate user name, it will create and have access to files with the first UID for that username in /etc/passwd. For example, if "test4" has a UID of 1000 and a subsequent "test4" entry has a UID of 2000, logging in as "test4" will use UID 1000. Effectively, the UID is shared, which is a security problem.\n' | tee -a "$output_file"
                echo -e "Remediation: \nBased on the results of the audit script, establish unique user names for the users. File ownerships will automatically reflect the change as long as the users have unique UIDs.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that no duplicate user name exist, since the evidence displayed return duplicate user names, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.8")
                #output specific details for 6.2.8
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.8 Ensure no duplicate group names exist (Automated)\n" | tee -a "$output_file"
		audit628=$(cut -d: -f1 /etc/group | sort | uniq -d | while read -r x; do
	echo "Duplicate group name $x in /etc/group"
	done)
                echo -e "Evidence: \n$audit628\n" | tee -a "$output_file"
                echo -e "Rationale: \nIf a group is assigned a duplicate group name, it will create and have access to files with the first GID for that group in /etc/group. Effectively, the GID is shared, which is a security problem.\n" | tee -a "$output_file"
                echo -e "Remediation: \nBased on the results of the audit script, establish unique names for the user groups. File group ownerships will automatically reflect the change as long as the groups have unique GIDs.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that no duplicate group names exist, since the evidence displayed return duplicate group names, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.9")
                #output specific details for 6.2.9
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.9 Ensure root PATH Integrity (Automated)\n" | tee -a "$output_file"
		audit629=$(
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
done)
                echo -e "Evidence: \n$audit629\n" | tee -a "$output_file"
                echo -e "Rationale: \nIncluding the current working directory (.) or other writable directory in root's executable path makes it likely that an attacker can gain superuser access by forcing an administrator operating as rootto execute a Trojan horse program.\n" | tee -a "$output_file"
                echo -e "Remediation: \nCorrect or justify any items discovered in the Audit step.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify the root PATH integrity , since the evidence displayed return variables deemed missing or insecure in the PATH, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.10")
                #output specific details for 6.2.10
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.10 Ensure root is the only UID 0 account (Automated)\n" | tee -a "$output_file"
		audit6210=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)
                echo -e "Evidence: \n$audit6210\n" | tee -a "$output_file"
                echo -e "Rationale: \nThis access must be limited to only the default rootaccount and only from the system console. Administrative access must be through an unprivileged account using an approved mechanism as noted in Item 5.6 Ensure access to the su command is restricted.\n" | tee -a "$output_file"
                echo -e "Remediation: \nRemove any users other than rootwith UID 0or assign them a new UID if appropriate.\n" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify root is the only UID 0 account, since the evidence displayed return not only root account, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.11")
                #output specific details for 6.2.11
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.11 Ensure local interactive user home directories exist (Automated)\n" | tee -a "$output_file"
		audit6211=$(
{
        output=""
        valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
        awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
        [ ! -d "$home" ] && output="$output\n  -User \"$user\" home directory \"$home\" doesn't exist"
        done
	echo "$output"
)
}
)
                echo -e "Evidence: \n$audit6211\n" | tee -a "$output_file"
                echo -e "Rationale: \nIf the user's home directory does not exist or is unassigned, the user will be placed in "/" and will not be able to write any files or have local environment variables set.\n" | tee -a "$output_file"
                echo -e "Remediation: \nThe following script will create a home directory for users with an interactive shell whose home directory doesn't exist:\n" | tee -a "$output_file"
		echo '#!/usr/bin/env bash' | tee -a "$output_file"
		echo '{' | tee -a "$output_file"
		echo '    valid_shells="^($(sed -rn '\''/^\//{s,/,\\\\/,g;p}'\'' /etc/shells | paste -s -d '\''|'\'' -))$"' | tee -a "$output_file"
		echo '    awk -v pat="$valid_shells" -F: '\''$(NF) ~ pat { print $1 " " $(NF-1) }'\'' /etc/passwd | while read -r user home; do' | tee -a "$output_file"
		echo '        if [ ! -d "$home" ]; then' | tee -a "$output_file"
		echo '            echo -e "\n-User \"$user\" home directory \"$home\" doesn'\''t exist\n-creating home directory \"$home\"\n"' | tee -a "$output_file"
		echo '            mkdir "$home"' | tee -a "$output_file"
		echo '            chmod g-w,o-wrx "$home"' | tee -a "$output_file"
		echo '            chown "$user" "$home"' | tee -a "$output_file"
		echo '        fi' | tee -a "$output_file"
		echo '    done' | tee -a "$output_file"
		echo '}' | tee -a "$output_file"
		echo "" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify local interactive user home directories exist, since the evidence displayed return local interactive users without home directories, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.12")
                #output specific details for 6.2.12
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.12 Ensure local interactive users own their home directories (Automated)\n" | tee -a "$output_file"
		audit6212=$(
		{
	output=""
	valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
	awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
	owner="$(stat -L -c "%U" "$home")"
	[ "$owner" != "$user" ] && output="$output\n  -User \"$user\" home directory \"$home\" is owned by user \"$owner\""
	done
	echo "$output"
)
}
)
                echo -e "Evidence: \n$audit6212\n" | tee -a "$output_file"
                echo -e "Rationale: \nSince the user is accountable for files stored in the user home directory, the user must be the owner of the directory.\n" | tee -a "$output_file"
                echo -e "Remediation: \nChange the ownership of any home directories that are not owned by the defined user to the correct user. The following script will update local interactive user home directories to be own by the user:\n" | tee -a "$output_file"
		echo '#!/usr/bin/env bash' | tee -a "$output_file"
		echo '{' | tee -a "$output_file"
		echo '    output=""' | tee -a "$output_file"
		echo '    valid_shells="^($( sed -rn '\''/^\//{s,/,\\\\/,g;p}'\'' /etc/shells | paste -s -d '\''|'\'' -))$"' | tee -a "$output_file"
		echo '    awk -v pat="$valid_shells" -F: '\''$(NF) ~ pat { print $1 " " $(NF-1) }'\'' /etc/passwd | while read -r user home; do' | tee -a "$output_file"
		echo '        owner="$(stat -L -c "%U" "$home")"' | tee -a "$output_file"
		echo '        if [ "$owner" != "$user" ]; then' | tee -a "$output_file"
		echo '            echo -e "\n-User \"$user\" home directory \"$home\" is owned by user \"$owner\"\n  -changing ownership to \"$user\"\n"' | tee -a "$output_file"
		echo '            chown "$user" "$home"' | tee -a "$output_file"
		echo '        fi' | tee -a "$output_file"
		echo '    done' | tee -a "$output_file"
		echo '}' | tee -a "$output_file"
		echo "" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify local interactive users own their home directories, since the evidence displayed return directories not owned by their local interactive user, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.13")
                #output specific details for 6.2.13
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.13 Ensure local interactive user home directories are mode 750 or more restrictive (Automated)\n" | tee -a "$output_file"
		audit6213=$(
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
	done
	echo "$output"
)
}
)
                echo -e "Evidence: \n$audit6213\n" | tee -a "$output_file"
                echo -e "Rationale: \nWhile the system administrator can establish secure permissions for users' home directories, the users can easily override these.\n" | tee -a "$output_file"
                echo -e "Remediation: \nMaking global modifications to user home directories without alerting the user community can result in unexpected outages and unhappy users. Therefore,it is recommended that a monitoring policy be established to report user file permissions and determine the action to be taken in accordance with site policy.The following script can be used to remove permissions is excess of 750from interactive user home directories:\n" | tee -a "$output_file"
		echo '#!/usr/bin/env bash' | tee -a "$output_file"
		echo '{' | tee -a "$output_file"
		echo '    perm_mask='\''0027'\''' | tee -a "$output_file"
		echo '    maxperm="$( printf '\''%o'\'' $(( 0777 & ~$perm_mask)) )"' | tee -a "$output_file"
		echo '    valid_shells="^($( sed -rn '\''/^\//{s,/,\\\\/,g;p}'\'' /etc/shells | paste -s -d '\''|'\'' -))$"' | tee -a "$output_file"
		echo '    awk -v pat="$valid_shells" -F: '\''$(NF) ~ pat { print $1 " " $(NF-1) }'\'' /etc/passwd | (while read -r user home; do' | tee -a "$output_file"
		echo '        mode=$( stat -L -c '\''%#a'\'' "$home" )' | tee -a "$output_file"
		echo '        if [ $(( $mode & $perm_mask )) -gt 0 ]; then' | tee -a "$output_file"
		echo '            echo -e "-modifying User $user home directory: \"$home\"\n-removing excessive permissions from current mode of \"$mode\""' | tee -a "$output_file"
		echo '            chmod g-w,o-rwx "$home"' | tee -a "$output_file"
		echo '        fi' | tee -a "$output_file"
		echo '    done)' | tee -a "$output_file"
		echo '}' | tee -a "$output_file"
		echo "" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that local interactive user home directories are mode 750 or more restrictive, since the evidence displayed return user home directories that are less restrictive than mode 750, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.14")
                #output specific details for 6.2.14
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.14 Ensure no local interactive user has .netrc files (Automated)\n" | tee -a "$output_file"
		audit6214=$(
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
	done
	echo -e "$output\n$output2"
)
}
)
                echo -e "Evidence: \n$audit6214\n" | tee -a "$output_file"
                echo -e "Rationale: \nThe .netrcfile presents a significant security risk since it stores passwords in unencrypted form. Even if FTP is disabled, user accounts may have brought over .netrcfiles from other systems which could pose a risk to those systems.If a .netrcfile is required, and follows local site policy, it should have permissions of 600or more restrictive.\n" | tee -a "$output_file"
                echo -e "Remediation: \nMaking global modifications to users' files without alerting the user community can result in unexpected outages and unhappy users. Therefore, it is recommended that a monitoring policy be established to report user .netrcfile permissions and determine the action to be taken in accordance with local site policy.The following script will remove .netrcfiles from interactive users' home directories:\n" | tee -a "$output_file"
		echo '#!/usr/bin/env bash' | tee -a "$output_file"
		echo '{' | tee -a "$output_file"
		echo '    perm_mask='\''0177'\''' | tee -a "$output_file"
		echo '    valid_shells="^($( sed -rn '\''/^\//{s,/,\\\\/,g;p}'\'' /etc/shells | paste -s -d '\''|'\'' -))$"' | tee -a "$output_file"
		echo '    awk -v pat="$valid_shells" -F: '\''$(NF) ~ pat { print $1 " " $(NF-1) }'\'' /etc/passwd | while read -r user home; do' | tee -a "$output_file"
		echo '        if [ -f "$home/.netrc" ]; then' | tee -a "$output_file"
		echo '            echo -e "\n-User \"$user\" file: \"$home/.netrc\" exists\n -removing file: \"$home/.netrc\"\n"' | tee -a "$output_file"
		echo '            rm -f "$home/.netrc"' | tee -a "$output_file"
		echo '        fi' | tee -a "$output_file"
		echo '    done' | tee -a "$output_file"
		echo '}' | tee -a "$output_file"
		echo "" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that no local interactive user has .netrc files, since the evidence displayed return the permission and that the .netrc file exist in the users' home directory, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.15")
                #output specific details for 6.2.15
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.15 Ensure no local interactive user has .forward files (Automated)\n" | tee -a "$output_file"
		audit6215=$(
		{
	output=""
	fname=".forward"
	valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
	awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
	[ -f "$home/$fname" ] && output="$output\n  -User \"$user\" file: \"$home/$fname\" exists"
	done
	echo "$output"
)
}
)
                echo -e "Evidence: \n$audit6215\n" | tee -a "$output_file"
                echo -e "Rationale: \nUse of the .forwardfile poses a security risk in that sensitive data may be inadvertently transferred outside the organization. The .forwardfile also poses a risk as it can be used to execute commands that may perform unintended actions.\n" | tee -a "$output_file"
                echo -e "Remediation: \nMaking global modifications to users' files without alerting the user community can result in unexpected outages and unhappy users. Therefore, it is recommended that a monitoring policy be established to report user .forward files and determine the action to be taken in accordance with site policy.The following script will remove .forward files from interactive users' home directories:\n" | tee -a "$output_file"
		echo '#!/usr/bin/env bash' | tee -a "$output_file"
		echo '{' | tee -a "$output_file"
		echo '    output=""' | tee -a "$output_file"
		echo '    fname=".forward"' | tee -a "$output_file"
		echo '    valid_shells="^($( sed -rn '\''/^\//{s,/,\\\\/,g;p}'\'' /etc/shells | paste -s -d '\''|'\'' -))$"' | tee -a "$output_file"
		echo '    awk -v pat="$valid_shells" -F: '\''$(NF) ~ pat { print $1 " " $(NF-1) }'\'' /etc/passwd | (while read -r user home; do' | tee -a "$output_file"
		echo '        if [ -f "$home/$fname" ]; then' | tee -a "$output_file"
		echo '            echo -e "$output\n-User \"$user\" file: \"$home/$fname\" exists\n  -removing file: \"$home/$fname\"\n"' | tee -a "$output_file"
		echo '            rm -r "$home/$fname"' | tee -a "$output_file"
		echo '        fi' | tee -a "$output_file"
		echo '    done)' | tee -a "$output_file"
		echo '}' | tee -a "$output_file"
		echo "" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that no local interactive user has .forward files, since the evidence displayed return .forward file exist, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.16")
                #output specific details for 6.2.16
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.16 Ensure no local interactive user has .rhosts files (Automated)\n" | tee -a "$output_file"
		audit6216=$(
		{
	output=""
	fname=".rhosts"
	valid_shells="^($( sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"
	awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (while read -r user home; do
	[ -f "$home/$fname" ] && output="$output\n  -User \"$user\" file: \"$home/$fname\" exists"
	done
	echo "$output"
)
}
)
                echo -e "Evidence: \n$audit6216\n" | tee -a "$output_file"
                echo -e "Rationale: \nThis action is only meaningful if .rhostssupport is permitted in the file /etc/pam.conf. Even though the .rhostsfiles are ineffective if support is disabled in /etc/pam.conf, they may have been brought over from other systems and could contain information useful to an attacker for those other systems.\n" | tee -a "$output_file"
                echo -e "Remediation: \nMaking global modifications to users' files without alerting the user community can result in unexpected outages and unhappy users. Therefore, it is recommended that a monitoring policy be established to report user .rhostsfiles and determine the action to be taken in accordance with site policy.The following script will remove .rhostsfiles from interactive users' home directories:\n" | tee -a "$output_file"
		echo '#!/usr/bin/env bash' | tee -a "$output_file"
		echo '{' | tee -a "$output_file"
		echo '    perm_mask='\''0177'\''' | tee -a "$output_file"
		echo '    valid_shells="^($( sed -rn '\''/^\//{s,/,\\\\/,g;p}'\'' /etc/shells | paste -s -d '\''|'\'' -))$"' | tee -a "$output_file"
		echo '    awk -v pat="$valid_shells" -F: '\''$(NF) ~ pat { print $1 " "$(NF-1) }'\'' /etc/passwd | while read -r user home; do' | tee -a "$output_file"
		echo '        if [ -f "$home/.rhosts" ]; then' | tee -a "$output_file"
		echo '            echo -e "\n-User \"$user\" file: \"$home/.rhosts\" exists\n -removing file: \"$home/.rhosts\"\n"' | tee -a "$output_file"
		echo '            rm -f "$home/.rhosts"' | tee -a "$output_file"
		echo '        fi' | tee -a "$output_file"
		echo '    done' | tee -a "$output_file"
		echo '}' | tee -a "$output_file"
		echo "" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that no local interactive user has .rhosts files, since the evidence displayed return .rhosts files exist, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

		"6.2.17")
                #output specific details for 6.2.17
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                echo -e "Title: 6.2.17 Ensure local interactive user dot files are not group or world writable (Automated)\n" | tee -a "$output_file"
		audit6217=$(
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
	done
	echo "$output"
)
}
)
                echo -e "Evidence: \n$audit6217\n" | tee -a "$output_file"
                echo -e "Rationale: \nGroup or world-writable user configuration files may enable malicious users to steal or modify other users' data or to gain another user's system privileges.\n" | tee -a "$output_file"
                echo -e "Remediation: \nMaking global modifications to users' files without alerting the user community can result in unexpected outages and unhappy users. Therefore, it is recommended that a monitoring policy be established to report user dot file permissions and determine the action to be taken in accordance with site policy.The following script will remove excessive permissions on dotfiles within interactive users' home directories:\n" | tee -a "$output_file"
		echo '#!/usr/bin/env bash' | tee -a "$output_file"
		echo '{' | tee -a "$output_file"
		echo '    perm_mask='\''0022'\''' | tee -a "$output_file"
		echo '    valid_shells="^($( sed -rn '\''/^\//{s,/,\\\\/,g;p}'\'' /etc/shells | paste -s -d '\''|'\'' -))$"' | tee -a "$output_file"
		echo '    awk -v pat="$valid_shells" -F: '\''$(NF) ~ pat { print $1 " " $(NF-1) }'\'' /etc/passwd | while read -r user home; do' | tee -a "$output_file"
		echo '        find "$home" -type f -name '\''.*'\'' | while read -r dfile; do' | tee -a "$output_file"
		echo '            mode=$( stat -L -c '\''%#a'\'' "$dfile" )' | tee -a "$output_file"
		echo '            if [ $(( $mode & $perm_mask )) -gt 0 ]; then' | tee -a "$output_file"
		echo '                echo -e "\n-Modifying User \"$user\" file: \"$dfile\"\n-removing group and other write permissions"' | tee -a "$output_file"
		echo '                chmod go-w "$dfile"' | tee -a "$output_file"
		echo '            fi' | tee -a "$output_file"
		echo '        done' | tee -a "$output_file"
		echo '    done' | tee -a "$output_file"
		echo '}' | tee -a "$output_file"
		echo "" | tee -a "$output_file"
                echo -e "Explanation: \nThis audit is to verify that local interactive user dot files are not group or world writable , since the evidence displayed return user dot file is too permissive, therefore the evidence is unable to verify the audit and the compliance is a fail.\n" | tee -a "$output_file"
                echo -e "#########################################################################################################################\n" | tee -a "$output_file"
                ;;

                *)
			
			;;
			

                esac


            done <<< "$failed_audits"
}

# Call the function to display failed audits and prompt the user
display_failed_audits
