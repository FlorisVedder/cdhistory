##############################################################################################
#
# Name: cdhistory.sh
#
# Gives a list of last reached absolute paths
#
# Usage: See Readme
#
# Author: Floris Vedder
#
# Date: 2017/08/12
#############################################################################################

#!/bin/sh
pathoptions=''
IFS=$'\n'
# Fetch all absolute paths from your history
history_paths=$(history | grep -o '/Volumes/[^.]*\|~/[^.]*' \
 | tr -cd 'A-Za-z0-9_-\\/~\n\r\ ' | sed -e 's/\(\/\)*$//g' | sort -u | tail -50)
for history_path in $history_paths ; do
    #check if it are indeed directories before adding them to the options
    #first make sure the ~ works in the script so replace it with the real absolute path 
    if [[ $history_path == ~* ]]; then
        absolute_path="${history_path/#\~/$HOME}"
    else
	absolute_path="$history_path"
    fi
    #no we can do the check to see if it's a directory
    if [ -d "$absolute_path" ] && [ $history_path != "~" ]; then
	# except for the first option we will add an enter \n bfore adding a path to the list pathoptions to get a nice list
	if [ -z "$pathoptions" ]; then
    		pathoptions=$(printf "$history_path")
	else
		pathoptions=$(printf "$pathoptions\n$history_path")
	fi
     fi
done

# create a option list
PS3='Please enter your choice: '
options=( $pathoptions )
select path in "${options[@]}"
do
	# replace the tilde for an absolute path when it starts with the tilde
	if [[ $path == ~* ]]; then
		path="${path/#\~/$HOME}"
	fi

	# inform the user with a correct feedback
	if [ ! -d "$path" ]; then
                echo "sorry, this choice is not a directory (anymore)"
                break
	else
		echo "you're directory will be changed to: $path"
        fi

	# change directory to the chosen path
	cd $path
	break
done

