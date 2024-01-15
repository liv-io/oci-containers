# lnd

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

This OCI container contains `lnd`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [lnd](https://github.com/lightningnetwork/lnd/releases/download/v0.17.3-beta/lnd-linux-amd64-v0.17.3-beta.tar.gz) `0.17.3-beta`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "lnd:20000:65534" | sudo tee --append /etc/subgid
    echo "lnd:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'lnd' --create-home --password '!' --shell '/bin/bash' lnd
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger lnd
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal lnd
    ```

### Storage

- Create the directories for the persistant data:

    ```
    sudo mkdir -p /opt/lnd/data
    sudo chown lnd:lnd /opt/lnd
    sudo chmod 0750 /opt/lnd
    sudo chown -R 29999:29999 /opt/lnd/data
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - lnd
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `lnd` container directory:

    ```
    cd ./oci-containers/lnd/
    ```

- Build the `lnd` container:

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
    podman run --detach --name lnd --network=host \
        --env ALIAS="example.com" \
        --env BITCOIND_RPCHOST="1.2.3.4:8332" \
        --env BITCOIND_RPCPASS="3cF83a6puhQ4HqJr8f0re28dKPB8HQw5" \
        --env BITCOIND_RPCUSER="satoshi" \
        --env BITCOIND_ZMQPUBRAWBLOCK="tcp://1.2.3.4:5557" \
        --env BITCOIND_ZMQPUBRAWTX="tcp://1.2.3.4:5558" \
        --env COLOR="#f2a900" \
        --env EXTERNALIP="5.6.7.8" \
        --env LISTEN="0.0.0.0:9735" \
        --volume /opt/lnd/data:/var/local/lnd/data \
        lnd:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow lnd
    ```

- Start, stop, remove a container:

    ```
    podman container start lnd
    podman container stop lnd
    podman container rm lnd
    ```

- Inspect a running container:

    ```
    podman inspect lnd
    ```

- Debug a running container:

    ```
    podman exec --user root -ti lnd /bin/bash
    podman exec --user lnd -ti lnd /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/lnd:latest /bin/bash
    ```

## Parameters

`ALIAS`

    Description: --alias
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "lnd-node" | "lnd-node-alias"
      None    : ""

`BITCOIND_DIR`

    Description: --bitcoind.dir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lnd/bitcoind"
    Options    :
      Examples: "/mnt/bitcoind"

`BITCOIND_ESTIMATEMODE`

    Description: --bitcoind.estimatemode
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "ECONOMICAL"
    Options    : "ECONOMICAL" | "CONSERVATIVE"

`BITCOIND_RPCHOST`

    Description: --bitcoind.rpchost
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "127.0.0.1:8332"
    Options    :
      Examples: "10.10.10.10:8332"

`BITCOIND_RPCPASS`

    Description: --bitcoind.rpcpass
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "q-HrBk83.5w9wuhFt,nP" | "J4eQwP_vkMnB8A!s9pRp"
      None    : ""

`BITCOIND_RPCUSER`

    Description: --bitcoind.rpcuser
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "satoshi" | "hal" | "len" | "nick" | "adam" | "david"
      None    : ""

`BITCOIND_ZMQPUBRAWBLOCK`

    Description: --bitcoind.zmqpubrawblock
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5557"
    Options    :
      Examples: "tcp://10.10.10.10:5557"
      None    : ""

`BITCOIND_ZMQPUBRAWTX`

    Description: --bitcoind.zmqpubrawtx
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5558"
    Options    :
      Examples: "tcp://10.10.10.10:5558"
      None    : ""

`BITCOIN_NETWORK`

    Description: --bitcoin.testnet / --bitcoin.mainnet
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "mainnet"
    Options    : "testnet" | "mainnet"

`BITCOIN_NODE`

    Description: --bitcoin.node
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "bitcoind"
    Options    : "btcd" | "bitcoind"

`BTCD_DIR`

    Description: --btcd.dir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lnd/btcd"
    Options    :
      Examples: "/mnt/btcd"

`COLOR`

    Description: --color
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "#000000"
    Options    :
      Examples: "#f2a900" | "cc9900"

`DATADIR`

    Description: --datadir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lnd/data"
    Options    :
      Examples: "/mnt/data"

`EXTERNALIP`

    Description: --externalip
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`LETSENCRYPTDIR`

    Description: --letsencryptdir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lnd/letsencrypt"
    Options    :
      Examples: "/mnt/letsencrypt"

`LISTEN`

    Description: --listen
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "0.0.0.0:9735"
    Options    :
      Examples: "127.0.0.1:9735" | "1.2.3.4:9735"

`LNDDIR`

    Description: --lnddir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lnd/data"
    Options    :
      Examples: "/mnt/lnd"

`LOGDIR`

    Description: --logdir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lnd/log"
    Options    :
      Examples: "/mnt/log"

`RESTLISTEN`

    Description: --restlisten
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "127.0.0.1:8080" | "0.0.0.0:8080" | "[::1]:8080"
      None    : ""

`RPCLISTEN`

    Description: --rpclisten
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "127.0.0.1:10009" | "0.0.0.0:10009" | "[::1]:10009"
      None    : ""

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [lnd](https://github.com/lightningnetwork/lnd)
