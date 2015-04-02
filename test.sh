#!/bin/bash

file=junk.sh

if [ ! -f "$file" ]; then
    echo -e "Error: File '$file' not found.\nTest failed."
    exit 1
fi

num_right=0
total=0
line="________________________________________________________________________"
compiler=
interpreter=
language=
extension=${file##*.}
if [ "$extension" = "py" ]; then
    if [ ! -z "$PYTHON_PATH" ]; then
        interpreter=$(which python.exe)
    else
        interpreter=$(which python3.2)
    fi
    command="$interpreter $file"
    echo -e "Testing $file\n"
elif [ "$extension" = "java" ]; then
    language="java"
    command="java ${file%.java}"
    echo -n "Compiling $file..."
    javac $file
    echo -e "done\n"
elif [ "$extension" = "sh" ]; then
    chmod 755 $file
	command="./$file"
	echo -e "Testing $file\n"
fi

run_test_args() {
    (( ++total ))
    echo -n "Running test $total..."
    expected=$2
    received=$( $command $1 2>&1 | tr -d '\r' )
    if [ "$expected" = "$received" ]; then
        echo "success"
        (( ++num_right ))
    else
        echo -e "failure\n\nExpected$line\n$expected\nReceived$line\n$received\n"
    fi
}

run_test_args_regex() {
    (( ++total ))
    echo -n "Running test $total..."
    local expected=$2
    local received=$( $command $1 2>&1 | tr -d '\r' )
    if [[ $received =~ $expected ]]; then
        echo "success"
        (( ++num_right ))
    else
        echo -e "failure\n\nExpected$line\n$expected\nReceived$line\n$received\n"
    fi
}

run_test_grep() {
    (( ++total ))
    echo -n "Running test $total..."
    local val=$( grep -n "$1" "$command" 2>/dev/null )
    if [ $? -eq 0 ]; then
        echo -e "success\nFound:\n$val\n"
        (( ++num_right ))
    else
        echo -e "failure\nRequired keyword '$1' not found in source code.\n"
    fi
}

run_test_dir() {
    (( ++total ))
    echo -n "Running test $total..."
    if [ -d "`eval echo $1`" ]; then
        echo "success"
        (( ++num_right ))
    else
        echo -e "failure\nDirectory '$1' not found.\n"
    fi
}

run_test_file() {
    (( ++total ))
    echo -n "Running test $total..."
    if [ -f "`eval echo $1`" ]; then
        echo "success"
        (( ++num_right ))
    else
        echo -e "failure\nFile '$1' not found.\n"
    fi
}

rm -fr ~/.junk/*
run_test_grep "basename"
run_test_grep "readonly"
run_test_grep "getopts"
run_test_grep "cat <<"
run_test_args "" "Usage: junk.sh [-hlp] [list of files]"$'\n'"   -h: Display help."$'\n'"   -l: List junked files."$'\n'"   -p: Purge all files."$'\n'"   [list of files] with no other arguments to junk those files."
run_test_args "-h" "Usage: junk.sh [-hlp] [list of files]"$'\n'"   -h: Display help."$'\n'"   -l: List junked files."$'\n'"   -p: Purge all files."$'\n'"   [list of files] with no other arguments to junk those files."
run_test_args "-l" "total 0"
run_test_dir "~/.junk"
touch a.txt
run_test_args "a.txt" ""
run_test_file "~/.junk/a.txt"
run_test_args_regex "-l" "total 0(.*)a.txt"
run_test_args "-p" ""
run_test_args "-l" "total 0"
touch b.txt c.txt
run_test_args "b.txt c.txt" ""
run_test_file "~/.junk/b.txt"
run_test_file "~/.junk/c.txt"
run_test_args_regex "-l" "total 0(.*)b.txt(.*)c.txt"
run_test_args "not_exists.txt" "mv: cannot stat \`not_exists.txt': No such file or directory"
rm -fr ~/.junk/* 

echo -e "\nTotal tests run: $total"
echo -e "Number correct : $num_right"
echo -n "Percent correct: "
echo "scale=2; 100 * $num_right / $total" | bc

if [ "$language" = "java" ]; then
   echo -e -n "\nRemoving class files..."
   rm -f *.class
   echo "done"
fi
