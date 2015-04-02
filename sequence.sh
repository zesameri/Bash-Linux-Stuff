#!/bin/bash
str=""
fibonacci() {
    echo -n "Fibonacci numbers:"
    fibonacci_lucas $1 1 1 "Fibonacci"
    
}
lucas() {
    echo -n "Lucas numbers:"
    fibonacci_lucas $1 2 1 "Lucas"
}
triangular() {
    echo Triangular numbers:
    numtri=$1
    add=2
    sumtri=1
    str+="1 "
    while [ $add -le $numtri ]; do
        sumtri=$(( $sumtri + $add ))
        str+=" "
        str+=$sumtri
        add=$(( $add + 1 ))
    done
    echo -e $str
}
fibonacci_lucas() {
    num=$1
    count=2
    a=$2
    b=$3
    echo 
    if [ $2 -eq 1 ]; then
        str+="1"
        
    elif [ $2 -eq 2 ]; then
        str+="2"
    fi
    if [ $num -ge 2 ]; then 
        str+=" 1"
    fi

        
    while [ $count -lt $num ]; do
        sum=$(( $a + $b ))
        if [ $sum -lt $b ]; then
            
            #if fib or luc 
            if [ $2 -eq 1 ]; then
                str+='\n'
                str+="Cannot list all $num Fibonacci numbers."
                break;
            else
                str+='\n'
                str+="Cannot list all $num Lucas numbers."
                break;
            fi
            
        fi
        str+=" "
        str+=$sum

        a=$b
        b=$sum
        count=$(( $count + 1 ))
    done

    echo -e $str
}

if [ $# -ne 2 ]; then #the $# is the number of arguments
	echo "Usage: $0 <sequence type> <num elements>" 
	exit 1
fi
case "$1" in #$1 is the sequence type
	"fib" ) #if the type is "fib"
		fibonacci $2
		;; #break
	"luc" ) #if the type is "bye"
		lucas $2
		;;
	"tri" )
	    triangular $2
	    ;;
	* ) #default case
		echo "Error: Unrecognized sequence type '$1'."
		exit 1
		;;
esac
