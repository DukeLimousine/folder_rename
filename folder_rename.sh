#!/bin/bash
if [ "$1" != "" ]; then
	if [[ -d $1 ]]; then
		directory="$1"
		echo "Are you sure $directory is the correct folder? Press y / Y + enter if yes. Otherwise, any other key and / or enter to exit."
		read input </dev/tty
				if [[ "$input" == "y" || "$input" == "Y" ]]; then 
					echo "Continuing..."
				else
					exit
				fi
	else
		echo "$1 is not a valid directory. Exiting."
	 		exit 1
	fi
else
	echo "No directory entered. Exiting."
	exit
fi

for filepath in "$directory"/*; do
	echo "Inspecting $filepath"
	for file in "$filepath"/*; do
		#Ensure filetype is file
		if [[ -d $file ]]; then
			echo "$file is a directory"
		elif [[ -f $file ]]; then
			basefilepath="$(basename -- $filepath)"
			finalname="$filepath/${basefilepath}.${file##*.}"
			#Test for potential overwrites
			if test -f "$finalname"; then
				echo "Skip renaming $file ? This will overwrite another file that has already been renamed. Press N + enter to overwrite (not reccommended) or any other key + enter to skip."
				read input </dev/tty
				if [[ "$input" == "n" || "$input" == "N" ]]; then 
					echo "Continuing..."
				else
					continue
				fi
			fi
			echo "Renaming $file to $finalname"
			mv "$file" "$finalname"
	 	else
	 		echo "$file is not valid"
	 		exit 1
	 	fi
	done
done