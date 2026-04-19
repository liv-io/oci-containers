# memos

## Index

- [About](#about)
  - [Support](#support)
  - [Dependencies](#dependencies)
    - [Archives](#archives)
    - [Git](#git)
    - [Images](#images)
    - [Package](#package)
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

This OCI container contains `memos`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [go](https://go.dev/dl/go1.26.2.linux-amd64.tar.gz) `1.26.2`

#### Git

- [memos](https://github.com/usememos/memos.git) `main`

#### Images

- [Debian](docker.io/debian) `stable-slim`

#### Package

- [nodejs](https://deb.nodesource.com/node_24.x) `nodejs`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "memos:20000:65534" | sudo tee --append /etc/subgid
    echo "memos:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'memos' --create-home --password '!' --shell '/bin/bash' memos
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger memos
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal memos
    ```

### Storage

- Create the directories for the persistent data:

    ```
    sudo mkdir -p /opt/memos/db
    sudo chown memos:memos /opt/memos
    sudo chmod 0750 /opt/memos
    sudo chown -R 29999:29999 /opt/memos/db
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - memos
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `memos` container directory:

    ```
    cd ./oci-containers/memos/
    ```

- Build the `memos` container:

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
    podman run --detach --name memos --network=host \
        --env PORT="8081" \
        --volume /opt/memos/db:/var/local/memos/db \
        memos:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow memos
    ```

- Start, stop, remove a container:

    ```
    podman container start memos
    podman container stop memos
    podman container rm memos
    ```

- Inspect a running container:

    ```
    podman inspect memos
    ```

- Debug a running container:

    ```
    podman exec --user root -ti memos /bin/bash
    podman exec --user memos -ti memos /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/memos:latest /bin/bash
    ```

## Parameters

`DATA`

    Description: --data
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/memos/db"
    Options    :
      Examples: "/var/local/memos/db"

`PORT`

    Description: --port
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 8081
    Options    :
      Examples: 8080

`URL`

    Description: --instance-url
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "https://memos.example.com"
      None    : ""

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [memos](https://github.com/usememos/memos)
