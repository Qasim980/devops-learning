#!/bin/bash

DIRECTORY="Arena"
SEARCH_TERM="Error"

if [ ! -d "$DIRECTORY" ]; then
    echo "Directory does not exist."
    exit 1
fi

grep -l "$SEARCH_TERM" "$DIRECTORY"/*.log