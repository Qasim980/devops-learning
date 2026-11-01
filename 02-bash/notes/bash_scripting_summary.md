# 🐚 Bash Scripting Summary

A Bash script is a text file of commands with a shebang, made executable. Everything else is a handful of building blocks: **variables → decisions → loops → functions → safety**.

---

## 1. Setup

- First line: `#!/bin/bash` (the interpreter). `#!/usr/bin/python3` works the same way for other languages.
- Make it executable and run it:
  ```bash
  chmod +x script.sh
  ./script.sh
  ```
- To run it from anywhere, put it in a directory listed in `echo $PATH`. To make that permanent, add an `export PATH=...` line to `~/.zshrc`.
- Comments use `# ...`. Multi-line comments use `: ' ... '`.

---

## 2. Variables and Parameters

| Thing | Syntax |
|---|---|
| Assign (no spaces around `=`) | `name="Alice"` |
| Use | `$name` or `"${name}"` |
| Array | `fruits=("apple" "banana")`, then `${fruits[0]}`, `${fruits[@]}`, `${#fruits[@]}` |
| Maths | `$((a + b))` |
| Ask the user | `read -p "Prompt: " var` |
| Script args | `$1 $2 $3`, `$@` (all), `$#` (count), `$0` (script name) |
| Environment vars | `$PATH $SHELL $PWD $LOGNAME` |

---

## 3. Decisions

```bash
if [ "$x" -gt 10 ]; then
  echo "big"
elif [ "$x" -eq 0 ]; then
  echo "zero"
else
  echo "other"
fi
```

| Type | Operators |
|---|---|
| Numbers | `-eq -ne -lt -gt -le -ge` |
| Strings | `=  !=  -z` (empty)  `-n` (not empty) |
| Files | `-f` file, `-d` directory, `-e` exists, `-r -w -x` permissions |
| Combine | `&&` (AND), `\|\|` (OR) |

- You can nest `if` statements.
- **`case`** is cleaner than a long `elif` chain for fixed choices. Each branch ends in `;;`, and `*)` is the default:
  ```bash
  case $num in
    1) echo "one" ;;
    2) echo "two" ;;
    *) echo "invalid" ;;
  esac
  ```

---

## 4. Loops

```bash
for i in 1 2 3; do
  echo "Number $i"
done

count=1
while [ $count -le 5 ]; do
  echo "Count: $count"
  ((count++))
done
```

- `for` repeats over a known list.
- `while` repeats while the condition is true. Remember `((count++))` or it never ends.
- `break` exits the loop. `continue` skips to the next iteration.
- To read a file line by line, use a `while read` loop with redirection, or pipe from `cat`.

---

## 5. Functions

```bash
greet() {
  echo "Hello, $1"
}
greet "Alice"
```

Inside a function, `$1 $2` are the function's own arguments. Functions are mini-programs that keep a script DRY.

---

## 6. Pipes and Redirection

`cmd1 | cmd2` feeds one command's output into the next. Chain them to build data-processing pipelines.

---

## 7. Safety: Error Handling and Exit Codes

- Every command returns an exit code. **0 = success, anything else = failure.**
- `$?` holds the last exit code. `exit N` sets your own.
- Validate inputs *before* acting:
  ```bash
  if [ "$num2" -eq 0 ]; then
    echo "Error: division by zero"
    exit 1
  fi
  ```

| Flag | Effect |
|---|---|
| `set -e` | Stop at the first failing command |
| `set -u` | Error on undefined variables |
| `set -x` | Print each command before running it (debugging) |
| `set -o pipefail` | A pipeline fails if *any* part fails |

`set -euo pipefail` is the standard combination for the top of a script. Add `trap` to run cleanup code on exit or error.

---

## 8. Files and Checksums

A checksum (`md5sum file` or `sha256sum file`) gives a file a fingerprint. If two checksums match, the file hasn't changed or been corrupted. It's useful for verifying downloads and backups.

---

## ⚠️ Corrections to Common Note Slips

- **Arrays:** `random=("blue","red","green")` is wrong. Bash arrays are space-separated, with no commas. Also, `echo $random` only prints the first item. Use `"${random[@]}"`.
- **`pipefail`:** it doesn't "not pipe the command". It makes the whole pipeline report failure if any stage fails.
- **While loop:** `-le 5` means "less than *or equal to* 5", not "less than 5".
- **PATH line:** `echo "export PATH=$PATH:~/my_scripts"` expands `$PATH` immediately because of the double quotes. Use single quotes (`'export PATH=$PATH:~/my_scripts'`) to keep it dynamic.
- **Checksum command:** it's `md5sum` (or `sha256sum`), not `calculate_md5sum`.
- **Shebang:** write `#!/bin/bash` with no space. The version with a space usually works, but it's non-standard.

---

## 🧠 Make It Stick

Write one script from memory that uses everything above, for example a small backup script:

1. Start with `#!/bin/bash` and `set -euo pipefail`
2. Take a directory as `$1`, and `exit 1` with a message if it's missing or isn't a directory
3. Loop over the files with `for`, skipping some with `continue`
4. Do the work inside a function
5. Print an `md5sum` of the result
