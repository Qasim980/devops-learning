#!/bin/bash

# Check if the archer.txt file exists in the current directory

# If it does, display its contents. If not, print "no file provided".

if [ -f "archer.txt" ]; then
    cat archer.txt
else
    echo "no file provided"
fi