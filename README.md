# oci-containers

## Index

- [About](#about)
  - [Features](#features)
  - [Support](#support)
  - [Dependencies](#dependencies)
- [Setup](#setup)
  - [Podman](#podman)
- [License](#license)
- [Credits](#credits)
- [Appendix](#appendix)

## About

`oci-containers` is a collection of well curated OCI containers.

### Features

- Containers follow the secure-by-default principle
- Containers are mostly self-contained and dependencies avoided
- Relevant settings are parameterized
- Parameters are documented with examples
- Containers contain a changelog

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

All containers are built on-top of the latest official Debian Docker image:
- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Podman is a daemonless container engine and drop-in replacement for Docker. It supports rootless mode and has no need for complex masquerading firewall rules on the host.

The following instructions have been tested on Debian 12, but should work on most Debian-based distributions.

- Install the dependencies for a rootless container environment with support for unprivileged user-mode networking and OverlayFS:

    ```
    sudo apt update
    sudo apt install -y --no-install-recommends \
        catatonit \
        dbus-user-session \
        fuse-overlayfs \
        rootlesskit \
        slirp4netns
    ```

- Install the Podman package:

    ```
    sudo apt install -y --no-install-recommends \
        podman
    ```

- Install `git` to clone the Cardano container repository later on:

    ```
    sudo apt install -y --no-install-recommends \
        git
    ```

- Install `curl` to download the Podman storage configuration file:

    ```
    sudo apt install -y --no-install-recommends \
        ca-certificates \
        curl
    ```

- Get the Podman package version to download the correct storage configuration file:

    ```
    dpkg -s podman | grep '^Version:'
    export PODMAN_VERSION="4.3.1"
    ```

- Download and configure the Podman storage settings:

    ```
    curl --proto '=https' --tlsv1.2 --location https://raw.githubusercontent.com/containers/podman/v${PODMAN_VERSION}/vendor/github.com/containers/storage/storage.conf --output ~/storage.conf
    sudo mv ~/storage.conf /etc/containers/storage.conf
    sudo chown root:root /etc/containers/storage.conf
    sudo chmod 0644 /etc/containers/storage.conf
    ```

    Note: The `storage.conf` configuration file is from the official [container repository](https://github.com/containers/podman/tree/main/vendor/github.com/containers/storage).

## License

Distributed under the Simplified BSD License.

See `LICENSE` file for more information.

## Credits

See `CREDITS` file for more information.

## Appendix
