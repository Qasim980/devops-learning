# 02 - Bash Scripting

Automate everything. Bash scripting turns repetitive tasks into one-command solutions.

## What I Covered

- **First scripts**: the shebang line (`#!/bin/bash`), comments, making scripts executable with `chmod +x`, and running them from anywhere by adding them to `PATH`
- **Variables and parameters**: strings, numbers and arrays, interpolation, positional parameters (`$1`, `$2`, `$@`), and arithmetic expansion with `$(( ))`
- **Conditionals**: `if`, `elif`, `else` and nested `if` statements, comparison operators (`-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`), and logical operators (`&&`, `||`)
- **Loops and flow control**: `while` and `for` loops, plus `break` and `continue`
- **Functions**: defining and calling functions, function parameters, and special parameters (`$#`, `$0`, `$@`)
- **Input and validation**: reading user input with `read` and validating bad data
- **Piping and redirection**: chaining commands and storing results in variables
- **Error handling and exit codes**: exit codes (`0` for success, non-zero for failure), `exit 1`, and the `set` options (`-e`, `-u`, `-x`, `-o pipefail`) for safer, easier-to-debug scripts
- **Environment and `PATH`**: standard environment variables and making `PATH` changes permanent
- **Working with files**: reading files line by line with redirection and `while`, and file checksums to verify integrity

## Folder Structure

```
02-bash/
├── notes/       # Notes from lessons, in my own words
├── labs/        # Completed lab exercises
└── projects/    # Hands-on projects
```

## Labs

- **Bash Battle Arena**: the hands-on challenge section of the CoderCo Bash module, putting the scripting concepts above into practice.

## Suggested Projects

- [ ] Build a deployment script
- [ ] Create a health check script for services
- [ ] Automate log cleanup with retention policies
- [ ] Build a CLI menu system
- [ ] Write a file integrity checker using checksums

## Resources

- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [ShellCheck](https://www.shellcheck.net/): lint your scripts