#!/bin/bash

#Checks if there is stored data
if [ -f /tmp/data.txt ]; then
	# Read data from data.txt
	data=($(cat /tmp/data.txt))
	
	#Checker for labels
	checker=1

	echo "Data Graph:"
	for value in "${data[@]}"; do
    		bar=""
    		#Using the checker for the labels
    		#Data transfered into the data.txt file should be in the order of pass, fail, no access, total
    		if [ "$checker" -eq 1 ]; then
    			text="Passes   |"
    		elif [ "$checker" -eq 2 ]; then
    			text="Fails    |"
    		elif [ "$checker" -eq 3 ]; then
    			text="No Access|"
    		elif [ "$checker" -eq 4 ]; then
    			text="Total    |"
    		else 
    			#Breaks the script if there are 5 or more values in the data.txt file
    			echo "Error: Too many values present"
    			break
    		fi
    
    		for ((i = 0; i < value; i++)); do
        		bar+="■"
    		done
    		
    		#Printing the data
    		echo "$text$bar ($value)"
    	
    		#Increasing the checker to ensure that the script runs 4 times
    		checker=$((checker + 1))
		done
		rm /tmp/data.txt
else
	#echos an error message if no data is present
	echo "There is no data to display. Please ensure that you have ran a audit check to obtain data."
fi
