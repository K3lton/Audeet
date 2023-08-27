#!/bin/bash

#clear terminal
clear

#color for font
#green="\033[0;32m"
#GREEN="\033[0;42m"
#red="\033[0;31m"
#RED="\033[0;41m"
#yellow="\033[0;33m"
#YELLOW="\033[0;43m"
#clr="\033[0m"

#echo reminder
echo -e "${red}!!! Reminder: Please ensure audit script is run as root user !!!${clr}"
echo -e "${red} !! The audit scripts may take longer to run for those with lesser CPUs and small RAMS !!${clr}\n"
echo -e "\nLegend:\n              Pass: ${GREEN}     ${clr}\n              Fail: ${RED}     ${clr}\nCannot be Accessed: ${YELLOW}     ${clr}\n"

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
#start of CIS section 1 audit
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                    1 Initial Setup                                                         |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                             1.1 Filesystem Configuration                                                   |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                          1.1.1 Disable Unused Filesystems                                                  |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################
# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Automated)
#########################################################################################################################

# Audit command
audit=$(modprobe -n -v cramfs 2>/dev/null)

# If statement
if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$audit"; then
    echo -e "|1.1.1.1  | Ensure mounting of cramfs filesystems is disabled (Automated)                               | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
elif [[ -z $audit ]]; then
    echo -e "${RED}|1.1.1.1  | Ensure mounting of cramfs filesystems is disabled (Automated)                               | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.1.1 "
else
    echo -e "${RED}|1.1.1.1  | Ensure mounting of cramfs filesystems is disabled (Automated)                               | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.1.1 "
fi

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.1.2 Ensure mounting of squashfs filesystems is disabled (Automated)
#########################################################################################################################

# Audit command
audit=$(modprobe -n -v squashfs 2>/dev/null)

# If statement
if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$audit"; then
    echo -e "|1.1.1.2  | Ensure mounting of squashfs filesystems is disabled (Automated)                             | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
elif [[ -z $audit ]]; then
    echo -e "${RED}|1.1.1.2  | Ensure mounting of squashfs filesystems is disabled (Automated)                             | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.1.2 "
else
    echo -e "${RED}|1.1.1.2  | Ensure mounting of squashfs filesystems is disabled (Automated)                             | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.1.2 "
fi

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.1.3 Ensure mounting of udf filesystems is disabled (Automated)
#########################################################################################################################

# Audit command
audit=$(modprobe -n -v udf 2>/dev/null)

# If statement
if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$audit"; then
    echo -e "|1.1.1.3  | Ensure mounting of udf filesystems is disabled (Automated)                                  | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
elif [[ -z $audit ]]; then
    echo -e "${RED}|1.1.1.3  | Ensure mounting of udf filesystems is disabled (Automated)                                  | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.1.3 "
else
    echo -e "${RED}|1.1.1.3  | Ensure mounting of udf filesystems is disabled (Automated)                                  | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.1.3 "
fi

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                               1.1.2 Configure /tmp                                                         |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#!/usr/bin/env bash

#########################################################################################################################
# 1.1.2.1 Ensure /tmp is a separate partition (Automated)
#########################################################################################################################

# Audit command to check if /tmp is a separate partition
audit=$(findmnt --kernel /tmp | grep tmpfs)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.2.1  | Ensure /tmp is a separate partition (Automated)                                             | ${green}Pass               ${clr}|"
    ((pass_count++))
    #((total_audit++))
else
    echo -e "${RED}|1.1.2.1  | Ensure /tmp is a separate partition (Automated)                                             | Fail               |${clr}"
    #((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.2.1 "
fi

# Check if systemd will mount the /tmp partition at boot time
systemd_audit=$(systemctl is-enabled tmp.mount 2>/dev/null)

# If statement for systemd audit
if [[ "$systemd_audit" == "enabled" ]]; then
    echo -e "|1.1.2.1  | Ensure /tmp is a separate partition (Automated)                                             | ${green}Pass               ${clr}|"
else
    echo -e "${RED}|1.1.2.1  | Ensure /tmp is a separate partition (Automated)                                             | Fail               |${clr}"
    failed_audits+="1.1.2.1 "
fi

((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.2.2 Ensure nodev option set on /tmp partition (Automated)
#########################################################################################################################

# Audit command to check if nodev option is set on /tmp partition
audit=$(findmnt --kernel /tmp | grep nodev)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.2.2  | Ensure nodev option set on /tmp partition (Automated)                                       | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.2.2  | Ensure nodev option set on /tmp partition (Automated)                                       | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.2.2 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.2.3 Ensure noexec option set on /tmp partition (Automated)
#########################################################################################################################

# Audit command to check if noexec option is set on /tmp partition
audit=$(findmnt --kernel /tmp | grep noexec)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.2.3  | Ensure noexec option set on /tmp partition (Automated)                                      | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.2.3  | Ensure noexec option set on /tmp partition (Automated)                                      | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.2.3 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.2.4 Ensure nosuid option set on /tmp partition (Automated)
#########################################################################################################################

# Audit command to check if nosuid option is set on /tmp partition
audit=$(findmnt --kernel /tmp | grep nosuid)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.2.4  | Ensure nosuid option set on /tmp partition (Automated)                                      | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.2.4  | Ensure nosuid option set on /tmp partition (Automated)                                      | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.2.4 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                              1.1.3 Configure /var                                                          |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#!/usr/bin/env bash

#########################################################################################################################
# 1.1.3.1 Ensure separate partition exists for /var (Automated)
#########################################################################################################################

# Audit command to check if /var is mounted on a separate partition
audit=$(findmnt --kernel /var)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.3.1  | Ensure separate partition exists for /var (Automated)                                        | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.3.1  | Ensure separate partition exists for /var (Automated)                                       | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.3.1 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.3.2 Ensure nodev option set on /var partition (Automated)
#########################################################################################################################

# Audit command to check if the nodev option is set for /var
audit=$(findmnt --kernel /var | grep 'nodev')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.3.2  | Ensure nodev option set on /var partition (Automated)                                       | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.3.2  | Ensure nodev option set on /var partition (Automated)                                       | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.3.2 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.3.3 Ensure nosuid option set on /var partition (Automated)
#########################################################################################################################

# Audit command to check if the nosuid option is set for /var
audit=$(findmnt --kernel /var | grep 'nosuid')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.3.3  | Ensure nosuid option set on /var partition (Automated)                                      | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.3.3  | Ensure nosuid option set on /var partition (Automated)                                      | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.3.3 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                           1.1.4 Configure /var/tmp                                                         |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#!/usr/bin/env bash

#########################################################################################################################
# 1.1.4.1 Ensure separate partition exists for /var/tmp (Automated)
#########################################################################################################################

# Audit command to check if /var/tmp is mounted on a separate partition
audit=$(findmnt --kernel /var/tmp)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.4.1  | Ensure separate partition exists for /var/tmp (Automated)                                   | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.4.1  | Ensure separate partition exists for /var/tmp (Automated)                                   | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.4.1 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.4.2 Ensure noexec option set on /var/tmp partition (Automated)
#########################################################################################################################

# Audit command to check if noexec option is set for /var/tmp
audit=$(findmnt --kernel /var/tmp | grep noexec)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.4.2  | Ensure noexec option set on /var/tmp partition (Automated)                                  | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.4.2  | Ensure noexec option set on /var/tmp partition (Automated)                                  | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.4.2 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.4.3 Ensure nosuid option set on /var/tmp partition (Automated)
#########################################################################################################################

# Audit command to check if nosuid option is set for /var/tmp
audit=$(findmnt --kernel /var/tmp | grep nosuid)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.4.3  | Ensure nosuid option set on /var/tmp partition (Automated)                                  | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.4.3  | Ensure nosuid option set on /var/tmp partition (Automated)                                  | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.4.3 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.4.4 Ensure nodev option set on /var/tmp partition (Automated)
#########################################################################################################################

# Audit command to check if nodev option is set for /var/tmp
audit=$(findmnt --kernel /var/tmp | grep nodev)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.4.4  | Ensure nodev option set on /var/tmp partition (Automated)                                   | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.4.4  | Ensure nodev option set on /var/tmp partition (Automated)                                   | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.4.4 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                             1.1.5 Configure /var/log                                                       |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#!/usr/bin/env bash

#########################################################################################################################
# 1.1.5.1 Ensure separate partition exists for /var/log (Automated)
#########################################################################################################################

# Audit command to check if /var/log is mounted
audit=$(findmnt --kernel /var/log | grep /var/log)

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.5.1  | Ensure separate partition exists for /var/log (Automated)                                   | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.5.1  | Ensure separate partition exists for /var/log (Automated)                                   | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.5.1 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.5.2 Ensure nodev option set on /var/log partition (Automated)
#########################################################################################################################

# Audit command to check if the nodev option is set for /var/log
audit=$(findmnt --kernel /var/log | grep -E 'nodev')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.5.2  | Ensure nodev option set on /var/log partition (Automated)                                   | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.5.2  | Ensure nodev option set on /var/log partition (Automated)                                   | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.5.2 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.5.3 Ensure noexec option set on /var/log partition (Automated)
#########################################################################################################################

# Audit command to check if the noexec option is set for /var/log
audit=$(findmnt --kernel /var/log | grep -E 'noexec')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.5.3  | Ensure noexec option set on /var/log partition (Automated)                                  | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.5.3  | Ensure noexec option set on /var/log partition (Automated)                                  | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.5.3 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.5.4 Ensure nosuid option set on /var/log partition (Automated)
#########################################################################################################################

# Audit command to check if the nosuid option is set for /var/log
audit=$(findmnt --kernel /var/log | grep -E 'nosuid')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.5.4  | Ensure nosuid option set on /var/log partition (Automated)                                  | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.5.4  | Ensure nosuid option set on /var/log partition (Automated)                                  | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.5.4 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                          1.1.6 Configure /var/log/audit                                                    |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#!/usr/bin/env bash

#########################################################################################################################
# 1.1.6.1 Ensure separate partition exists for /var/log/audit (Automated)
#########################################################################################################################

# Audit command to check if /var/log/audit is mounted
audit=$(findmnt --kernel /var/log/audit | grep -E '/var/log/audit')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.6.1  | Ensure separate partition exists for /var/log/audit (Automated)                             | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.6.1  | Ensure separate partition exists for /var/log/audit (Automated)                             | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.6.1 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.6.2 Ensure noexec option set on /var/log/audit partition (Automated)
#########################################################################################################################

# Audit command to check if noexec option is set on /var/log/audit partition
audit=$(findmnt --kernel /var/log/audit | grep -E 'noexec')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.6.2  | Ensure noexec option set on /var/log/audit partition (Automated)                            | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.6.2  | Ensure noexec option set on /var/log/audit partition (Automated)                            | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.6.2 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.6.3 Ensure nodev option set on /var/log/audit partition (Automated)
#########################################################################################################################

# Audit command to check if nodev option is set on /var/log/audit partition
audit=$(findmnt --kernel /var/log/audit | grep -E 'nodev')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.6.3  | Ensure nodev option set on /var/log/audit partition (Automated)                             | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.6.3  | Ensure nodev option set on /var/log/audit partition (Automated)                             | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.6.3 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.6.4 Ensure nosuid option set on /var/log/audit partition (Automated)
#########################################################################################################################

# Audit command to check if nosuid option is set on /var/log/audit partition
audit=$(findmnt --kernel /var/log/audit | grep -E 'nosuid')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.6.4  | Ensure nosuid option set on /var/log/audit partition (Automated)                            | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.6.4  | Ensure nosuid option set on /var/log/audit partition (Automated)                            | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.6.4 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                 1.1.7 Configure /home                                                      |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#!/usr/bin/env bash

#########################################################################################################################
# 1.1.7.1 Ensure separate partition exists for /home (Automated)
#########################################################################################################################

# Audit command to check if /home is mounted
audit=$(findmnt --kernel /home | grep -E '/home')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.7.1  | Ensure separate partition exists for /home (Automated)                                      | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.7.1  | Ensure separate partition exists for /home (Automated)                                      | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.7.1 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.7.2 Ensure nodev option set on /home partition (Automated)
#########################################################################################################################

# Audit command to check if the nodev option is set for /home partition
audit=$(findmnt --kernel /home | grep -E '/home.*nodev')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.7.2  | Ensure nodev option set on /home partition (Automated)                                      | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.7.2  | Ensure nodev option set on /home partition (Automated)                                      | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.7.2 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.7.3 Ensure nosuid option set on /home partition (Automated)
#########################################################################################################################

# Audit command to check if the nosuid option is set for /home partition
audit=$(findmnt --kernel /home | grep -E '/home.*nosuid')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.7.3  | Ensure nosuid option set on /home partition (Automated)                                     | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.7.3  | Ensure nosuid option set on /home partition (Automated)                                     | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.7.3 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                            1.1.8 Configure /dev/shm                                                        |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#!/usr/bin/env bash

#########################################################################################################################
# 1.1.8.1 Ensure nodev option set on /dev/shm partition (Automated)
#########################################################################################################################

# Audit command to check if the nodev option is set for /dev/shm partition
audit=$(findmnt --kernel /dev/shm | grep -E '/dev/shm.*nodev')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.8.1  | Ensure nodev option set on /dev/shm partition (Automated)                                   | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.8.1  | Ensure nodev option set on /dev/shm partition (Automated)                                   | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.8.1 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.8.2 Ensure noexec option set on /dev/shm partition (Automated)
#########################################################################################################################

# Audit command to check if the noexec option is set for /dev/shm partition
audit=$(findmnt --kernel /dev/shm | grep -E '/dev/shm.*noexec')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.8.2  | Ensure noexec option set on /dev/shm partition (Automated)                                  | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.8.2  | Ensure noexec option set on /dev/shm partition (Automated)                                  | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.8.2 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################

#!/usr/bin/env bash

#########################################################################################################################
# 1.1.8.3 Ensure nosuid option set on /dev/shm partition (Automated)
#########################################################################################################################

# Audit command to check if the nosuid option is set for /dev/shm partition
audit=$(findmnt --kernel /dev/shm | grep -E '/dev/shm.*nosuid')

# If statement
if [[ -n "$audit" ]]; then
    echo -e "|1.1.8.3  | Ensure nosuid option set on /dev/shm partition (Automated)                                  | ${green}Pass               ${clr}|"
    ((pass_count++))
    ((total_audit++))
else
    echo -e "${RED}|1.1.8.3  | Ensure nosuid option set on /dev/shm partition (Automated)                                  | Fail               |${clr}"
    ((total_audit++))
    ((fail_count++))
    failed_audits+="1.1.8.3 "
fi

#((total_audit++))

#########################################################################################################################
# Remediation: No remediation script provided in the CIS benchmark
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                           1.2 Configure Software Updates                                                   |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################
#1.2.1
#audit
#Run the following command and verify package repositories are configured correctly
audit=$(apt-cache policy)

#if-elif-else statement
if [[ -z "$audit" ]]; then
        echo -e "${RED}|1.2.1    | Ensure package manager repositories are configured (Manual)                                 | Fail               |${clr}"
	((total_audit++))
        ((fail_count++))
        failed_audits+="1.2.1 "
elif [[ -n "$audit" ]]; then
        echo -e "${YELLOW}|1.2.1    | Ensure package manager repositories are configured (Manual)                                 | Cannot be Accessed |${clr}"
	((total_audit++))
	((Cannot_be_Accessed_count++))
else
        echo -e "|1.2.1    | Ensure package manager repositories are configured (Manual)                                 | ${green}Pass${clr}               |"
	((pass_count++))
        ((total_audit++))
fi
#########################################################################################################################
#1.2.2
#audit
#Verify GPG keys are configured correctly for your package manager
audit=$(apt-key list 2>/dev/null)

#if-elif-else statement
if [[ -z "$audit" ]]; then
        echo -e "${RED}|1.2.2    | Ensure GPG keys are configured (Manual)                                                     | Fail               |${clr}"
	((total_audit++))
        ((fail_count++))
        failed_audits+="1.2.2 "

elif [[ -n "$audit" ]]; then
        echo -e "${YELLOW}|1.2.2    | Ensure GPG keys are configured (Manual)                                                     | Cannot be Accessed  |${clr}"
	((total_audit++))
        ((Cannot_be_Accessed_count++))
else
        echo -e "|1.2.2    | Ensure GPG keys are configured (Manual)                                                     | ${green}Pass${clr}               |"
	((pass_count++))
        ((total_audit++))
fi
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                          1.3 Filesystem Integrity Checking                                                 |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################

#!/usr/bin/env bash



#1.3.1
#audit command
#2>/dev/null is to redirect the standard error output(stderr) to '/dev/null'
#removing the system error output
#reason to remove is that it will interfere with the output of status when compiled
#as for evidence echo line AIDE is not installed on the system
audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' aide aide-common 2>/dev/null)

#output of audit
#dpkg-query: no packages found matching aide
#dpkg-query: no packages found matching aide-common

#if statement
if echo "$audit" | grep -qE 'install ok installed|installed'; then
        echo -e "|1.3.1    | Ensure AIDE is installed (Automated)                                                        | ${green}Pass               ${clr}|"
	((pass_count++))
	((total_audit++))

elif [[ -z $audit ]]; then
        echo -e "${RED}|1.3.1    | Ensure AIDE is installed (Automated)                                                        | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.3.1 "


else
        echo -e "${RED}|1.3.1    | Ensure AIDE is installed (Automated)                                                        | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.3.1 "
fi
#########################################################################################################################
#1.3.2
#use bash function to do audit
#1. function to check if the AIDE rule is defined in cron jobs
check_aide_cron_rule() {
        if grep -Prs '^([^#\n\r]+\h+)?(\/usr\/s?bin\/|^\h*)aide(\.wrapper)?\h+(--check|([^#\n\r]+\h+)?\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

#2. function to check if aidecheck.service is enabled
check_aidecheck_service() {
        if systemctl is-enabled aidecheck.service 2>/dev/null; then #>/dev/null to redirect standard output error
                return 0 #pass
        else
                return 1 #fail
        fi
}

#3. function to check if aidecheck.timer is enabled
check_aidecheck_timer() {
        if systemctl is-enabled aidecheck.timer 2>/dev/null; then #>/dev/null to redirect standard output error
                return 0 #pass
        else
                return 1 #fail
        fi
}

#4. function to check status of aidecheck.timer
check_aidecheck_timer_status() {
	#original audit command
	#systemctl status aidecheck.timer
        if systemctl is-active aidecheck.timer >/dev/null 2>&1; then #>/dev/null to redirect standard output error
                return 0 #pass
        else
                return 1 #fail
        fi
}

#check AIDE rule in cron jobs
check_aide_cron_rule
aide_cron_rule_status=$?

#check if aidecheck.service is enabled
check_aidecheck_service
aidecheck_service_status=$?

#check if aidecheck.timer is enabled
check_aidecheck_timer
aidecheck_timer_status=$?

#check status of aidecheck.timer
check_aidecheck_timer_status
aidecheck_timer_status_value=$?

#if statement to check overall compliance
if [[ $aide_cron_rule_status -eq 0 ]]; then
        echo -e "|1.3.2    | Ensure filesystem integrity is regularly checked (Automated)                                | ${green}Pass${clr}               |"
	((pass_count++))
	((total_audit++))
        #echo "cron will be used to schedule and run aide check"
elif [[ $aidecheck_service_status -eq 0 ]] && [[ $aidecheck_timer_status -eq 0 ]] && [[ $aidecheck_timer_status_value -eq 0 ]]; then
        echo -e "|1.3.2    | Ensure filesystem integrity is regularly checked (Automated)                                | ${green}Pass${clr}               |"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.3.2 "
        #echo "aidecheck.service and aidecheck.timer will be used to schedule and run aide check"
else
        echo -e "${RED}|1.3.2    | Ensure filesystem integrity is regularly checked (Automated)                                | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.3.2 "
        #echo -e "\nNeither cron or aidecheck.service and aidecheck.timer is used to schedule and run aide check"
fi
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                1.4 Secure Boot Settings                                                    |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################
#1.4.1
#audit command
audit1=$(grep "^set superusers" /boot/grub/grub.cfg)
audit2=$(grep "^password" /boot/grub/grub.cfg)

#initialize desired output for audits
desired_output1='set superusers="<username>"'
desired_output2="password_pbkdf2 <username> <encrypted-password>"

#if statement
if [[ $audit1 == $desired_output1 ]] && [[ $audit2 == $desired_output2 ]]; then
        echo -e "|1.4.1    | Ensure bootloader password is set (Automated)                                               | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))

else
        echo -e "${RED}|1.4.1    | Ensure bootloader password is set (Automated)                                               | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.4.1 "

fi
#########################################################################################################################
#1.4.2
#audit command
audit=$(stat /boot/grub/grub.cfg | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#Initialize desired UID,GID,ACCESS
desired_uid=0
desired_gid=0
desired_permission="400" #or more restrictive

#Initialize audit output
permission=$(stat -c %a /boot/grub/grub.cfg)
uid=$(stat -c %u /boot/grub/grub.cfg)
gid=$(stat -c %g /boot/grub/grub.cfg)

#if statment
if [[ "$permission" -le "$desired_permission" && "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" ]]; then
        echo -e "|1.4.2    | Ensure permissions on bootloader config are configured (Automated)                          | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))

else
	echo -e "${RED}|1.4.2    | Ensure permissions on bootloader config are configured (Automated)                          | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.4.2 "

fi
#########################################################################################################################
#1.4.3
#audit command
audit=$(grep -Eq '^root:\$[0-9]' /etc/shadow || echo "root is locked")

#if statement
#ensure no outout returned
if [[ -z $audit ]]; then
        echo -e "|1.4.3    | Ensure authentication required for single user mode (Automated)                             | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.4.3    | Ensure authentication required for single user mode (Automated)                             | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.4.3 "
fi
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                         1.5 Additional Process Hardening                                                   |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################
#1.5.1
# Function to check if a command is available in PATH
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if sysctl command exists in the root user's PATH
if command_exists sysctl; then
        #audit command
        #verify kernel.randomize_va_space is set to 2
        {
                krp="" pafile="" fafile=""
                kpname="kernel.randomize_va_space"
                kpvalue="2"
                searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf
        /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf
        /etc/sysctl.conf"
                krp="$(sysctl "$kpname" | awk -F= '{print $2}' | xargs)"
                pafile="$(grep -Psl -- "^\h*$kpname\h*=\h*$kpvalue\b\h*(#.*)?$" $searchloc)"
                fafile="$(grep -s -- "^\s*$kpname" $searchloc | grep -Pv -- "\h*=\h*$kpvalue\b\h*" | awk -F: '{print $1}')"
                if [ "$krp" = "$kpvalue" ] && [ -n "$pafile" ] && [ -z "$fafile" ]; then
                        echo -e "|1.5.1    | Ensure address space layout randomization (ASLR) is enabled (Automated)                     | ${green}Pass${clr}               |"
			((total_audit++))
			((pass_count++))
                        #echo -e "\nPASS:\n\"$kpname\" is set to \"$kpvalue\" in the running configuration and in \"$pafile\""
                else
                        echo -e "${RED}|1.5.1    | Ensure address space layout randomization (ASLR) is enabled (Automated)                     | Fail               |${clr}"
			((total_audit++))
			((fail_count++))
			failed_audits+="1.5.1 "
                        #echo -e "\nEvidence: "
                        #[ "$krp" != "$kpvalue" ] && echo -e "Fail: \"$kpname\" is set to \"$krp\" in the running configuration\n"
                        #[ -n "$fafile" ] && echo -e "\nFail: \"$kpname\" is set incorrectly in \"$fafile\""
                        #[ -z "$pafile" ] && echo -e "\nFail: \"$kpname = $kpvalue\" is not set in a kernel parameter configuration file\n"
                fi
        }
else
        #audit command
        #verify kernel.randomize_va_space is set to 2
        {
                krp="" pafile="" fafile=""
                kpname="kernel.randomize_va_space"
                kpvalue="2"
                searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf
        /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf
        /etc/sysctl.conf"
                krp="$(/sbin/sysctl "$kpname" | awk -F= '{print $2}' | xargs)"
                pafile="$(grep -Psl -- "^\h*$kpname\h*=\h*$kpvalue\b\h*(#.*)?$" $searchloc)"
                fafile="$(grep -s -- "^\s*$kpname" $searchloc | grep -Pv -- "\h*=\h*$kpvalue\b\h*" | awk -F: '{print $1}')"
                if [ "$krp" = "$kpvalue" ] && [ -n "$pafile" ] && [ -z "$fafile" ]; then
                        echo -e "|1.5.1    | Ensure address space layout randomization (ASLR) is enabled (Automated)                     | ${green}Pass${clr}               |"
			((total_audit++))
			((pass_count++))
                        #echo -e "\nPASS:\n\"$kpname\" is set to \"$kpvalue\" in the running configuration and in \"$pafile\""
                else
                        echo -e "${RED}|1.5.1    | Ensure address space layout randomization (ASLR) is enabled (Automated)                     | Fail               |${clr}"
			((total_audit++))
			((fail_count++))
                        failed_audits+="1.5.1 "
                        #echo -e "\nEvidence: "
                        #[ "$krp" != "$kpvalue" ] && echo -e "Fail: \"$kpname\" is set to \"$krp\" in the running configuration\n"
                        #[ -n "$fafile" ] && echo -e "\nFail: \"$kpname\" is set incorrectly in \"$fafile\""
                        #[ -z "$pafile" ] && echo -e "\nFail: \"$kpname = $kpvalue\" is not set in a kernel parameter configuration file\n"
                fi
        }
fi
#########################################################################################################################
#1.5.2
#audit command
#2>/dev/null is to redirect the standard error output(stderr) to '/dev/null'
#removing the system error output
#reason to remove is that it will interfere with the output of status when compiled
#as for evidence echo line prelink is installed on the system
audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' prelink 2>/dev/null)

#output of audit
#dpkg-query: no packages found matching prelink

#if statement
if echo "$audit" | grep -qE 'unknown ok not-installed|not-installed'; then
        echo -e "|1.5.2    | Ensure prelink is not installed (Automated)                                                 | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))

elif [[ -z $audit ]]; then
        echo -e "|1.5.2    | Ensure prelink is not installed (Automated)                                                 | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))

else
        echo -e "${RED}|1.5.2    | Ensure prelink is not installed (Automated)                                                 | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.5.2 "

fi
#########################################################################################################################
#1.5.3
#audit command
#verify nothing returned
audit1=$(dpkg-query -s apport > /dev/null 2>&1 && grep -Psi -- '^\h*enabled\h*=\h*[^0]\b' /etc/default/apport)
audit2=$(systemctl is-active apport.service | grep '^active')

#if statement
if [[ -z $audit1 ]]; then
        if [[ -z $audit2 ]]; then
                echo -e "|1.5.3    | Ensure Automatic Error Reporting is not enabled (Automated)                                         | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
        else
                echo -e "${RED}|1.5.3    | Ensure Automatic Error Reporting is not enabled (Automated)                                 | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
                failed_audits+="1.5.3 "
        fi
else
        echo -e "${RED}|1.5.3    | Ensure Automatic Error Reporting is not enabled (Automated)                                 | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.5.3 "
fi
#########################################################################################################################
#1.5.4
#use bash function to do audit
#1. function to check configuration for core dumps
check_configuration () {
        #command
        audit=$(grep -Es '^(\*|\s).*hard.*core.*(\s+#.*)?$' /etc/security/limits.conf /etc/security/limits.d/*)
        #initialize output for command
        output="* hard core 0"
        if [[ $audit == $output ]]; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

#2. function to check value of fs.suid_dumpable
check_value_of_fs_suid_dumpable1 () {
	#command
        audit1=$(sysctl fs.suid_dumpable)
        audit2=$(grep "fs.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*)
        #initialize output
        output="fs.suid_dumpable = 0"
        if [[ $audit1 == $output ]] && [[ $audit2 == $output ]]; then
		return 0 #pass
        else
                return 1 #fail
        fi
}

check_value_of_fs_suid_dumpable2 () {
        #command
        audit1=$(/usr/sbin/sysctl fs.suid_dumpable)
        audit2=$(grep "fs.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*)
        #initialize output
        output="fs.suid_dumpable = 0"
        if [[ $audit1 == $output ]] && [[ $audit2 == $output ]]; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

#3. function to check if systemd-coredump is installed
check_systemd_coredump_installed () {
        #command
        audit=$(systemctl is-enabled coredump.service 2>&1)
        # Check the output for enabled, masked, or disabled
        if echo "$output" | grep -qE 'enabled|masked|disabled'; then
                return 0 #pass
        elif [[ -z $audit ]]; then
                return 1 #fail
        else
                return 1 #fail
fi
}

#capture status of function to check configuration for core dumps
check_configuration
configuration_status=$?

#capture status of function to check value of fs.suid_dumpable
# Function to check if a command is available in PATH
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if sysctl command exists in the root user's PATH
if command_exists sysctl; then

        check_value_of_fs_suid_dumpable1
        value_of_fs_suid_dumpable_status1=$?

else
        check_value_of_fs_suid_dumpable2
        value_of_fs_suid_dumpable_status2=$?

fi

#capture status of function to check if systemd-coredump is installed
check_systemd_coredump_installed
systemd_coredump_installed=$?

#if statement to check overall compliance
if [[ $configuration_status == 0 ]] && [[ $value_of_fs_suid_dumpable_status1 == 0  ||  $value_of_fs_suid_dumpable_status2 == 0 ]] && [[ $systemd_coredump_installed == 0 ]]; then
        echo -e "|1.5.4    | Ensure core dumps are restricted (Automated)                                                | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.5.4    | Ensure core dumps are restricted (Automated)                                                | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.5.4 "
fi
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                           1.6 Mandatory Access Control                                                     |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                              1.6.1 Configure AppArmor                                                      |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################
#1.6.1.1
#audit command
#2>/dev/null is to redirect the standard error output(stderr) to '/dev/null'
#removing the system error output
#reason to remove is that it will interfere with the output of status when compiled
#as for evidence echo line AppArmour is not installed on the system
audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' apparmor apparmor 2>/dev/null)

#desired output of audit
#apparmor       install ok installed    installed

#if statement
if echo "$audit" | grep -qE 'install ok installed|installed'; then
        echo -e "|1.6.1.1  | Ensure AppArmor is installed (Automated)                                                    | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
elif [[ -z $audit ]]; then
        echo -e "${RED}|1.6.1.1  | Ensure AppArmor is installed (Automated)                                                    | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.6.1.1 "

else
        echo -e "${RED}|1.6.1.1  | Ensure AppArmor is installed (Automated)                                                    | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.6.1.1 "
fi
#########################################################################################################################
#1.6.1.2
#audit command
audit1=$(grep "^\s*linux" /boot/grub/grub.cfg | grep -v "apparmor=1")
audit2=$(grep "^\s*linux" /boot/grub/grub.cfg | grep -v "security=apparmor")

#output
#Nothing should be returned

#if statement
if [[ -z $audit1 ]] && [[ -z $audit2 ]]; then
        echo -e "|1.6.1.2  | Ensure AppArmor is enabled in the bootloader configuration (Automated)                      | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.6.1.2  | Ensure AppArmor is enabled in the bootloader configuration (Automated)                      | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.6.1.2 "
fi
#########################################################################################################################
#1.6.1.3
#desired output
#37 profiles are loaded. 35 profiles are in enforce mode. 2 profiles are in complain mode. 4 processes have profiles defined.
#4 processes have profiles defined. 4 processes are in enforce mode. 0 processes are in complain mode. 0 processes are unconfined but have a profile defined.
#number is just for reference

#function for audit
with_command_path_audit1 () {
        #audit commands
        audit1=$(apparmor_status | grep profiles)
        if echo "$audit1" | grep -qE '^[0-9]+ profiles are loaded\.$' && echo "$audit1" | grep -qE '^[0-9]+ profiles are in enforce mode.|^[0-9]+ profiles are in complain mode\.$'; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

with_command_path_audit2() {
        audit2=$(apparmor_status | grep processes)
        if echo "$audit2" | grep -qE  '0 processes are unconfined but have a profile defined\.'; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

without_command_path_audit1 () {
        #audit commands
        audit1=$(/usr/sbin/apparmor_status | grep profiles)
        if echo "$audit1" | grep -qE '^[0-9]+ profiles are loaded\.$' && echo "$audit1" | grep -qE '^[0-9]+ profiles are in enforce mode.|^[0-9]+ profiles are in complain mode\.$'; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

without_command_path_audit2() {
        audit2=$(/usr/sbin/apparmor_status | grep processes)
        if echo "$audit2" | grep -qE  '0 processes are unconfined but have a profile defined\.'; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

# Function to check if a command is available in PATH
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if sysctl command exists in the root user's PATH
if command_exists apparmor_status; then

        #call function and get status of function with command path in root
        with_command_path_audit1
        with_command_path_audit1_status=$?

        with_command_path_audit2
        with_command_path_audit2_status=$?
else
        #call function and get status of function without command path in root
        without_command_path_audit1
        without_command_path_audit1_status=$?

        without_command_path_audit2
        without_command_path_audit2_status=$?
fi

if [[ $with_command_path_audit1_status == 0 && $with_command_path_audit2_status == 0  ]] || [[ $without_command_path_audit1_status == 0 && $without_command_path_audit2_status == 0 ]]; then
        echo -e "|1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                    | ${green}pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                    | fail              |${cclr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.6.1.3 "
fi
#########################################################################################################################
#1.6.1.4
#desired output
#34 profiles are loaded. 34 profiles are in enforce mode. 0 profiles are in complain mode. 2 processes have profiles defined.
#2 processes have profiles defined. 2 processes are in enforce mode. 0 processes are in complain mode. 0 processes are unconfined but have a profile defined.

#function for audit
with_command_path_audit1() {
         #audit command
        audit1=$(apparmor_status | grep profiles)
        if echo "$audit1" |  grep -qE '^[0-9]+ profiles are loaded\.$' && echo "$audit1" | grep -qE '^[0-9]+ profiles are in enforce mode\.$' && echo "$audit1" | grep -qE '0 profiles are in complain mode\.'; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

with_command_path_audit2() {
        audit2=$(apparmor_status | grep processes)
        if echo "$audit2" | grep -qE  '0 processes are unconfined but have a profile defined\.'; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

without_command_path_audit1 () {
        #audit command
        audit1=$(/usr/sbin/apparmor_status | grep profiles)
        if echo "$audit1" |  grep -qE '^[0-9]+ profiles are loaded\.$' && echo "$audit1" | grep -qE '^[0-9]+ profiles are in enforce mode\.$' && echo "$audit1" | grep -qE '0 profiles are in complain mode\.'  ; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

without_command_path_audit2() {
        audit2=$(/usr/sbin/apparmor_status | grep processes)
        if echo "$audit2" | grep -qE  '0 processes are unconfined but have a profile defined\.'; then
                return 0 #pass
        else
                return 1 #fail
        fi
}

# Function to check if a command is available in PATH
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if sysctl command exists in the root user's PATH
if command_exists apparmor_status; then

        #call function and get status of function with command in root path
        with_command_path_audit1
        with_command_path_audit1_status=$?

        with_command_path_audit2
        with_command_path_audit2_status=$?

else

        #call function and get status of function without command in root path
        without_command_path_audit1
        without_command_path_audit1_status=$?

        without_command_path_audit2
        without_command_path_audit2_status=$?

fi

if [[ $with_command_path_audit1_status == 0 && $with_command_path_audit2_status == 0 ]] || [[ $without_command_path_audit1_status == 0 && $without_command_path_audit2_status == 0 ]]; then
        echo -e "|1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                      | ${green}pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                      | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.6.1.4 "
fi
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                       1.7 Command Line Warning Banners                                                     |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################
#1.7.1
#desired output
#verify no results returned from the audit

#audit command
audit=$(grep -Eis "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd)

#if statement
if [[ -z $audit ]]; then
        echo -e "|1.7.1    | Ensure message of the day is configured properly (Automated)                                | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.7.1    | Ensure message of the day is configured properly (Automated)                                | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.7.1 "

fi
#########################################################################################################################
#1.7.2
#output for cat comamnd and grep
#verify contents in cat command to match site policy
#since the contents has to match site policy the evidence should display cannot be accessed since it requires manual auditing to verify the policy within the file /etc/issue
#verify no results are returned for grep command

#function for audit
check_etc_issue () {
        #audit comamnd
        audit1=$(cat /etc/issue)
        #if statement
        if echo "$audit1" | grep -qE '\\.'; then
                return 2 #cannot be accessed
        elif [[ -n $audit1 ]]; then
                return 0 #Pass
        else
                return 1 #Fail
        fi
}

check_no_result () {
        #audit command
        audit2=$(grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue)
        #if statement
        if [[ -z $audit2 ]]; then
                return 0 #Pass
        else
                return 1 #Fail
        fi
}

#call function and initialize status for function
check_etc_issue
check_etc_issue_status=$?

check_no_result
check_no_result_status=$?

#if statement
if [[ $check_etc_issue_status == 2 && $check_no_result_status == 0 || $check_no_result_status == 1 ]]; then
        echo -e "${YELLOW}|1.7.2    | Ensure local login warning banner is configured properly (Automated)                        | Cannot be accessed |${clr}"
	((total_audit++))
	((Cannot_be_Accessed_count++))
elif [[ $check_etc_issue_status == 0 && $check_no_result_status == 0 ]]; then
        echo -e "|1.7.2    | Ensure local login warning banner is configured properly (Automated)                        | ${green}Pass${clr}              |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.7.2    | Ensure local login warning banner is configured properly (Automated)                        | Fail              |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.7.2 "
fi
#########################################################################################################################
#1.7.3
#output for cat comamnd and grep
#verify contents in cat command to match site policy
#since the contents in /etc/issue.net should match site policy it requires manual auditing to verify the audit
#verify no results are returned for grep command

#function for audit
check_etc_issue_net () {
        #audit command
        audit1=$(cat /etc/issue.net)
        if echo "$audit1" | grep -qE '\\.'; then
                return 2 #cannot be accessed
        elif [[ -n $audit1 ]]; then
                return 0 #Pass
        else
                return 1 #Fail
        fi
}

check_no_result_etc_issue_net () {
        #audit command
        audit2=$(grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue.net)
        #if statement
        if [[ -z $audit2 ]]; then
                return 0 #Pass
        else
                return 1 #Fail
        fi
}

#call function and initialize status for function
check_etc_issue_net
check_etc_issue_net_status=$?

check_no_result_etc_issue_net
check_no_result_etc_issue_ne_status=$?

#if statement
if [[ $check_etc_issue_net_status == 2 && $check_no_result_etc_issue_ne_status == 1||0 ]]; then
        echo -e "${YELLOW}|1.7.3    | Ensure remote login warning banner is configured properly (Automated)                       | Cannot be Accessed |${clr}"
	((total_audit++))
	((Cannot_be_Accessed_count++))
elif [[ $check_etc_issue_net_status == 0 && $check_no_result_etc_issue_ne_status == 0 ]]; then
        echo -e "|1.7.3    | Ensure remote login warning banner is configured properly (Automated)                       | ${green}Pass${clr}              |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.7.3    | Ensure remote login warning banner is configured properly (Automated)                       | ${red}Fail              |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.7.3 "
fi
#########################################################################################################################
#1.7.4
#desired output
#Run the following command and verify: Uid and Gid are both 0/root and Access is 644, or the file doesn't exist
#example:
#Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)
#OR
#stat: cannot stat '/etc/motd': No such file or directory
#default value:
#file does not exist

#audit command
audit=$(stat -L /etc/motd 2>/dev/null | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#initialize file
file="/etc/motd"

#initialize desired uid,gid,access
desired_uid=0
desired_gid=0
desired_permission="644"

#check if file exist
if [[ -e "$file" ]]; then
        #check permissions
        uid=$(stat -L -c %u /etc/motd > /dev/null 2>&1)
        gid=$(stat -L -c %g /etc/motd > /dev/null 2>&1)
        permission=$(stat -L -c %a /etc/motd > /dev/null 2>&1)
        if [[ "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" && "$permission" -eq "$desired_permission" ]]; then
                echo -e "|1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                  | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))

        else
                echo -e "${RED}|1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                  | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="1.7.4 "
        fi
else
        echo -e "|1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                  | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
fi
#########################################################################################################################
#1.7.5
#desired output
#verify Uid and Gid are both 0/root and Access is 644
#default value:
#Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)

#audit command
audit=$(stat -L /etc/issue | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#initialize desired uid,gid,access
desired_uid=0
desired_gid=0
desired_permission="644"

#check if file exist
if [[ -e "/etc/issue" ]]; then
        #check uid,gid,permissions
        uid=$(stat -L -c %u /etc/issue)
        gid=$(stat -L -c %g /etc/issue)
        permission=$(stat -L -c %a /etc/issue)
        if [[ "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" && "$permission" -eq "$desired_permission" ]]; then
                echo -e "|1.7.5    | Ensure permissions on /etc/issue are configured (Automated)                                 | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
        else
                echo -e "${RED}|1.7.5    | Ensure permissions on /etc/issue are configured (Automated)                                 | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="1.7.5 "
        fi
else
        echo -e "${RED}|1.7.5    | Ensure permissions on /etc/issue are configured (Automated)                                 | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.7.5 "
fi
#########################################################################################################################
#1.7.6
#desired output
#verify Uid and Gid are both 0/root and Access is 644
#default value:
#Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)

#audit comamnd
audit=$(stat -L /etc/issue.net | grep -E 'Access:|Uid:|Gid:' | sed '2d')

#initialize desired uid,gid,access
desired_uid=0
desired_gid=0
desired_permission="644"

#check if file exist
if [[ -e "/etc/issue.net" ]]; then
        #check uid,gid,permission
        uid=$(stat -L -c %u /etc/issue.net)
        gid=$(stat -L -c %g /etc/issue.net)
        permission=$(stat -L -c %a /etc/issue.net)
        if [[ "$uid" -eq "$desired_uid" && "$gid" -eq "$desired_gid" && "$permission" -eq "$desired_permission" ]]; then
                echo -e "|1.7.6    | Ensure permissions on /etc/issue.net are configured (Automated)                             | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
        else
                echo -e "${RED}|1.7.6    | Ensure permissions on /etc/issue.net are configured (Automated)                             | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="1.7.6 "
        fi
else
        echo -e "${RED}|1.7.6    | Ensure permissions on /etc/issue.net are configured (Automated)                             | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.7.6 "
fi
#########################################################################################################################
echo "|----------------------------------------------------------------------------------------------------------------------------|"
echo "|                                              1.8 GNOME Display Manager                                                     |"
echo "|---------|---------------------------------------------------------------------------------------------|--------------------|"
#########################################################################################################################
#1.8.1
#desired output
#gdm3 unknown ok not-installed not-installed
#verify that gdm3 is not installed

#audit command
#remove system error output 2>/dev/null
audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' gdm3 2>/dev/null)

#if statment
# grep -q to quiet the filter
if echo "$audit" | grep -qE 'unknown ok not-installed|not-installed'; then
        echo -e "|1.8.1    | Ensure GNOME Display Manager is removed (Automated)                                         | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.8.1    | Ensure GNOME Display Manager is removed (Automated)                                         | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.8.1 "
fi
#########################################################################################################################
#1.8.2
#desired output
#verify that the text banner on the login screen is enabled and set
#default value:
#disabled

#audit
{
        l_pkgoutput=""
        if command -v dpkg-query > /dev/null 2>&1; then
                l_pq="dpkg-query -W"
        elif command -v rpm > /dev/null 2>&1; then
                l_pq="rpm -q"
        fi
        l_pcl="gdm gdm3" # Space seporated list of packages to check
        for l_pn in $l_pcl; do
                $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
        done
	if [ -n "$l_pkgoutput" ]; then
                l_output="" l_output2=""
                #echo -e "$l_pkgoutput"
                # Look for existing settings and set variables if they exist
                l_gdmfile="$(grep -Prils '^\h*banner-message-enable\b' /etc/dconf/db/*.d)"
                if [ -n "$l_gdmfile" ]; then
                        # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
                        l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")"
                        # Check if banner message is enabled
                        if grep -Pisq '^\h*banner-message-enable=true\b' "$l_gdmfile"; then
                                l_output="$l_output\n - The \"banner-message-enable\" option is enabled in \"$l_gdmfile\""
                        else
                                l_output2="$l_output2\n - The \"banner-message-enable\" option is not enabled"
                        fi
                        l_lsbt="$(grep -Pios '^\h*banner-message-text=.*$' "$l_gdmfile")"
                        if [ -n "$l_lsbt" ]; then
                                l_output="$l_output\n - The \"banner-message-text\" option is set in \"$l_gdmfile\"\n - banner-message-text is set to:\n - \"$l_lsbt\""
                        else
                                l_output2="$l_output2\n - The \"banner-message-text\" option is not set"
                        fi
                        if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then
                                l_output="$l_output\n - The \"$l_gdmprofile\" profile exists"
                        else
                                l_output2="$l_output2\n - The \"$l_gdmprofile\" profile doesn't exist"
                        fi
                        if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then
                                l_output="$l_output\n - The \"$l_gdmprofile\" profile exists in the dconf database"
                        else
                                l_output2="$l_output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf database"
                        fi
                else
			l_output2="$l_output2\n - The \"banner-message-enable\" option isn't configured"

                fi
        else
		echo -e "|1.8.2    | Ensure GDM login banner is configured (Automated)                                           | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
                #echo -e "\n\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not Applicable\n- Audit result:\n *** PASS ***\n"
        fi
        # Report results. If no failures output in l_output2, we pass
        if [ -z "$l_output2" ]; then
                #echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
		echo -e "|1.8.2    | Ensure GDM login banner is configured (Automated)                                           | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
        else
                echo -e "${RED}|1.8.2    | Ensure GDM login banner is configured (Automated)                                           | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="1.8.2 "
                #echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
                #[ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
        fi
}
#########################################################################################################################
#1.8.3
#desired output
#verify that the disable-user-list option is enabled or GNOME isn't installed
#default value:
#false

#audit
{
        l_pkgoutput=""
        if command -v dpkg-query > /dev/null 2>&1; then
                l_pq="dpkg-query -W"
        elif command -v rpm > /dev/null 2>&1; then
                l_pq="rpm -q"
        fi
        l_pcl="gdm gdm3" # Space seporated list of packages to check
        for l_pn in $l_pcl; do
                $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
        done
        if [ -n "$l_pkgoutput" ]; then
                output="" output2=""
                l_gdmfile="$(grep -Pril '^\h*disable-user-list\h*=\h*true\b' /etc/dconf/db)"
                if [ -n "$l_gdmfile" ]; then
                        output="$output\n - The \"disable-user-list\" option is enabled in \"$l_gdmfile\""
                        l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")"
                        if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then
                                output="$output\n - The \"$l_gdmprofile\" exists"
                        else
                                output2="$output2\n - The \"$l_gdmprofile\" doesn't exist"
                        fi
                        if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then
                                output="$output\n - The \"$l_gdmprofile\" profile exists in the dconf database"
                        else
                                output2="$output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf database"
                        fi
                else
                        output2="$output2\n - The \"disable-user-list\" option is not enabled"
                fi
                if [ -z "$output2" ]; then
                        echo -e "|1.8.3    | Ensure GDM disable-user-list option is enabled (Automated)                                  | ${green}Pass${clr}               |"
			((total_audit++))
			((pass_count++))
                        #echo -e "$l_pkgoutput\n- Audit result:\n *** PASS: ***\n$output\n"
                else
                        echo -e "${RED}|1.8.3    | Ensure GDM disable-user-list option is enabled (Automated)                                  | Fail               |${clr}"
			((total_audit++))
			((fail_count++))
			failed_audits+="1.8.3 "
                        #echo -e "$l_pkgoutput\n- Audit Result:\n *** FAIL: ***\n$output2\n"
                        #[ -n "$output" ] && echo -e "$output\n"
                fi
        else
                echo -e "|1.8.3    | Ensure GDM disable-user-list option is enabled (Automated)                                  | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
                #echo -e "\n\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not Applicable\n- Audit result:\n *** PASS ***\n"
        fi
}
#########################################################################################################################
#1.8.4
#desired output
#verify that the screen locks when the user is idle
#idle-delay=uint32 Should be 900 seconds (15 minutes) or less, not 0 (disabled) and follow local site policy
#lock-delay=uint32 should be 5 seconds or less and follow local site policy

#audit
{
        # Check if GNMOE Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n
        # determine system's package manager
        l_pkgoutput=""
        if command -v dpkg-query > /dev/null 2>&1; then
                l_pq="dpkg-query -W"
        elif command -v rpm > /dev/null 2>&1; then
                l_pq="rpm -q"
        fi
        # Check if GDM is installed
        l_pcl="gdm gdm3" # Space seporated list of packages to check
        for l_pn in $l_pcl; do
                $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
        done
        # Check configuration (If applicable)
        if [ -n "$l_pkgoutput" ]; then
                l_output="" l_output2=""
                l_idmv="900" # Set for max value for idle-delay in seconds
                l_ldmv="5" # Set for max value for lock-delay in seconds
                # Look for idle-delay to determine profile in use, needed for remaining tests
                l_kfile="$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/)" # Determine file containing idle-delay key
                if [ -n "$l_kfile" ]; then
                        # set profile name (This is the name of a dconf database)
                        l_profile="$(awk -F'/' '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")" #Set the key profile name
                        l_pdbdir="/etc/dconf/db/$l_profile.d" # Set the key file dconf db directory
                        # Confirm that idle-delay exists, includes unit32, and value is between 1 and max value for idle-delay
                        l_idv="$(awk -F 'uint32' '/idle-delay/{print $2}' "$l_kfile" | xargs)"
                        if [ -n "$l_idv" ]; then
                        [ "$l_idv" -gt "0" -a "$l_idv" -le "$l_idmv" ] && l_output="$l_output\n - The \"idle-delay\" option is set to \"$l_idv\" seconds in \"$l_kfile\""
                        [ "$l_idv" = "0" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" (disabled) in \"$l_kfile\""
                        [ "$l_idv" -gt "$l_idmv" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" seconds (greater than $l_idmv) in \"$l_kfile\""
                else
                        l_output2="$l_output2\n - The \"idle-delay\" option is not set in \"$l_kfile\""
                fi
                # Confirm that lock-delay exists, includes unit32, and value is between 0 and max value for lock-delay
                l_ldv="$(awk -F 'uint32' '/lock-delay/{print $2}' "$l_kfile" | xargs)"
                if [ -n "$l_ldv" ]; then
                        [ "$l_ldv" -ge "0" -a "$l_ldv" -le "$l_ldmv" ] && l_output="$l_output\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds in \"$l_kfile\""
                        [ "$l_ldv" -gt "$l_ldmv" ] && l_output2="$l_output2\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds (greater than $l_ldmv) in \"$l_kfile\""
                else
                        l_output2="$l_output2\n - The \"lock-delay\" option is not set in \"$l_kfile\""
                fi
                # Confirm that dconf profile exists
                if grep -Psq "^\h*system-db:$l_profile" /etc/dconf/profile/*; then
                        l_output="$l_output\n - The \"$l_profile\" profile exists"
                else
                        l_output2="$l_output2\n - The \"$l_profile\" doesn't exist"
                fi
                # Confirm that dconf profile database file exists
                if [ -f "/etc/dconf/db/$l_profile" ]; then
                        l_output="$l_output\n - The \"$l_profile\" profile exists in the dconf database"
                else
			l_output2="$l_output2\n - The \"$l_profile\" profile doesn't exist in the dconf database"
                fi
        else
                l_output2="$l_output2\n - The \"idle-delay\" option doesn't exist, remaining tests skipped"
        fi
else
        l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
fi
# Report results. If no failures output in l_output2, we pass
#[ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
if [ -z "$l_output2" ]; then
        echo -e "|1.8.4    | Ensure GDM screen locks when the user is idle (Automated)                                   | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
        #echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
else
        echo -e "${RED}|1.8.4    | Ensure GDM screen locks when the user is idle (Automated)                                   | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.8.4 "
        #echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
        #[ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
fi
}
#########################################################################################################################
#1.8.5
#desired output
#verify that the screen lock can not be overridden

#audit
{
        # Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n
        # determine system's package manager
        l_pkgoutput=""
        if command -v dpkg-query > /dev/null 2>&1; then
                l_pq="dpkg-query -W"
        elif command -v rpm > /dev/null 2>&1; then
                l_pq="rpm -q"
        fi
        # Check if GDM is installed
        l_pcl="gdm gdm3" # Space seporated list of packages to check
        for l_pn in $l_pcl; do
                $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
        done
        # Check configuration (If applicable)
        if [ -n "$l_pkgoutput" ]; then
                l_output="" l_output2=""
                # Look for idle-delay to determine profile in use, needed for remaining tests
                l_kfd="/etc/dconf/db/$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
                l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*lock-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
                if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked
                        if grep -Prilq '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd"; then
                                l_output="$l_output\n - \"idle-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd")\""
                        else
                                l_output2="$l_output2\n - \"idle-delay\" is not locked"
                        fi
                else
                        l_output2="$l_output2\n - \"idle-delay\" is not set so it can not be locked"
                fi
                if [ -d "$l_kfd2" ]; then # If key file directory doesn't exist, options can't be locked
                        if grep -Prilq '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2"; then
                                l_output="$l_output\n - \"lock-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2")\""
                        else
                                l_output2="$l_output2\n - \"lock-delay\" is not locked"
                        fi
                else
                        l_output2="$l_output2\n - \"lock-delay\" is not set so it can not be locked"
                fi
        else
                l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
        fi
        # Report results. If no failures output in l_output2, we pass
        #[ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
        if [ -z "$l_output2" ]; then
                echo -e "|1.8.5    | Ensure GDM screen locks cannot be overridden (Automated)                                    | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
                #echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
        else
                echo -e "${RED}|1.8.5    | Ensure GDM screen locks cannot be overridden (Automated)                                    | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="1.8.5 "
                #echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
                #[ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
        fi
}
#########################################################################################################################
#1.8.6
#desired output
#verify automatic mounting is disabled

#audit
{
        l_pkgoutput="" l_output="" l_output2=""
        # Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n
        # determine system's package manager
        if command -v dpkg-query > /dev/null 2>&1; then
                l_pq="dpkg-query -W"
        elif command -v rpm > /dev/null 2>&1; then
                l_pq="rpm -q"
        fi
        # Check if GDM is installed
        l_pcl="gdm gdm3" # Space seporated list of packages to check
        for l_pn in $l_pcl; do
                $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
        done
        # Check configuration (If applicable)
        if [ -n "$l_pkgoutput" ]; then
                #echo -e "$l_pkgoutput"
                # Look for existing settings and set variables if they exist
                l_kfile="$(grep -Prils -- '^\h*automount\b' /etc/dconf/db/*.d)"
                l_kfile2="$(grep -Prils -- '^\h*automount-open\b' /etc/dconf/db/*.d)"
                # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
                if [ -f "$l_kfile" ]; then
                        l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")"
                elif [ -f "$l_kfile2" ]; then
                        l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile2")"
                fi
                # If the profile name exist, continue checks
                if [ -n "$l_gpname" ]; then
                        l_gpdir="/etc/dconf/db/$l_gpname.d"
                        # Check if profile file exists
                        if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then
                                l_output="$l_output\n - dconf database profile file \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists"
                        else
                                l_output2="$l_output2\n - dconf database profile isn't set"
                        fi
                        # Check if the dconf database file exists
                        if [ -f "/etc/dconf/db/$l_gpname" ]; then
                                l_output="$l_output\n - The dconf database \"$l_gpname\" exists"
                        else
                                l_output2="$l_output2\n - The dconf database \"$l_gpname\" doesn't exist"
                        fi
                        # check if the dconf database directory exists
                        if [ -d "$l_gpdir" ]; then
                                l_output="$l_output\n - The dconf directory \"$l_gpdir\" exitst"
                        else
                                l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" doesn't exist"
                        fi
                        # check automount setting
                        if grep -Pqrs -- '^\h*automount\h*=\h*false\b' "$l_kfile"; then
                                l_output="$l_output\n - \"automount\" is set to false in: \"$l_kfile\""
                        else
                                l_output2="$l_output2\n - \"automount\" is not set correctly"
			fi
                        # check automount-open setting
                        if grep -Pqs -- '^\h*automount-open\h*=\h*false\b' "$l_kfile2"; then
                                l_output="$l_output\n - \"automount-open\" is set to false in: \"$l_kfile2\""
                        else
                                l_output2="$l_output2\n - \"automount-open\" is not set correctly"
                        fi
                else
                        # Setings don't exist. Nothing further to check
                        l_output2="$l_output2\n - neither \"automount\" or \"automount-open\" is set"
                fi
        else
                l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
        fi
        # Report results. If no failures output in l_output2, we pass
        if [ -z "$l_output2" ]; then
                echo -e "|1.8.6    | Ensure GDM automatic mounting of removable media is disabled (Automated)                    | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
                #echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
        else
                echo -e "${RED}|1.8.6    | Ensure GDM automatic mounting of removable media is disabled (Automated)                    | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="1.8.6 "
                #echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
                #[ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
        fi
}
#########################################################################################################################
#1.8.7
#desired output
#verify disable automatic mounting is locked

#audit
{
        # Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable
        # Determine system's package manager
        l_pkgoutput=""
        if command -v dpkg-query > /dev/null 2>&1; then
                l_pq="dpkg-query -W"
        elif command -v rpm > /dev/null 2>&1; then
                l_pq="rpm -q"
        fi

        # Check if GDM is installed
        l_pcl="gdm gdm3" # Space-separated list of packages to check
        for l_pn in $l_pcl; do
                $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
        done

        # Check configuration (If applicable)
        if [ -n "$l_pkgoutput" ]; then
                l_output=""
                l_output2=""

                # Look for idle-delay to determine profile in use, needed for remaining tests
                l_kfd="/etc/dconf/db/$(grep -Psril '^\h*automount\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" # set directory of key file to be locked
                l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*automount-open\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" # set directory of key file to be locked

                if [ -d "$l_kfd" ]; then
                        # If key file directory doesn't exist, options can't be locked
                        if grep -Piq '^\h*\/org/gnome\/desktop\/media-handling\/automount\b' "$l_kfd"; then
                                l_output="$l_output\n - \"automount\" is locked in \"$(grep -Pil '^\h*\/org/gnome\/desktop\/media-handling\/automount\b' "$l_kfd")\""
                        else
                                l_output2="$l_output2\n - \"automount\" is not locked"
                        fi
                else
                        l_output2="$l_output2\n - \"automount\" is not set, so it cannot be locked"
                fi

                if [ -d "$l_kfd2" ]; then
                        # If key file directory doesn't exist, options can't be locked
                        if grep -Piq '^\h*\/org/gnome\/desktop\/media-handling\/automount-open\b' "$l_kfd2"; then
                                l_output="$l_output\n - \"automount-open\" is locked in \"$(grep -Pril '^\h*\/org/gnome\/desktop\/media-handling\/automount-open\b' "$l_kfd2")\""
                        else
                                l_output2="$l_output2\n - \"automount-open\" is not locked"
                        fi
                else
                        l_output2="$l_output2\n - \"automount-open\" is not set, so it cannot be locked"
                fi
        else
                l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
        fi

        # Report results. If no failures output in l_output2, we pass
        #[ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
	if [ -z "$l_output2" ]; then
                echo -e "|1.8.7    | Ensure GDM disabling automatic mounting of removable media is not overridden (Automated)    | ${green}Pass${clr}               |"
		((total_audit++))
		((pass_count++))
                #echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
        else
                echo -e "${RED}|1.8.7    | Ensure GDM disabling automatic mounting of removable media is not overridden (Automated)    | Fail               |${clr}"
		((total_audit++))
		((fail_count++))
		failed_audits+="1.8.7 "
                #echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
                #[ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
        fi
}
#########################################################################################################################
#1.8.8
#desired output
#verify that autorun-never is set to true for GDM
#default value:
#false

#audit
{
    l_pkgoutput=""
    l_output=""
    l_output2=""

    # Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable
    # Determine system's package manager
    if command -v dpkg-query > /dev/null 2>&1; then
        l_pq="dpkg-query -W"
    elif command -v rpm > /dev/null 2>&1; then
        l_pq="rpm -q"
    fi

    # Check if GDM is installed
    l_pcl="gdm gdm3" # Space separated list of packages to check
    for l_pn in $l_pcl; do
        $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
        # Print package check results
        # echo -e "$l_pkgoutput"
    done

    # Check configuration (If applicable)
    if [ -n "$l_pkgoutput" ]; then
        l_kfile="$(grep -Prils -- '^\h*autorun-never\b' /etc/dconf/db/*.d)"

        # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
        if [ -f "$l_kfile" ]; then
            l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")"
        fi

        # If the profile name exists, continue checks
        if [ -n "$l_gpname" ]; then
            l_gpdir="/etc/dconf/db/$l_gpname.d"

            # Check if profile file exists
            if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then
                l_output="$l_output\n - dconf database profile file \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists"
            else
                l_output2="$l_output2\n - dconf database profile isn't set"
            fi

            # Check if the dconf database file exists
            if [ -f "/etc/dconf/db/$l_gpname" ]; then
                l_output="$l_output\n - The dconf database \"$l_gpname\" exists"
            else
                l_output2="$l_output2\n - The dconf database \"$l_gpname\" doesn't exist"
            fi

            # Check if the dconf database directory exists
            if [ -d "$l_gpdir" ]; then
                l_output="$l_output\n - The dconf directory \"$l_gpdir\" exists"
            else
		l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" doesn't exist"
            fi

            # Check autorun-never setting
            if grep -Pqrs -- '^\h*autorun-never\h*=\h*true\b' "$l_kfile"; then
                l_output="$l_output\n - \"autorun-never\" is set to true in: \"$l_kfile\""
            else
                l_output2="$l_output2\n - \"autorun-never\" is not set correctly"
            fi
        else
            # Settings don't exist. Nothing further to check
            l_output2="$l_output2\n - \"autorun-never\" is not set"
        fi
    else
        l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
    fi

    # Report results. If no failures output in l_output2, we pass
    if [ -z "$l_output2" ]; then
            echo -e "|1.8.8    | Ensure GDM autorun-never is enabled (Automated)                                             | ${green}Pass${clr}               |"
	    ((total_audit++))
	    ((pass_count++))
            #echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
    else
            echo -e "${RED}|1.8.8    | Ensure GDM autorun-never is enabled (Automated)                                             | Fail               |${clr}"
	    ((total_audit++))
	    ((fail_count++))
	    failed_audits+="1.8.8 "
            #echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
            #[ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
    fi
}
#########################################################################################################################
#1.8.9
#desired output
#verify that autorun-never=true cannot be overridden

#audit
{
  # Check if GNOME Desktop Manager is installed. If the package isn't installed, the recommendation is Not Applicable.
  # Determine the system's package manager.
  l_pkgoutput=""

  if command -v dpkg-query > /dev/null 2>&1; then
    l_pq="dpkg-query -W"
  elif command -v rpm > /dev/null 2>&1; then
    l_pq="rpm -q"
  fi

  # Check if GDM is installed.
  l_pcl="gdm gdm3" # Space separated list of packages to check for.

  for l_pn in $l_pcl; do
    $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
  done

  # Check configuration (If applicable).
  if [ -n "$l_pkgoutput" ]; then
    l_output=""
    l_output2=""

    # Look for idle-delay to determine the profile in use, needed for remaining tests.
    l_kfd="/etc/dconf/db/$(grep -Psril '^\h*autorun-never\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" # set the directory of the key file to be locked.

    if [ -d "$l_kfd" ]; then
      # If the key file directory doesn't exist, options can't be locked.
      if grep -Piq '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd"; then
        l_output="$l_output\n - \"autorun-never\" is locked in \"$(grep -Pil '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd")\""
      else
        l_output2="$l_output2\n - \"autorun-never\" is not locked"
      fi
    else
      l_output2="$l_output2\n - \"autorun-never\" is not set, so it cannot be locked"
    fi
  else
    l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
  fi

  # Report results. If no failures output in l_output2, we pass.
  #[ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"

  if [ -z "$l_output2" ]; then
          echo -e "|1.8.9    | Ensure GDM autorun-never is not overridden (Automated)                                      | ${green}Pass${clr}               |"
	  ((total_audit++))
	  ((pass_count++))
          #echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
  else
          echo -e "${RED}|1.8.9    | Ensure GDM autorun-never is not overridden (Automated)                                      | Fail               |${clr}"
	  ((total_audit++))
	  ((fail_count++))
	  failed_audits+="1.8.9 "
          #echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
          #[ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
  fi
}
#########################################################################################################################
#1.8.10
#desired output
#verify audit comamnd return nothing
#default value:
#false (This is denoted by no Enabled= entry in the file /etc/gdm3/custom.conf in the [xdmcp] section

#audit command
audit=$(grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm3/custom.conf)

#check audit comamnd returns nothing
if [[ -z $audit ]]; then
        echo -e "|1.8.10   | Ensure XDCMP is not enabled (Automated)                                                     | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
else
        echo -e "${RED}|1.8.10   | Ensure XDCMP is not enabled (Automated)                                                     | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
	failed_audits+="1.8.10 "
fi
#########################################################################################################################
#1.9
#desired output
#Verify there are no updates or patches to install

#audit command
#WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
audit=$(apt -s upgrade 2>/dev/null)

#check no updates or patches to install
if echo "$audit" | grep -qE '^[0-9]+ upgraded' && echo "$audit" | grep -qE '^[0-9]+ installed'; then
        echo -e "${RED}|1.9      | Ensure updates, patches, and additional security software are installed (Manual)            | Fail               |${clr}"
	((total_audit++))
	((fail_count++))
        failed_audits+="1.9 "
else
        echo -e "|1.9      | Ensure updates, patches, and additional security software are installed (Manual)            | ${green}Pass${clr}               |"
	((total_audit++))
	((pass_count++))
fi
#########################################################################################################################

#########################################################################################################################
#end of CIS section 1 audit
#########################################################################################################################

#echo total compliance
echo -e "|---------|---------------------------------------------------------------------------------------------|--------------------|"
echo -e "                                                                                       Total Audit     :| $total_audit     "
echo -e "                                                                                       Total Compliance:| ${green}Pass${clr} Count: ${green}$pass_count${clr}/$total_audit"
echo -e "                                                                                                        | ${red}Fail${clr} Count: ${red}$fail_count${clr}/$total_audit"
echo -e "                                                                                                        | ${yellow}Cannot be Accessed${clr} Count: ${yellow}$Cannot_be_Accessed_count${clr}/$total_audit"
echo -e "|---------|---------------------------------------------------------------------------------------------|----------------------\n"


