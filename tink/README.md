# tink

## Index

- [About](#about)
  - [Support](#support)
  - [Dependencies](#dependencies)
    - [Archives](#archives)
    - [Git](#git)
    - [Images](#images)
- [Setup](#setup)
  - [Podman](#podman)
  - [User](#user)
  - [Storage](#storage)
  - [Container](#container)
    - [Build](#build)
    - [Run](#run)
    - [Troubleshoot](#troubleshoot)
- [Parameters](#parameters)
- [License](#license)
- [Credits](#credits)
- [Appendix](#appendix)

## About

This OCI container contains `tink`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [go](https://go.dev/dl/go1.26.5.linux-amd64.tar.gz) `1.26.5`

#### Git

- [tink](https://github.com/liv-io/tink.git) `main`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "tink:20000:65534" | sudo tee --append /etc/subgid
    echo "tink:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'tink' --create-home --password '!' --shell '/bin/bash' tink
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger tink
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal tink
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - tink
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `tink` container directory:

    ```
    cd ./oci-containers/tink/
    ```

- Build the `tink` container:

    ```
    podman build --tag $(basename ${PWD}):$(cat ./VERSION) .
    ```

- _Optional:_ Tag and push the image to a registry:

    ```
    podman build --tag registry.example.com/$(basename ${PWD}):$(cat ./VERSION) .
    podman push registry.example.com/$(basename ${PWD}):$(cat ./VERSION)
    ```

#### Run

- Start the container with custom parameters:

    ```
    podman run --detach --name tink --network=host \
        tink:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow tink
    ```

- Start, stop, remove a container:

    ```
    podman container start tink
    podman container stop tink
    podman container rm tink
    ```

- Inspect a running container:

    ```
    podman inspect tink
    ```

- Debug a running container:

    ```
    podman exec --user root -ti tink /bin/bash
    podman exec --user tink -ti tink /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/tink:latest /bin/bash
    ```

## Parameters

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [tink](https://github.com/liv-io/tink)
