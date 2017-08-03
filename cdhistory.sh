pathoptions=''
IFS=$'\n'
history_paths=$(history | grep -o '/Volumes/[^.]*\|~/[^.]*' \
 | tr -cd 'A-Za-z0-9_-\\/~\n\r\ ' | sed -e 's/\(\/\)*$//g' | sort -u | tail -50)
for history_path in $history_paths ; do
    #check if it are indeed directories before adding them to the options
    if [[ $history_path == ~* ]]; then
        absolute_path="${history_path/#\~/$HOME}"
    else
	absolute_path="$history_path"
    fi
    if [ -d "$absolute_path" ] && [ $history_path != "~" ]; then
	if [ -z "$pathoptions" ]; then
    		pathoptions=$(printf "$history_path")
	else
		pathoptions=$(printf "$pathoptions\n$history_path")
	fi
     fi
done

PS3='Please enter your choice: '
options=( $pathoptions )
select path in "${options[@]}"
do
	if [[ $path == ~* ]]; then
		path="${path/#\~/$HOME}"
	fi
	if [ ! -d "$path" ]; then
                echo "sorry, this choice is not a directory (anymore)"
                break
	else
		echo "you're directory will be changed to: $path"
        fi

	cd $path
	break
done

