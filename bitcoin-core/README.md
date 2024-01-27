# bitcoin-core

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

This OCI container contains `bitcoin-core`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [bitcoin-core](https://bitcoincore.org/bin/bitcoin-core-25.1/bitcoin-25.1-x86_64-linux-gnu.tar.gz) `25.1`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "bitcoin-core:20000:65534" | sudo tee --append /etc/subgid
    echo "bitcoin-core:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'bitcoin-core' --create-home --password '!' --shell '/bin/bash' bitcoin-core
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger bitcoin-core
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal bitcoin-core
    ```

### Storage

- Create the directories for the persistant data:

    ```
    sudo mkdir -p /opt/bitcoin-core/db
    sudo chown bitcoin-core:bitcoin-core /opt/bitcoin-core
    sudo chmod 0750 /opt/bitcoin-core
    sudo chown -R 29999:29999 /opt/bitcoin-core/db
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - bitcoin-core
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `bitcoin-core` container directory:

    ```
    cd ./oci-containers/bitcoin-core/
    ```

- Build the `bitcoin-core` container:

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
    podman run --detach --name bitcoin-core --network=host \
        --env ADDNODE="btc.example.com:8333 btc.example.org:8333" \
        --env BIND="0.0.0.0" \
        --env EXTERNALIP="1.2.3.4" \
        --env PORT="8333" \
        --env REST="true" \
        --env RPCALLOWIP="0.0.0.0/0" \
        --env RPCAUTH="satoshi:d7316644b50aa7ea8792daf5c6b897e4$54194677335fcb771aa39533ddc2833927de9626b0d8fcb7940a7f56aa8a9569" \
        --env RPCBIND="0.0.0.0" \
        --env RPCPORT="8332" \
        --env ZMQPUBHASHBLOCK="tcp://0.0.0.0:5555" \
        --env ZMQPUBHASHTX="tcp://0.0.0.0:5556" \
        --env ZMQPUBRAWBLOCK="tcp://0.0.0.0:5557" \
        --env ZMQPUBRAWTX="tcp://0.0.0.0:5558" \
        --volume /opt/bitcoin-core/db:/var/local/bitcoin-core/db \
        bitcoin-core:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow bitcoin-core
    ```

- Start, stop, remove a container:

    ```
    podman container start bitcoin-core
    podman container stop bitcoin-core
    podman container rm bitcoin-core
    ```

- Inspect a running container:

    ```
    podman inspect bitcoin-core
    ```

- Debug a running container:

    ```
    podman exec --user root -ti bitcoin-core /bin/bash
    podman exec --user bitcoin-core -ti bitcoin-core /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/bitcoin-core:latest /bin/bash
    ```

## Parameters

`ADDNODE`

    Description: -addnode
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "10.1.1.10:8333" | "btc.example.com:8333 btc.example.org:8333"
      None    : ""

`BIND`

    Description: -bind
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "0.0.0.0"
    Options    :
      Examples: "127.0.0.1" | "1.2.3.4" | "5.6.7.8:8333"

`DATADIR`

    Description: -datadir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/bitcoin-core/db"
    Options    :
      Examples: "/mnt/db"

`DBCACHE`

    Description: -dbcache
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "2048"
    Options    :
      Examples: "4096"

`EXTERNALIP`

    Description: -externalip
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`ONLYNET`

    Description: -onlynet
    Required   : False
    Value      : Predetermined
    Type       : Array
    Default    : "ipv4"
    Options    :
      Examples: "ipv4 ipv6" | "onion" | "i2p" | "cjdns"

`PORT`

    Description: -port
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "8333"
    Options    :
      Examples: "8333" | "18333"

`REST`

    Description: -rest
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`RPCALLOWIP`

    Description: -rpcallowip
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : "127.0.0.0/8"
    Options    :
      Examples: "127.0.0.0/8" | "0.0.0.0/0"
      None    : ""

`RPCAUTH`

    Description: -rpcauth
                 https://github.com/bitcoin/bitcoin/tree/master/share/rpcauth
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "satoshi:d7316644b50aa7ea8792daf5c6b897e4$54194677335fcb771aa39533ddc2833927de9626b0d8fcb7940a7f56aa8a9569" |
                "satoshi:63c20cd63c1eed39bfd8ecc04cf8d816$83340b182b07b1b2d55352797eab617b821f83c4f1c28bd3dfc40240e412ec7a"
      None    : ""

`RPCBIND`

    Description: -rpcbind
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : "127.0.0.1"
    Options    :
      Examples: "0.0.0.0" | "1.2.3.4 5.6.7.8:8332"

`RPCPORT`

    Description: -rpcport
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "8332"
    Options    :
      Examples: "8332" | "18332"

`ZMQPUBHASHBLOCK`

    Description: -zmqpubhashblock
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5555"
    Options    :
      Examples: "tcp://0.0.0.0:5555"
      None    : ""

`ZMQPUBHASHTX`

    Description: -zmqpubhashtx
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5556"
    Options    :
      Examples: "tcp://0.0.0.0:5556"
      None    : ""

`ZMQPUBRAWBLOCK`

    Description: -zmqpubrawblock
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5557"
    Options    :
      Examples: "tcp://0.0.0.0:5557"
      None    : ""

`ZMQPUBRAWTX`

    Description: -zmqpubrawtx
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5558"
    Options    :
      Examples: "tcp://0.0.0.0:5558"
      None    : ""

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [bitcoin-core](https://github.com/btcsuite/bitcoin-core)
