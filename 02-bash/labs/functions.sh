#!/bin/bash

calculate_md5sum() {
    local file_path="$1"
    md5sum "$file_path" | awk '{ print $1 }'
}

calculate_md5sum "./log.txt"