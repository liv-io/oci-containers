# kaspa-explorer

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

This OCI container contains the `kaspa-explorer`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Git

- [kaspa-explorer](https://github.com/lAmeR1/kaspa-explorer.git) `main`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "kaspa-explorer:20000:65534" | sudo tee --append /etc/subgid
    echo "kaspa-explorer:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'kaspa-explorer' --create-home --password '!' --shell '/bin/bash' kaspa-explorer
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger kaspa-explorer
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal kaspa-explorer
    ```

### Storage

- Create the directories for the persistent data:

    ```
    sudo mkdir -p /opt/kaspa-explorer/{cache,tmp}
    sudo chown kaspa-explorer:kaspa-explorer /opt/kaspa-explorer
    sudo chmod 0750 /opt/kaspa-explorer
    sudo chown -R 29999:29999 /opt/kaspa-explorer/{cache,tmp}
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - kaspa-explorer
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `kaspa-explorer` container directory:

    ```
    cd ./oci-containers/kaspa-explorer/
    ```

- Build the `kaspa-explorer` container:

    ```
    podman build --ulimit=nofile=8192:8192 --tag $(basename ${PWD}):$(cat ./VERSION) .
    ```

- Build the `kaspa-explorer` container with a custom domain name:

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
    podman run --detach --name kaspa-explorer --network=host \
        --volume /opt/kaspa-explorer/cache:/usr/local/share/kaspa-explorer/node_modules/.cache \
        --volume /opt/kaspa-explorer/tmp:/tmp \
        kaspa-explorer:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow kaspa-explorer
    ```

- Start, stop, remove a container:

    ```
    podman container start kaspa-explorer
    podman container stop kaspa-explorer
    podman container rm kaspa-explorer
    ```

- Inspect a running container:

    ```
    podman inspect kaspa-explorer
    ```

- Debug a running container:

    ```
    podman exec --user root -ti kaspa-explorer /bin/bash
    podman exec --user kaspa-explorer -ti kaspa-explorer /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/kaspa-explorer:latest /bin/bash
    ```

## Parameters

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [Kaspa Explorer](https://explorer.kaspa.org)
- [GitHub kaspa-explorer](https://github.com/lAmeR1/kaspa-explorer)
