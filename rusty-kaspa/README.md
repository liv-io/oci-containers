# rusty-kaspa

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

This OCI container contains the `rusty-kaspa`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [rusty-kaspa](https://github.com/kaspanet/rusty-kaspa/releases/download/v0.14.1/rusty-kaspa-v0.14.1-linux-gnu-amd64.zip) `0.14.1`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "rusty-kaspa:20000:65534" | sudo tee --append /etc/subgid
    echo "rusty-kaspa:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'rusty-kaspa' --create-home --password '!' --shell '/bin/bash' rusty-kaspa
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger rusty-kaspa
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal rusty-kaspa
    ```

### Storage

- Create the directories for the persistant data:

    ```
    sudo mkdir -p /opt/rusty-kaspa/data
    sudo chown rusty-kaspa:rusty-kaspa /opt/rusty-kaspa
    sudo chmod 0750 /opt/rusty-kaspa
    sudo chown -R 29999:29999 /opt/rusty-kaspa/data
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - rusty-kaspa
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `rusty-kaspa` container directory:

    ```
    cd ./oci-containers/rusty-kaspa/
    ```

- Build the `rusty-kaspa` container:

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
    podman run --detach --name rusty-kaspa --network=host \
        --volume /opt/rusty-kaspa/data:/var/local/rusty-kaspa/data \
        rusty-kaspa:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow rusty-kaspa
    ```

- Start, stop, remove a container:

    ```
    podman container start rusty-kaspa
    podman container stop rusty-kaspa
    podman container rm rusty-kaspa
    ```

- Inspect a running container:

    ```
    podman inspect rusty-kaspa
    ```

- Debug a running container:

    ```
    podman exec --user root -ti rusty-kaspa /bin/bash
    podman exec --user rusty-kaspa -ti rusty-kaspa /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/rusty-kaspa:latest /bin/bash
    ```

## Parameters

`ADDPEER`

    Description: --addpeer
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "10.1.1.10:16111" | "kas.example.com:16111 kas.example.org:16111"
      None    : ""

`APPDIR`

    Description: --appdir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "-/var/local/rusty-kaspa/data"
    Options    :
      Examples: "/mnt/data"

`DISABLE_UPNP`

    Description: --disable-upnp
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`EXTERNALIP`

    Description: --externalip
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`LISTEN`

    Description: --listen
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "0.0.0.0"
    Options    :
      Examples: "127.0.0.1" | "1.2.3.4" | "5.6.7.8:16111"

`LOGLEVEL`

    Description: --loglevel
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "info"
    Options    :
      Examples: "off" | "error" | "warn" | "info" | "debug" | "trace"

`NODNSSEED`

    Description: --nodnsseed
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`NOGRPC`

    Description: --nogrpc
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`NOLOGFILES`

    Description: --nologfiles
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`RAM_SCALE`

    Description: --ram-scale
    Required   : False
    Value      : Arbitrary
    Type       : Float
    Default    : 0.3
    Options    :
      Examples: 0.3 | 0.4 | 1.0

`SANITY`

    Description: --sanity
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`UTXOINDEX`

    Description: --utxoindex
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [Kaspa](https://kaspa.org)
- [Kaspa Wiki](https://wiki.kaspa.org)
- [Kaspa Releases](https://github.com/kaspanet/rusty-kaspa/releases)
