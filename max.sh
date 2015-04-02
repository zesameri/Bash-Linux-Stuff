#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usages: $0 <list of integers>"
    exit 1
fi
max=$1
for val in $@; do
    if [ $val -gt $max ]; then
        max=$val
    fi
done
echo $max
