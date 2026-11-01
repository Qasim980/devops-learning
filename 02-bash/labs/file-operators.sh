#!/bin/bash

process_files() {
   local file_path=("$1")

   cat "$file_path" | while IFS= read -r line; do
      echo "Processing line: $line"
    done
}

process_files "./log.txt"