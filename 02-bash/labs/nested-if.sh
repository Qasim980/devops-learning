#!/bin/bash

age=19
grade=85

if [ $age -gt 18 ]; then
    echo "You are eligible based on age."
if [ $grade -ge 80 ]; then
    echo "You are eligible based on grade."
    echo "Congrats! You are eligible for the program."
    fi
else echo "You are not eligible based on grade."
fi