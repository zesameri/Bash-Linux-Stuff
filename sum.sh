#!/bin/bash

compute_sum () {
    sum=0
    for a in $(seq $1 $2); do
        copy=$sum
        sum=$(( $a + $sum ))
        if [ $sum -lt $copy ]; then
            echo "sum[$1..$2] = overflow"
            exit 1
        fi
    done 
    echo "sum[$1..$2] = $sum"
    exit 1
}    

if [ $# -ne 2 ]; then  
	echo "Usage: $0 <lower bound> <upper bound>" 
	exit 1
else
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        if [ $1 -ge 0 ]; then
            if [[ "$2" =~ ^[0-9]+$ ]]; then
                if [ $2 -ge 0 ]; then
                    if [ $1 -gt $2 ]; then
                        echo "Error: Upper bound must be >= lower bound."
                        exit 1
                    else
                        compute_sum $1 $2
                    fi
                else
                    echo "Error: Upper bound must be a positive integer."
                    exit 1
                fi
            else
                echo "Error: Upper bound must be a positive integer."
                exit 1
            fi
        else
            echo "Error: Lower bound must be a positive integer."
            exit 1
        fi
    else 
        echo "Error: Lower bound must be a positive integer."
        exit 1
    fi

fi

