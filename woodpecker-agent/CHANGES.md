# CHANGES

This file lists changes made to the container. It follows semantic versioning
guidelines. The content is sorted in reverse chronological order and formatted
to allow easy grepping by scripts.

The headers are:
- bugs
- changes
- enhancements
- features

## 3.6.0-1 (2025-05-10)

### Features

- Update woodpecker-agent to version 3.6.0

## 3.5.2-1 (2025-04-16)

### Bugs

- Update woodpecker-agent to version 3.5.2

## 3.5.1-1 (2025-04-04)

### Features

- Update woodpecker-agent to version 3.5.1

## 3.4.0-2 (2025-03-27)

### Bugs

- Update plugin-git to version 2.6.3

## 3.4.0-1 (2025-03-18)

### Features

- Update woodpecker-agent to version 3.4.0

## 3.3.0-1 (2025-03-04)

### Features

- Update woodpecker-agent to version 3.3.0

## 3.2.0-1 (2025-02-27)

### Enhancements

- Update plugin-git to version 2.6.2

### Features

- Update woodpecker-agent to version 3.2.0

## 3.1.0-2 (2025-02-22)

### Enhancements

- Update plugin-git to version 2.6.1

## 3.1.0-1 (2025-02-13)

### Features

- Update woodpecker-agent to version 3.1.0

## 3.0.1-2 (2025-01-20)

### Enhancements

- Print file name and common name while importing self-signed CA certificates
- Minor script improvements

## 3.0.1-1 (2025-01-20)

### Bugs

- Update woodpecker-agent to version 3.0.1

## 3.0.0-1 (2025-01-19)

### Features

- Update woodpecker-agent to version 3.0.0
- Add mechanism to import self-signed CA certificates

## 2.8.3-2 (2025-01-15)

### Bugs

- Run woodpecker-agent as `root` to build container images inside of containerized woodpecker-agent

## 2.8.3-1 (2025-01-12)

### Bugs

- Update woodpecker-agent to version 2.8.3

## 2.8.2-1 (2025-01-11)

### Features

- Update woodpecker-agent to version 2.8.2

## 2.7.1-2 (2024-09-20)

### Enhancements

- Add equal sign to all long options

### Features

- Update plugin-git to version 2.6.0

## 2.7.1-1 (2024-09-16)

### Bugs

- Update woodpecker-agent to version 2.7.1

## 2.7.0-2 (2024-07-26)

### Enhancements

- Update plugin-git to version 2.5.2

## 2.7.0-1 (2024-07-22)

### Features

- Update woodpecker-agent to version 2.7.0

## 2.6.0-3 (2024-07-14)

### Enhancements

- Update plugin-git to version 2.5.1

## 2.6.0-2 (2024-07-05)

### Enhancements

- Remove hard-coded environment variable `DOCKER_HOST`
- Sort option `--grpc-secure` alphabetically
- Add equal sign to boolean options

## 2.6.0-1 (2024-06-14)

### Features

- Update woodpecker-agent to version 2.6.0

## 2.5.0-1 (2024-06-02)

### Features

- Update woodpecker-agent to version 2.5.0

## 2.4.1-1 (2024-03-23)

### Features

- Update woodpecker-agent to version 2.4.1

## 2.3.0-1 (2024-01-31)

### Features

- Update woodpecker-agent to version 2.3.0

## 2.2.2-3 (2024-01-28)

### Enhancements

- Update plugin-git to version 2.5.0

## 2.2.2-2 (2024-01-24)

### Enhancements

- Minor cosmetic script change

## 2.2.2-1 (2024-01-22)

### Features

- Update woodpecker-agent to version 2.2.2

## 2.1.1-5 (2024-01-10)

### Bugs

- Fix parameter `WOODPECKER_BACKEND_DOCKER_NETWORK`
- Fix parameter `WOODPECKER_BACKEND_DOCKER_VOLUMES`

### Enhancements

- Apply `shellcheck` and `shfmt`

## 2.1.1-4 (2024-01-07)

### Enhancements

- Use `--ignore-missing` option in checksum command

## 2.1.1-3 (2024-01-07)

### Enhancements

- Improve checksum command
- Make `cmd.sh` executable

## 2.1.1-2 (2024-01-06)

### Enhancements

- Remove `--system` option from `groupadd` and `useradd` commands

## 2.1.1-1 (2024-01-01)

### Features

- Initial release
