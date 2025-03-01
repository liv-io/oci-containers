# blockbook

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

This OCI container contains `blockbook`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [go](https://go.dev/dl/go1.23.2.linux-amd64.tar.gz) `1.23.2`

#### Git

- [blockbook](https://github.com/trezor/blockbook.git) `master`
- [rocksdb](https://github.com/facebook/rocksdb.git) `main`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "blockbook:20000:65534" | sudo tee --append /etc/subgid
    echo "blockbook:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'blockbook' --create-home --password '!' --shell '/bin/bash' blockbook
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger blockbook
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal blockbook
    ```

### Storage

- Create the directories for the persistent data:

    ```
    sudo mkdir -p /opt/blockbook/{config,db}
    sudo chown blockbook:blockbook /opt/blockbook
    sudo chmod 0750 /opt/blockbook
    sudo chown -R 29999:29999 /opt/blockbook/{config,db}
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - blockbook
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `blockbook` container directory:

    ```
    cd ./oci-containers/blockbook/
    ```

- Build the `blockbook` container:

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
    podman run --detach --name blockbook --network=host \
        --env COIN_LABEL="Bitcoin" \
        --env COIN_NAME="Bitcoin" \
        --env COIN_SHORTCUT="BTC" \
        --env MESSAGE_QUEUE_BINDING="tcp://1.2.3.4:5555" \
        --env PORT="8080" \
        --env RPC_PASS="3cF83a6puhQ4HqJr8f0re28dKPB8HQw5" \
        --env RPC_URL="http://1.2.3.4:8332" \
        --env RPC_USER="satoshi" \
        --volume /opt/blockbook/config:/var/local/blockbook/config \
        --volume /opt/blockbook/db:/var/local/blockbook/db \
        blockbook:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow blockbook
    ```

- Start, stop, remove a container:

    ```
    podman container start blockbook
    podman container stop blockbook
    podman container rm blockbook
    ```

- Inspect a running container:

    ```
    podman inspect blockbook
    ```

- Debug a running container:

    ```
    podman exec --user root -ti blockbook /bin/bash
    podman exec --user blockbook -ti blockbook /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/blockbook:latest /bin/bash
    ```

## Parameters

`BLOCK_ADDRESSES_TO_KEEP`

    Description: .block_addresses_to_keep
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 300
    Options    :
      Examples: 600 | 900
      None    : ""

`COIN_LABEL`

    Description: .coin_label
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "Bitcoin"
    Options    :
      Examples: "Bitcoin"

`COIN_NAME`

    Description: .coin_name
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "Bitcoin"
    Options    :
      Examples: "Bitcoin"

`COIN_SHORTCUT`

    Description: .coin_shortcut
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "BTC"
    Options    :
      Examples: "BTC"

`MESSAGE_QUEUE_BINDING`

    Description: .rpc_url
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "tcp://1.2.3.4:5555" | "tcp://5.6.7.8:5555"

`PARSE`

    Description: .parse
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`PORT`

    Description: -public
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 8080
    Options    :
      Examples: 8090 | 8100
      None    : ""

`RPC_PASS`

    Description: .rpc_pass
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "q-HrBk83.5w9wuhFt,nP" | "J4eQwP_vkMnB8A!s9pRp"

`RPC_TIMEOUT`

    Description: .rpc_timeout
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : 25
    Options    :
      Examples: 50 | 100
      None    : ""

`RPC_URL`

    Description: .rpc_url
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "http://1.2.3.4:8332" | "http://5.6.7.8:8332"

`RPC_USER`

    Description: .rpc_user
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "satoshi" | "hal" | "len" | "nick" | "adam" | "david"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [blockbook](https://github.com/btcsuite/blockbook)
