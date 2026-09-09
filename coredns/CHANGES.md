# CHANGES

This file lists changes made to the container. It follows semantic versioning
guidelines. The content is sorted in reverse chronological order and formatted
to allow easy grepping by scripts.

The headers are:
- bugs
- changes
- enhancements
- features

## 1.14.7-1 (2026-09-09)

### Bugs

- Update CoreDNS to version 1.14.7

### Enhancements

- Update Go to version 1.27.1

## 1.14.6-4 (2026-08-26)

### Bugs

- Replace `auto` directive to prevent hidden Kubernetes ConfigMap timestamp directories from causing duplicate zone file collisions
- Correct default value for `LOG` parameter

### Changes

- Remove parameter `BIND`

#### Features

- Enable plugin `template`
- Return REFUSED for unhandled queries when forwarding is disabled

## 1.14.6-3 (2026-08-23)

### Features

- Add parameter `FORWARD`

## 1.14.6-2 (2026-08-23)

### Changes

- Remove argument `COREDNS_PLUGINS`

### Bugs

- Ensure custom `plugin.cfg` is applied at compilation

## 1.14.6-1 (2026-08-20)

### Features

- Initial release
