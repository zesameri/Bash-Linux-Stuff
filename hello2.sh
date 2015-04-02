#!/bin/bash

greeting() { 
	echo "Hello, $1 $2" #The $ sign and then the number is the argument that is passed in when the function is called.
}

bye() { 
	echo "Bye, $1" 
}

#Function must be defined above the code form where it is called. In functions, arguments are referred to positionally. (ie. $1, $2, etc.)

if [ $# -ne 2 ]; then #the $# is the number of arguments
	echo "Usage: $0 <type> <name>" 
	exit 1
fi
case "$1" in #$1 is the type
	"hello" ) #if the type is "hello"
		greeting $2 "Schlein"
		;; #break
	"bye" ) #if the type is "bye"
		bye $2 "Schlein"
		;;
	* ) #default case
		echo "I have no idea what option that is."
		exit 1
		;;
esac
greeting $1 "Schlein" #<- hardcoded last name into the program with a string literal, quotes are not needed.

