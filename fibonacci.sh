#!/bin/bash
echo -n "How many numbers? "
read num
fibstr="1"
count=2
a=1
b=1
bleh=$(( $num - 1 ))

if [ $num -ge 2 ]; then 
    fibstr+=" 1"
fi

    
while [ $count -lt $num ]; do
    sum=$(( $a + $b ))
    if [ $sum -lt $b ]; then
        fibstr+='\n'
        fibstr+="Cannot list all $num Fibonacci numbers."
        break;
    fi
    fibstr+=" "
    fibstr+=$sum

    a=$b
    b=$sum
    count=$(( $count + 1 ))
done

echo -e $fibstr
