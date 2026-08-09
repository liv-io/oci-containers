# rest-server

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

This OCI container contains `rest-server`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [go](https://go.dev/dl/go1.26.5.linux-amd64.tar.gz) `1.26.5`

#### Git

- [rest-server](https://github.com/restic/rest-server.git) `main`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "rest-server:20000:65534" | sudo tee --append /etc/subgid
    echo "rest-server:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'rest-server' --create-home --password '!' --shell '/bin/bash' rest-server
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger rest-server
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal rest-server
    ```

### Storage

- Create the directories for the persistent data:

    ```
    sudo mkdir -p /opt/rest-server/{config,data}
    sudo chown rest-server:rest-server /opt/rest-server
    sudo chmod 0750 /opt/rest-server
    sudo chown -R 29999:29999 /opt/rest-server/{config,data}
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - rest-server
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `rest-server` container directory:

    ```
    cd ./oci-containers/rest-server/
    ```

- Build the `rest-server` container:

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
    podman run --detach --name rest-server --network=host \
        --env LISTEN=":8000" \
        --volume /opt/rest-server/config:/var/local/rest-server/config \
        --volume /opt/rest-server/data:/var/local/rest-server/data \
        rest-server:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow rest-server
    ```

- Start, stop, remove a container:

    ```
    podman container start rest-server
    podman container stop rest-server
    podman container rm rest-server
    ```

- Inspect a running container:

    ```
    podman inspect rest-server
    ```

- Debug a running container:

    ```
    podman exec --user root -ti rest-server /bin/bash
    podman exec --user rest-server -ti rest-server /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/rest-server:latest /bin/bash
    ```

## Parameters

`APPEND_ONLY`

    Description: --append-only
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`AUTH`

    Description: htpasswd credentials (whitespace-separated dictionary)
    Required   : False
    Value      : Arbitrary
    Type       : Dictionary
    Default    : ""
    Options    :
      Examples: "host1:724Wrc,uLnEJnT.CFue4 host2:qc!C4xeI81zyUg+UUkCM host3:wk=EcX20clB,M.RXF4sV"
      None    : ""

`BCRYPT_WORK_FACTOR`

    Description: htpasswd bcrypt algorithm work factor (4-17)
    Required   : False
    Value      : Predetermined
    Type       : Integer
    Default    : 13
    Options    :
      Examples: 5 | 10 | 17

`DATA`

    Description: --path
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/rest-server/data"
    Options    :
      Examples: "/var/local/rest-server/db"

`LISTEN`

    Description: --listen
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ":8000"
    Options    :
      Examples: ":8080"

`PASSWORD_FILE`

    Description: --htpasswd-file
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/rest-server/config/htpasswd"
    Options    :
      Examples: "/var/local/rest-server/config/credentials"

`PRIVATE_REPOS`

    Description: --private-repos
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`PROMETHEUS`

    Description: --prometheus
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [rest-server](https://github.com/restic/rest-server)
