# kasvault

## Index

- [About](#about)
  - [Support](#support)
  - [Dependencies](#dependencies)
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

This OCI container contains the `kasvault`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Git

- [kasvault](https://github.com/coderofstuff/kasvault.git) `main`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "kasvault:20000:65534" | sudo tee --append /etc/subgid
    echo "kasvault:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'kasvault' --create-home --password '!' --shell '/bin/bash' kasvault
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger kasvault
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal kasvault
    ```

### Storage

- Create the directories for the persistent data:

    ```
    sudo mkdir -p /opt/kasvault/{cache,tmp}
    sudo chown kasvault:kasvault /opt/kasvault
    sudo chmod 0750 /opt/kasvault
    sudo chown -R 29999:29999 /opt/kasvault/{cache,tmp}
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - kasvault
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `kasvault` container directory:

    ```
    cd ./oci-containers/kasvault/
    ```

- Build the `kasvault` container:

    ```
    podman build --ulimit=nofile=8192:8192 --tag $(basename ${PWD}):$(cat ./VERSION) .
    ```

- _Optional:_ Tag and push the image to a registry:

    ```
    podman build --ulimit=nofile=8192:8192 --tag registry.example.com/$(basename ${PWD}):$(cat ./VERSION) .
    podman push registry.example.com/$(basename ${PWD}):$(cat ./VERSION)
    ```

#### Run

- Start the container with custom parameters:

    ```
    podman run --detach --name kasvault --network=host \
        --volume /opt/kasvault/cache:/usr/local/src/kasvault/node_modules/.cache \
        --volume /opt/kasvault/tmp:/tmp \
        kasvault:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow kasvault
    ```

- Start, stop, remove a container:

    ```
    podman container start kasvault
    podman container stop kasvault
    podman container rm kasvault
    ```

- Inspect a running container:

    ```
    podman inspect kasvault
    ```

- Debug a running container:

    ```
    podman exec --user root -ti kasvault /bin/bash
    podman exec --user kasvault -ti kasvault /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/kasvault:latest /bin/bash
    ```

## Parameters

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [KasVault](https://kasvault.io)
- [Kaspa Wiki](https://wiki.kaspa.org/en/kasvault-basic-guide)
- [GitHub kasvault](https://github.com/coderofstuff/kasvault)
