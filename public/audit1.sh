#!/bin/bash

# Specify the output file path
output_file="s6audit.txt"

# Redirect script output to the specified file
exec > >(tee "$output_file") 2>&1

# ANSI color codes for highlighting
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to run individual script and capture output
run_script() {
  local script_output=$(./"$1")
  echo "$script_output"
}

# Function to parse compliance status from individual script output
get_compliance_status() {
  local output="$1"
  local status=$(echo "$output" | awk '/Compliance:/ {print $2}')
  echo "$status"
}

# Function to parse title from individual script output
get_title() {
  local output="$1"
  local title=$(echo "$output" | awk -F ': ' '/Title/ {print $2}')
  echo "$title"
}

# Function to parse section from individual script output
get_section() {
  local output="$1"
  local section=$(echo "$output" | awk -F ': ' '/Section/ {print $2}')
  echo "$section"
}

# Create table header
echo -e "Section | Title | Compliance"
echo -e "------- | ----- | ----------"

# Individual scripts and their corresponding section numbers
scripts=(
  "5.1.1new.sh"
  "5.1.2.sh"
  "5.1.3.sh"
  "5.1.4.sh"
  "5.1.5.sh"
  "5.1.6.sh"
  "5.1.7.sh"
  "5.1.8FIX.sh"
  "5.1.9.sh"
  "5.2.1.sh"
  "5.2.3.sh"
  "5.2.4.sh"
  "5.2.5.sh"
  "5.2.6.sh"
  "5.2.7.sh"
  "5.2.8.sh"
  "5.2.9.sh"
  "5.2.10.sh"
  "5.2.11.sh"
  "5.2.12.sh"
  "5.2.13.sh"
  "5.2.14.sh"
  "5.2.15.sh"
  "5.2.16.sh"
  "5.2.17.sh"
  "5.2.18FIX.sh"
  "5.2.19.sh"
  "5.2.20.sh"
  "5.2.21FIX.sh"
  "5.2.22FIX.sh"
  "5.3.1.sh"
  "5.3.2.sh"
  "5.3.3.sh"
  "5.3.4.sh"
  "5.3.5.sh"
  "5.3.6.sh"
  "5.3.7.sh"
  "5.5.1.1.sh"


  # "5.5.1.1.sh"
  # "5.5.1.2.sh"
  # "5.5.1.3.sh"
  # "5.5.1.4.sh"
  # "5.5.1.5.sh"
  # "5.5.2.sh"
  # "5.5.3.sh"
  # "5.5.4.sh"
  # "5.5.5.sh"
  # Add more scripts here as needed
)

# Loop through the scripts and print compliance information in table format
for script in "${scripts[@]}"; do
  output=$(run_script "$script")
  section="$(get_section "$output")"
  title="$(get_title "$output")"
  compliance="$(get_compliance_status "$output")"
  
  if [ "$compliance" == "Fail" ]; then
    echo -e "${RED}${section} | ${title} | ${compliance}${NC}"
  else
    echo -e "${GREEN}${section} | ${title} | ${compliance}${NC}"
  fi
done | column -t -s '|'

# Remove color codes from output and save to file
sed 's/\x1B\[[0-9;]*[JKmsu]//g' "$output_file" > temp_file.txt
mv temp_file.txt "$output_file"

