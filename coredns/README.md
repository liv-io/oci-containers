# coredns

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

This OCI container contains `coredns`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [go](https://go.dev/dl/go1.26.6.linux-amd64.tar.gz) `1.26.6`

#### Git

- [coredns](https://github.com/coredns/coredns.git) `main`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "coredns:20000:65534" | sudo tee --append /etc/subgid
    echo "coredns:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'coredns' --create-home --password '!' --shell '/bin/bash' coredns
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger coredns
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal coredns
    ```

### Storage

- Create the directories for the persistent data:

    ```
    install --directory --owner=root --group=root --mode=0750 /opt/coredns
    install --directory --owner=29999 --group=29999 --mode=0750 /opt/coredns/config
    install --directory --owner=29999 --group=29999 --mode=0750 /opt/coredns/zones
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - coredns
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `coredns` container directory:

    ```
    cd ./oci-containers/coredns/
    ```

- Build the `coredns` container:

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
    podman run --detach --name coredns --network=host \
        --volume /opt/coredns/config:/var/local/coredns/config \
        --volume /opt/coredns/zones:/var/local/coredns/zones \
        coredns:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow coredns
    ```

- Start, stop, remove a container:

    ```
    podman container start coredns
    podman container stop coredns
    podman container rm coredns
    ```

- Inspect a running container:

    ```
    podman inspect coredns
    ```

- Debug a running container:

    ```
    podman exec --user root -ti coredns /bin/bash
    podman exec --user coredns -ti coredns /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/coredns:latest /bin/bash
    ```

## Parameters

`CACHE`

    Description: cache
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 60
    Options    :
      Examples: 30 | 300

`CONF`

    Description: -conf
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/coredns/config/corefile"
    Options    :
      Examples: "/var/local/coredns/config/corefile"

`FORWARD`

    Description: forward
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "10.1.11.1"
      None    : ""

`HEALTH`

    Description: health
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ":8080"
    Options    :
      Examples: ""

`LOG`

    Description: record queries (log) and errors (comma-separated dictionary)
    Required   : False
    Value      : Arbitrary
    Type       : Dictionary
    Default    : "errors"
    Options    :
      Examples: "log" | "log,errors" | "log, errors"
      None    : ""

`PORT`

    Description: -dns.port
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 1053
    Options    :
      Examples: 8053

`RELOAD`

    Description: reload
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "30s"
    Options    :
      Examples: "10s" | "60s"

`ROOT`

    Description: root
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/coredns/zones"
    Options    :
      Examples: "/data"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [coredns](https://coredns.io)
- [Plugins](https://github.com/coredns/coredns/tree/master/plugin)
