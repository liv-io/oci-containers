# btcd

## Index

- [About](#about)
  - [Support](#support)
  - [Dependencies](#dependencies)
    - [Archives](#archives)
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

This OCI container contains `btcd`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [btcd](https://github.com/btcsuite/btcd/releases/download/v0.24.0/btcd-linux-amd64-v0.24.0.tar.gz) `0.24.0`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "btcd:20000:65534" | sudo tee --append /etc/subgid
    echo "btcd:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'btcd' --create-home --password '!' --shell '/bin/bash' btcd
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger btcd
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal btcd
    ```

### Storage

- Create the directories for the persistant data:

    ```
    sudo mkdir -p /opt/btcd/db
    sudo chown btcd:btcd /opt/btcd
    sudo chmod 0750 /opt/btcd
    sudo chown -R 29999:29999 /opt/btcd/db
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - btcd
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `btcd` container directory:

    ```
    cd ./oci-containers/btcd/
    ```

- Build the `btcd` container:

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
    podman run --detach --name btcd --network=host \
        --env ADDPEER="btc.example.com:8333 btc.example.org:8333" \
        --env EXTERNALIP="1.2.3.4" \
        --env LISTEN="0.0.0.0:8333" \
        --env RPCLISTEN="0.0.0.0:8334" \
        --env RPCPASS="3cF83a6puhQ4HqJr8f0re28dKPB8HQw5" \
        --env RPCUSER="satoshi" \
        --volume /opt/btcd/db:/var/local/btcd/db \
        btcd:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow btcd
    ```

- Start, stop, remove a container:

    ```
    podman container start btcd
    podman container stop btcd
    podman container rm btcd
    ```

- Inspect a running container:

    ```
    podman inspect btcd
    ```

- Debug a running container:

    ```
    podman exec --user root -ti btcd /bin/bash
    podman exec --user btcd -ti btcd /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/btcd:latest /bin/bash
    ```

## Parameters

`ADDPEER`

    Description: --addpeer
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "10.1.1.10:8333" | "btc.example.com:8333 btc.example.org:8333"
      None    : ""

`DATADIR`

    Description: --datadir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/btcd/db"
    Options    :
      Examples: "/mnt/db"

`DEBUGLEVEL`

    Description: --debuglevel
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "info"
    Options    :
      Examples: "trace" | "debug" | "info" | "warn" | "error" | "critical"

`EXTERNALIP`

    Description: --externalip
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "1.2.3.4 5.6.7.8"
      None    : ""

`LISTEN`

    Description: --listen
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : "0.0.0.0:8333"
    Options    :
      Examples: "127.0.0.1:8333" | "1.2.3.4:8333 5.6.7.8:8333"

`RPCLISTEN`

    Description: --rpclisten
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : "127.0.0.1:8334"
    Options    :
      Examples: "0.0.0.0:8334" | "1.2.3.4:8334 5.6.7.8:8334"
      None    : ""

`RPCPASS`

    Description: --rpcpass
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "q-HrBk83.5w9wuhFt,nP" | "J4eQwP_vkMnB8A!s9pRp"
      None    : ""

`RPCUSER`

    Description: --rpcuser
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "satoshi" | "hal" | "len" | "nick" | "adam" | "david"
      None    : ""

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [btcd](https://github.com/btcsuite/btcd)
