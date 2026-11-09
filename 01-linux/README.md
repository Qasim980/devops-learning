# 01 - Linux Fundamentals

Linux is the foundation of DevOps. Most servers, containers and cloud infrastructure run on it, so everything else in this repo builds on what I learn here.

## What I Covered

- **Setup**: running Ubuntu via Killercoda, a local VM (UTM) and an AWS EC2 instance
- **The shell**: Bash vs Zsh and other shells, `man` pages, `cat /etc/shells`, switching default shell
- **File system hierarchy**: what lives in `/bin`, `/etc`, `/var`, `/var/log`, `/tmp`, `/proc` and home directories
- **Working with files and directories**: `ls`, `cd`, `pwd`, `touch`, `cp`, `mv`, `rm`, `mkdir`, `rmdir`, `cat`, `head`, `tail`, `echo`
- **Editing with Vim**: insert mode, searching, deleting lines, undo, save and quit
- **Users and groups**: `useradd`, `passwd`, `usermod -aG`, `su`, `groupadd`, `gpasswd`, `getent`
- **Privileges**: using `sudo` safely
- **File permissions and ownership**: read/write/execute for user, group and others, `chmod` (symbolic and numeric), `chown`, `chgrp`
- **Processes**: `ps aux`, `ps -ef`, `systemctl`, `kill` and signals, `pgrep`/`pkill`
- **Text processing**: `grep`, `awk`, `sed`, `sort`, `uniq`, `wc`, `tr`, and combining them with pipes
- **Standard streams**: stdin, stdout and stderr, redirection and `/dev/null`
- **Environment variables and aliases**: viewing, setting and using them in scripts

## Folder Structure

```
01-linux/
├── notes/       # Notes from lessons, in my own words
├── labs/        # Completed lab exercises
└── projects/    # Hands-on projects
```

## Labs

- **OverTheWire Bandit**: a wargame played over SSH that builds command-line confidence. It covers hidden files, awkward filenames, `find` with size, user and group filters, `grep`, `sort`/`uniq` and `tr`.
- **Fundamentals + Linux assignment**: the end-of-module assignment from the CoderCo curriculum.

## Suggested Projects

- [ ] Create a system info script that displays OS, memory and disk usage
- [ ] Set up a new user with specific permissions
- [ ] Write a log rotation script
- [ ] Write a log analysis script using `grep`, `awk` and `sort`

## Resources

- [OverTheWire Bandit](https://overthewire.org/wargames/bandit/)
- Man pages: `man <command>`