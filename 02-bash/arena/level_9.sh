#!/bin/bash

DIRECTORY="Arena"
LOG_FILE="change_log.txt"

# Check if the directory exists

if [ ! -d "$DIRECTORY" ]; then
    echo "Directory does not exist."
    exit 1
fi

# Monitor the directory for changes and log them to a file

fswatch -r "$DIRECTORY" | while read event; do
    if [ -e "$event" ]; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') File modified/created: $event" >> "$LOG_FILE"
    else
        echo "$(date +'%Y-%m-%d %H:%M:%S') File deleted: $event" >> "$LOG_FILE"
    fi
done

: " This script is event-driven and will runindefinitely until manually stopped. 
It uses fswatch to monitor the specified directory for any changes, logging the events to a file with timestamps.
"