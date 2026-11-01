#!/bin/bash

score=95

if [ $score -ge 90 ] 
then
    echo "Pass"
elif [ $score -ge 80 ]
then
    echo "Good"
else 
    echo "Sorry"
fi 