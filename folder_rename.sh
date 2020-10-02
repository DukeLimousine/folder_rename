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
		if [[ -d $file ]]; then
			echo "$file is a directory"
		elif [[ -f $file ]]; then
			basefilepath="$(basename -- $filepath)"
			echo "Renaming $file to $filepath/${basefilepath}.${file##*.}"
			mv "$file" "$filepath/${basefilepath}.${file##*.}"
	 	else
	 		echo "$file is not valid"
	 		exit 1
	 	fi
	done
done