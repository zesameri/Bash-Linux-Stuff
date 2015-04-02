#!/bin/bash
echo -n "What is your name? "
read name
echo "Hello $name"
a=5
b=6
c=$(( $a + $b ))
echo $c
if [ $c -lt 10 ]; then
	echo "c is less than 10"
elif [ $c -eq 10 ]; then 
	echo "c is equal to 10"
else
	echo "c is greater than 10"
fi
#-lt is less than
#-gt is greater than
#-le is less equal
#-ne is not equal
# fi is backward fi
n=0
while [ $n -lt 10 ]; do
	echo -n "$n "
	n=$(( $n +1 ))
	if [ $n -eq 7 ]; then
		break
	fi
	
done
echo -n
