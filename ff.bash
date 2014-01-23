#!/bin/bash

path="$1"
filepattern="$2"
pattern="$3"

function help {
	printf "\nUse: $0 path file_pattern pattern\n\npath\t\t\tPath to search in\nfile_pattern\t\tA file name or pattern\npattern\t\t\tA pattern to search in the file(s)\n\nPatterns with wildcards should be surrounded bu quotes \" or \'\n\ne.g.\t$0 . \"*.py\" create_course_shell\n"
}

if [[ -d "$path" ]]; then
	if [[ "$pattern" == "" ]]; then
		help
		exit 1
	else
		find "$path" -name "$filepattern" | while read file; do
			if [[ ! -d "$file" ]]; then
				is_present=`grep "$pattern" "$file" | wc -l`
				if [ $is_present -ge 1 ]; then
					echo "$file"
					grep -ni "$pattern" "$file"
				fi
			fi
		done
	fi
else
	help
	exit 1
fi
