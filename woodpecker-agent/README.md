# woodpecker-agent

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

This OCI container contains the `woodpecker-agent`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [plugin-git](https://github.com/woodpecker-ci/plugin-git/releases/download/2.4.0/linux-amd64_plugin-git) `2.4.0`
- [woodpecker-agent](https://github.com/woodpecker-ci/woodpecker/releases/download/v2.1.1/woodpecker-agent_linux_arm64.tar.gz) `2.1.1`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "woodpecker:20000:65534" | sudo tee --append /etc/subgid
    echo "woodpecker:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'woodpecker' --create-home --password '!' --shell '/bin/bash' woodpecker
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger woodpecker
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal woodpecker
    ```

### Storage

- Create the directories for the persistant data:

    ```
    sudo mkdir -p /opt/woodpecker-agent/tmp
    sudo chown woodpecker:woodpecker /opt/woodpecker-agent
    sudo chmod 0750 /opt/woodpecker-agent
    sudo chown -R 29999:29999 /opt/woodpecker-agent/tmp
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - woodpecker
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `woodpecker-agent` container directory:

    ```
    cd ./oci-containers/woodpecker-agent/
    ```

- Build the `woodpecker-agent` container:

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
    podman run --detach --name woodpecker-agent --network=host \
        --env WOODPECKER_AGENT_SECRET="Gt4B9bC-6gGM-pERLdD5" \
        --volume /opt/woodpecker-agent/tmp:/var/local/woodpecker-agent/tmp \
        --volume /run/podman/podman.sock:/run/podman/podman.sock \
        woodpecker-agent:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow woodpecker-agent
    ```

- Start, stop, remove a container:

    ```
    podman container start woodpecker-agent
    podman container stop woodpecker-agent
    podman container rm woodpecker-agent
    ```

- Inspect a running container:

    ```
    podman inspect woodpecker-agent
    ```

- Debug a running container:

    ```
    podman exec --user root -ti woodpecker-agent /bin/bash
    podman exec --user woodpecker -ti woodpecker-agent /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/woodpecker-agent:latest /bin/bash
    ```

- Get woodpecker-agent health:

    ```
    curl --silent --request GET --location http://localhost:3000/healthz
    ```

## Parameters

`WOODPECKER_AGENT_SECRET`

    Description: --grpc-token | WOODPECKER_AGENT_SECRET
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "Ch4N.wtbm2,4G6MDt-XE" | "bdF-q5vwq,aeW3VmC.Sv"
      None    : ""

`WOODPECKER_BACKEND`

    Description: --backend-engine | WOODPECKER_BACKEND
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "docker"
    Options    : "docker" | "local"

`WOODPECKER_BACKEND_DOCKER_API_VERSION`

    Description: --backend-docker-api-version | WOODPECKER_BACKEND_DOCKER_API_VERSION
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: "1.43"

`WOODPECKER_BACKEND_DOCKER_CERT_PATH`

    Description: --backend-docker-cert | WOODPECKER_BACKEND_DOCKER_CERT_PATH
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: "/var/local/woodpecker-agent/cert"

`WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6`

    Description: --backend-docker-ipv6 | WOODPECKER_BACKEND_DOCKER_ENABLE_IPV6
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`WOODPECKER_BACKEND_DOCKER_HOST`

    Description: --backend-docker-host | WOODPECKER_BACKEND_DOCKER_HOST
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "unix://run/podman/podman.sock"
    Options    :
      Examples: "unix://run/podman/podman.sock"

`WOODPECKER_BACKEND_DOCKER_NETWORK`

    Description: --backend-docker-network | WOODPECKER_BACKEND_DOCKER_NETWORK
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: "existing-network-name"
      None    : ""

`WOODPECKER_BACKEND_DOCKER_TLS_VERIFY`

    Description: --backend-docker-tls-verify | WOODPECKER_BACKEND_DOCKER_TLS_VERIFY
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`WOODPECKER_BACKEND_DOCKER_VOLUMES`

    Description: --backend-docker-volumes | WOODPECKER_BACKEND_DOCKER_VOLUMES
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: "/etc/ssl/certs:/etc/ssl/certs:ro,/etc/timezone:/etc/timezone:ro"
      None    : ""

`WOODPECKER_BACKEND_LOCAL_TEMP_DIR`

    Description: --backend-local-temp-dir | WOODPECKER_BACKEND_LOCAL_TEMP_DIR
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/woodpecker-agent/tmp"
    Options    :
      Examples: "/var/local/woodpecker-agent/tmp"

`WOODPECKER_GRPC_SECURE`

    Description: --grpc-secure | WOODPECKER_GRPC_SECURE
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`WOODPECKER_GRPC_VERIFY`

    Description: --grpc-skip-insecure | WOODPECKER_GRPC_VERIFY
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`WOODPECKER_HEALTHCHECK`

    Description: --healthcheck | WOODPECKER_HEALTHCHECK
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`WOODPECKER_HEALTHCHECK_ADDR`

    Description: --healthcheck-addr | WOODPECKER_HEALTHCHECK_ADDR
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: ":3000" | "localhost:3000"

`WOODPECKER_HOSTNAME`

    Description: --hostname | WOODPECKER_HOSTNAME
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "woodpecker-agent"
    Options    :
      Examples: "host" | "hostname"

`WOODPECKER_LOG_LEVEL`

    Description: --log-level | WOODPECKER_LOG_LEVEL
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "info"
    Options    :
      Examples: "trace" | "debug" | "info" | "warn" | "error" | "fatal" | "panic" | "disabled"

`WOODPECKER_SERVER`

    Description: --server | WOODPECKER_SERVER
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: "localhost:9000" | "ci.example.com:9000"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [Woodpecker CI](https://woodpecker-ci.org)
- [SQLite](https://sqlite.org)
