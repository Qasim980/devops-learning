#!/bin/bash

# Check if the hero.txt file exists in the Arena directory

if [ -f "Arena/hero.txt" ]; then
    echo "Hero found!"
else
    echo "Hero missing!"
fi