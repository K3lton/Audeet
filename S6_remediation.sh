#! /bin/bash

#clear terminal
clear

#color font
green="\033[0;32m"
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

	#Initialize counter for remediation section completed
	remediation_complete=""

	#Initialize counter for remediation section incomplete
	#for sections that require manual remediation or scripts to be run to remediate
	remediation_incomplete=""

        #Loop through each failed audit and display in-depth details
        while IFS= read -r audit; do
                #Initialize extraction of value of the "section" from the "audit" output
                #"audit" is a variable that contains lines from the "failed_audits" output
                section=$(echo "$audit" | awk '{sub(/^\|/, ""); print $1}')

		#Initialize counter for remediation section completed
		#remediation_complete=""

		#Initialize counter for remediation section incomplete
		#for sections that require manual remediation or scripts to be run to remediate
		#remediation_incomplete=""

		#Customize the output based on the section
		case "$section" in

			"6.1.1")
				#Run commands to remediate 6.1.1
				chown root:root /etc/passwd
				#Initial permission comamnd: chmod u-x,go-wx /etc/passwd
				#For better understanding and make it more straight forward
				chmod 644 /etc/passwd
				remediation_complete+="6.1.1\n"
				;;

			"6.1.2")
				#Run commands to remediate 6.1.2
				chown root:root /etc/passwd-
				#Initial permission comamnd: chmod u-x,go-wx /etc/passwd-
                                #For better understanding and make it more straight forward
				chmod 644 /etc/passwd-
				remediation_complete+="6.1.2\n"
				;;

			"6.1.3")
				#Run commands to remediate 6.1.3
				chown root:root /etc/group
				#Initial permission command: chmod u-x,go-wx /etc/group
				#For better understanding and make it more straight forward
				chmod 644 /etc/group
				remediation_complete+="6.1.3\n"
				;;

			"6.1.4")
				#Run commands to remediate 6.1.4
				chown root:root /etc/group-
				#Initial permission command: chmod u-x,go-wx /etc/group-
				#For better understanding and make it more straight forward
				chmod 644 /etc/group-
				remediation_complete+="6.1.4\n"
				;;

			"6.1.5")
				#Run commands to remediate 6.1.5
				chown root:root /etc/shadow
				#OR
				chown root:shadow /etc/shadow
				#Initial permission command: chmod u-x,g-wx,o-rwx /etc/shadow
				#For better understanding and make it more straight forward
				chmod 640 /etc/shadow
				remediation_complete+="6.1.5\n"
				;;

			"6.1.6")
				#Run commands to remediate 6.1.6
				chown root:root /etc/shadow-
				#OR
				#chown root:shadow /etc/shadow-
				#Initial permission command: chmod u-x,g-wx,o-rwx /etc/shadow-
				#For better understanding and set permission explicitly
				chmod 640 /etc/shadow-
				remediation_complete+="6.1.6\n"
				;;

			"6.1.7")
				#Run commands to remediate 6.1.7
				chown root:root /etc/gshadow
				#OR
				#chown root:shadow /etc/gshadow
				#Initial permission command: chmod u-x,g-wx,o-rwx /etc/gshadow
				#For better understanding and set permission explicitly
				chmod 640 /etc/gshadow
				remediation_complete+="6.1.7\n"
				;;

			"6.1.8")
				 #Run commands to remediate 6.1.8
				 chown root:root /etc/gshadow-
				 #OR
				 #chown root:shadow /etc/gshadow-
				 #Initial permission command: chmod u-x,g-wx,o-rwx /etc/gshadow-
				 #For better understanding and set permission explicitly
				 chmod 640 /etc/gshadow-
				 remediation_complete+="6.1.8\n"
				 ;;

			"6.1.9")
				#Run commands to remediate 6.1.9
				#Remediation:
				#Removing write access for the "other" category ( chmod o-w <filename> ) is advisable, but always consult relevant vendor documentation to avoid breaking any application dependencies on a given file.
				#Requires manual remediation
				remediation_incomplete+="6.1.9\n"
				;;

			"6.1.10")
				#Run commands to remediate 6.1.10
				#Remediation:
				#Locate files that are owned by users or groups not listed in the system configuration files, and reset the ownership of these files to some active user on the system as appropriate.
				#Requires manual remediation
				remediation_incomplete+="6.1.10\n"
				;;

			"6.1.11")
				#Run commands to remediate 6.1.11
				#Remediation:
				#Locate files that are owned by users or groups not listed in the system configuration files, and reset the ownership of these files to some active user on the system as appropriate.
				#Requires manual remediation
				remediation_incomplete+="6.1.11\n"
				;;

			"6.1.12")
				#Run commands to remediate 6.1.12
				#Remediation:
				#Ensure that no rogue SUID programs have been introduced into the system. Review the files returned by the action in the Audit section and confirm the integrity of these binaries.
				#Requires manual remediation
				remediation_incomplete+="6.1.12\n"
				;;

			"6.1.13")
				#Run commands to remediate 6.1.13
				#Remediation:
				#Ensure that no rogue SGID programs have been introduced into the system. Review the files returned by the action in the Audit section and confirm the integrity of these binaries.
				#Requires manual remediation
				remediation_incomplete+="6.1.13\n"
				;;

			"6.2.1")
				#Run commands to remediate 6.2.1
				#set accounts to use shadowed passwords
				sed -e 's/^\([a-zA-Z0-9_]*\):[^:]*:/\1:x:/' -i /etc/passwd
				#Investigate to determine if the account is logged in and what it is being used for, to determine if it needs to be forced off.
				remediation_complete+="6.2.1\n"
				;;

			"6.2.2")
				#Run commands to remediate 6.2.2
				#Remediation:
				#If any accounts in the /etc/shadow file do not have a password, run the following command to lock the account until it can be determined why it does not have a password:
				#passwd -l <username>
				#Also, check to see if the account is logged in and investigate what it is being used for to determine if it needs to be forced off.
				#Requires manual remediation
				remediation_incomplete+="6.2.2\n"
				;;

			"6.2.3")
				#Run commands to remediate 6.2.3
				#Remediation:
				#Analyze the output of the Audit step above and perform the appropriate action to correct any discrepancies found.
				#Requires manual remediation
				remediation_incomplete+="6.2.3\n"
				;;

			"6.2.4")
				#Run commands to remediate 6.2.4
				#remove all users from the shadow group
				#sed -ri 's/(^shadow:[^:]*:[^:]*:)([^:]+$)/\1/' /etc/group
				#Change the primary group of any users with shadow as their primary group.
				#usermod -g <primary group> <user>
				#Requires manual remediation
				remediation_incomplete+="6.2.4\n"
				;;

			"6.2.5")
				#Run commands to remediate 6.2.5
				#Remediation:
				#Based on the results of the audit script, establish unique UIDs and review all files owned by the shared UIDs to determine which UID they are supposed to belong to.
				#Requires manual remediation
				remediation_incomplete+="6.2.5\n"
				;;

			"6.2.6")
				#Run commands to remediate 6.2.6
				#Remediation:
				#Based on the results of the audit script, establish unique GIDs and review all files owned by the shared GID to determine which group they are supposed to belong to.
				#Additional Information:
				#You can also use the grpck command to check for other inconsistencies in the /etc/group file.
				#Requires manual remediation
				remediation_incomplete+="6.2.6\n"
				;;

			"6.2.7")
				#Run commands to remediate 6.2.7
				#Remediation:
				#Based on the results of the audit script, establish unique user names for the users. File ownerships will automatically reflect the change as long as the users have unique UIDs.
				#Requires manual remediation
				remediation_incomplete+="6.2.7\n"
				;;

			"6.2.8")
				#Run commands to remediate 6.2.8
				#Remediation:
				#Based on the results of the audit script, establish unique names for the user groups. File group ownerships will automatically reflect the change as long as the groups have unique GIDs.
				#Requires manual remediation
				remediation_incomplete+="6.2.8\n"
				;;

			"6.2.9")
				#Run commands to remediate 6.2.9
				#Remediation:
				#Correct or justify any items discovered in the Audit step.
				#Requires manual remediation
				remediation_incomplete+="6.2.9\n"
				;;

			"6.2.10")
				#Run commands to remediate 6.2.10
				#Remediation:
				#Remove any users other than root with UID 0 or assign them a new UID if appropriate.
				remediation_incomplete+="6.2.10\n"
				;;

			"6.2.11")
				#Run commands to remediate 6.2.11
				#Remediation:
				#If any users' home directories do not exist, create them and make sure the respective user owns the directory. Users without an assigned home directory should be removed or assigned a home directory as appropriate. The following script will create a home directory for users with an interactive shell whose home directory doesn't exist:
				#Requires script to run to remediate
				remediation_incomplete+="6.2.11\n"
				;;

			"6.2.12")
				#Run commands to remediate 6.2.12
				#Remediation:
				#Change the ownership of any home directories that are not owned by the defined user to the correct user. The following script will update local interactive user home directories to be own by the user:
				#Requires script to run to remediate
				remediation_incomplete+="6.2.12\n"
				;;

			"6.2.13")
				#Run commands to remediate 6.2.13
				#Remediation:
				#Making global modifications to user home directories without alerting the user community can result in unexpected outages and unhappy users. Therefore, it is recommended that a monitoring policy be established to report user file permissions and determine the action to be taken in accordance with site policy. The following script can be used to remove permissions is excess of 750 from interactive user home directories:
				#Requires script to run to remediate
				remediation_incomplete+="6.2.13\n"
				;;

			"6.2.14")
				#Run commands to remediate 6.2.14
				#Remediation:
				#Making global modifications to users' files without alerting the user community can result in unexpected outages and unhappy users. Therefore, it is recommended that a monitoring policy be established to report user .netrc file permissions and determine the action to be taken in accordance with local site policy. The following script will remove .netrc files from interactive users' home directories
				#Requires script to run to remediate
				remediation_incomplete+="6.2.14\n"
				;;

			"6.2.15")
				#Run commands to remediate 6.2.15
				#Remediation:
				#Making global modifications to users' files without alerting the user community can result in unexpected outages and unhappy users. Therefore, it is recommended that a monitoring policy be established to report user .forward files and determine the action to be taken in accordance with site policy. The following script will remove .forward files from interactive users' home directories
				#Requires script to run to remediate
				remediation_incomplete+="6.2.15\n"
				;;

			"6.2.16")
				#Run commands to remediate 6.2.16
				#Remediation:
				#Making global modifications to users' files without alerting the user community can result in unexpected outages and unhappy users. Therefore, it is recommended that a monitoring policy be established to report user .rhosts files and determine the action to be taken in accordance with site policy. The following script will remove .rhosts files from interactive users' home directories
				#Requires script to run to remediate
				remediation_incomplete+="6.2.16\n"
				;;

			"6.2.17")
				#Run commands to remediate 6.2.17
				#Remediation:
				#Making global modifications to users' files without alerting the user community can result in unexpected outages and unhappy users. Therefore, it is recommended that a monitoring policy be established to report user dot file permissions and determine the action to be taken in accordance with site policy. The following script will remove excessive permissions on dot files within interactive users' home directories.
				#Requires script to run to remediate 
				remediation_incomplete+="6.2.17\n"
				;;



			*)
				;;

			esac

		done <<< "$failed_audits"

		if [[ -n "$remediation_complete" ]] && [[ -n "$remediation_incomplete" ]]; then
			echo -e "${green}Remediation complete:${clr}\n$remediation_complete"
			echo -e "${red}Remediation incomplete (requires script to run or manual remediation to remediate):${clr}\n$remediation_incomplete"
		elif [[ -n "$remediation_incomplete" ]]; then
			echo -e "${red}Remediation incomplete (requires script to run or manual remediation to remediate):${clr}\n$remediation_incomplete"
		else
			echo -e "${green}Remediation complete:${clr}\n$remediation_complete"
		
		fi

}

# Call the function to display failed audits and prompt the user
display_failed_audits
