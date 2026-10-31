#!/bin/bash

print_args() {
    echo "Number of arguments: $#"
    echo "script name: $0"
    echo "First argument: $1"
    echo "Second argument: $2"
    echo "All arguments: $@"

}

print_args "alice" "bob" "charlie"