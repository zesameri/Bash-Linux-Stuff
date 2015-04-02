#!/bin/bash

# Constants
readonly JUNK_DIR=~/.junk #files that begin with a . are considered hidden
#ls -a shows such files

# Global variables
declare -a file_list #declares an array
file_count=0
help_flag=0
list_flag=0
purge_flag=0
file_flag=0
# basename is narrowed done folder
#functions
display_usage () {
    echo "Usage: $(basename "$0") [-hlp] [list of files]"
#here document
cat << ENDOFTEXT
   -h: Display help.
   -l: List junked files.
   -p: Purge all files.
   [list of files] with no other arguments to junk those files.
ENDOFTEXT
}

# Process command line arguments with getops
#getapt strings started with a colon suppress error message
while getopts ":hlp" option; do
    case "$option" in
        h) help_flag=1
           ;;
        l) list_flag=1
           ;;
        p) purge_flag=1
           ;;
        ?) printf " Error: Unknown option' -%s'.\n" $OPTARG >&2
           #OPTARG is built in variable along with getopts
           display_usage $0
           exit 1
           ;;
    
    esac

done

#processing remaining arguments, which should be a list of files

shift $((OPTIND-1))
for file in $@; do
    #put files in array
    file_list[$file_count]=$file
    (( ++file_count ))
done

if [ $file_count -gt 0 ]; then
    file_flag=1
fi

# Check for too many options
total=$(( $help_flag + $file_flag + $list_flag + $purge_flag ))

if [ $total -ne 1 ]; then
    if [ $total -gt 1 ]; then
        echo "Error: to many options enabled." >&2
    fi
    display_usage
    exit 1
fi

# If junk directory doesn't exist, create it
if [[ ! -d $JUNK_DIR ]]; then
    mkdir $JUNK_DIR
fi
# Process each flag

if [ $help_flag -eq 1 ]; then
    display_usage

elif [ $list_flag -eq 1 ]; then
    if [ $file_flag -eq 0 ]; then
        echo "total 0" 
    fi
    for file in $file_list; do
        echo -n $file
    done

elif [ $purge_flag -eq 1 ]; then
    rm -rf JUNK_DIR
    
else
    for file in $file_list; do
        if [ ! -f $file ]; then 
            echo "mv: cannot stat '$file': No such file or directory"
        else
            rm $file
        fi
    done
fi

