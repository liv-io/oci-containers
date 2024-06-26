# CHANGES

This file lists changes made to the container. It follows semantic versioning
guidelines. The content is sorted in reverse chronological order and formatted
to allow easy grepping by scripts.

The headers are:
- bugs
- changes
- enhancements
- features

## 0.24.2-1 (2024-06-26)

### Bugs

- Update btcd to version 0.24.2

## 0.24.0-10 (2024-01-31)

### Bugs

- Fix arrays, disable shellcheck SC2068

## 0.24.0-9 (2024-01-24)

### Enhancements

- Minor cosmetic script change

## 0.24.0-8 (2024-01-22)

### Enhancements

- Remove parameters `CONFIGFILE`, `DATADIR`, `LOGDIR`

## 0.24.0-7 (2024-01-20)

### Bugs

- Fix parameter `RPCPASS`

## 0.24.0-6 (2024-01-10)

### Enhancements

- Apply `shellcheck` and `shfmt`

## 0.24.0-5 (2024-01-09)

### Bugs

- Stop process with `SIGTERM` instead of `SIGINT`
- Disable broken parameter `CONFIGFILE`
- Disable broken parameter `DATADIR`
- Disable broken parameter `LOGDIR`

### Enhancements

- Allow for `readOnlyRootFilesystem`

## 0.24.0-4 (2024-01-07)

### Enhancements

- Use `--ignore-missing` option in checksum command

## 0.24.0-3 (2024-01-07)

### Enhancements

- Move GPG keys to dedicated folder
- Improve signature and checksum commands
- Make `cmd.sh` executable

## 0.24.0-2 (2024-01-06)

### Enhancements

- Remove unnecessary `WORKDIR` commands

## 0.24.0-1 (2024-01-06)

### Features

- Initial release
