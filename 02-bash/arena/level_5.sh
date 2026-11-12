#!/bin/bash

# Create a directory called Battlefield and create three files inside it
mkdir Battlefield

touch Arena/Battlefield/knight.txt Arena/Battlefield/sorcerer.txt Arena/Battlefield/rogue.txt


# Check if the knight.txt file exists in the Battlefield directory. If it does, move it to a new directory called Archive.

if [ -f "Arena/Battlefield/knight.txt" ]; then
mkdir -p Arena/Archive
    mv Arena/Battlefield/knight.txt Arena/Archive/
fi

# List the contents of the Battlefield and Archive directories

ls Arena/Battlefield
ls Arena/Archive