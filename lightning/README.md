# lightning

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

This OCI container contains `lightning`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [bitcoin-core](https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-27.1-x86_64-linux-gnu.tar.gz) `27.1`
- [lightning](https://github.com/ElementsProject/lightning/releases/download/v24.08/clightning-v24.08-Ubuntu-22.04.tar.xz) `24.08`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "lightning:20000:65534" | sudo tee --append /etc/subgid
    echo "lightning:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'lightning' --create-home --password '!' --shell '/bin/bash' lightning
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger lightning
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal lightning
    ```

### Storage

- Create the directories for the persistant data:

    ```
    sudo mkdir -p /opt/lightning/data
    sudo chown lightning:lightning /opt/lightning
    sudo chmod 0750 /opt/lightning
    sudo chown -R 29999:29999 /opt/lightning/data
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - lightning
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `lightning` container directory:

    ```
    cd ./oci-containers/lightning/
    ```

- Build the `lightning` container:

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
    podman run --detach --name lightning --network=host \
        --env ALIAS="example.com" \
        --env ANNOUNCE_ADDR="5.6.7.8" \
        --env ANNOUNCE_ADDR_DISCOVERED_PORT="9735" \
        --env BIND_ADDR="0.0.0.0" \
        --env BITCOIN_RPCCONNECT=""1.2.3.4" \
        --env BITCOIN_RPCPASSWORD="3cF83a6puhQ4HqJr8f0re28dKPB8HQw5" \
        --env BITCOIN_RPCPORT="8332" \
        --env BITCOIN_RPCUSER="satoshi" \
        --env RGB="f2a900" \
        --volume /opt/lightning/data:/var/local/lightning/data \
        lightning:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow lightning
    ```

- Start, stop, remove a container:

    ```
    podman container start lightning
    podman container stop lightning
    podman container rm lightning
    ```

- Inspect a running container:

    ```
    podman inspect lightning
    ```

- Debug a running container:

    ```
    podman exec --user root -ti lightning /bin/bash
    podman exec --user lightning -ti lightning /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/lightning:latest /bin/bash
    ```

## Parameters

`ADDR`

    Description: --addr
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`ALIAS`

    Description: --alias
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "lightning-node" | "lightning-node-alias"
      None    : ""

`ANNOUNCE_ADDR`

    Description: --announce-addr
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`ANNOUNCE_ADDR_DISCOVERED`

    Description:
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "false"
    Options    :
      Examples: "true" | "false" | "auto"

`ANNOUNCE_ADDR_DISCOVERED_PORT`

    Description: --announce-addr-discovered-port
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "9735"
    Options    :
      Examples: "9735" | "8735"

`AUTOLISTEN`

    Description: --autolisten
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`BIND_ADDR`

    Description: --bind-addr
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "0.0.0.0"
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`BITCOIN_CLI`

    Description: --bitcoin-cli
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/usr/local/bin/bitcoin-cli"
    Options    :
      Examples: "/mnt/bin/bitcoin-cli"

`BITCOIN_DATADIR`

    Description: --bitcoin-datadir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lightning/bitcoin-cli"
    Options    :
      Examples: "/mnt/lightning/bitcoin-cli"

`BITCOIN_RPCCONNECT`

    Description: --bitcoin-rpcconnect
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "127.0.0.1"
    Options    :
      Examples: "10.10.10.10"

`BITCOIN_RPCPASSWORD`

    Description: --bitcoin-rpcpassword
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "q-HrBk83.5w9wuhFt,nP" | "J4eQwP_vkMnB8A!s9pRp"
      None    : ""

`BITCOIN_RPCPORT`

    Description: --bitcoin-rpcport
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "8332"
    Options    :
      Examples: "8334"

`BITCOIN_RPCUSER`

    Description: --bitcoin-rpcuser
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "satoshi" | "hal" | "len" | "nick" | "adam" | "david"
      None    : ""

`LIGHTNING_DIR`

    Description: --lightning-dir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lightning/data"
    Options    :
      Examples: "/mnt/data"

`LOG_LEVEL`

    Description: --log-level
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "info"
    Options    :
      Examples: "io" | "debug" | "info" | "unusual" | "broken"

`LOG_TIMESTAMPS`

    Description: --log-timestamps
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`NETWORK`

    Description: --network / --mainnet / --testnet
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "mainnet"
    Options    : "testnet" | "mainnet"

`RGB`

    Description: --rgb
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "000000"
    Options    :
      Examples: "f2a900" | "cc9900"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [lightning](https://github.com/lightningnetwork/lightning)
