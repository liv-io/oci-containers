# woodpecker-server

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

This OCI container contains the `woodpecker-server`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [woodpecker-server](https://github.com/woodpecker-ci/woodpecker/releases/download/v2.1.1/woodpecker-server_linux_amd64.tar.gz) `2.1.1`

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
    sudo mkdir -p /opt/woodpecker-server/db
    sudo chown woodpecker:woodpecker /opt/woodpecker-server
    sudo chmod 0750 /opt/woodpecker-server
    sudo chown -R 29999:29999 /opt/woodpecker-server/db
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

- Change to the `woodpecker-server` container directory:

    ```
    cd ./oci-containers/woodpecker-server/
    ```

- Build the `woodpecker-server` container:

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
    podman run --detach --name woodpecker-server --network=host \
        --env WOODPECKER_AGENT_SECRET="Gt4B9bC-6gGM-pERLdD5" \
        --env WOODPECKER_GITHUB="true" \
        --env WOODPECKER_GITHUB_CLIENT="e21f97e5071061bf381d" \
        --env WOODPECKER_GITHUB_SECRET="6776f63f08408073838172059f412df2b4b95a5a" \
        --env WOODPECKER_GITHUB_URL="https://github.com" \
        --env WOODPECKER_GRPC_SECRET="aH62whm-mTHCq8c-439e" \
        --env WOODPECKER_HOST="https://ci.example.com" \
        --env WOODPECKER_OPEN="true" \
        --volume /opt/woodpecker-server/db:/var/local/woodpecker-server/db \
        woodpecker-server:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow woodpecker-server
    ```

- Start, stop, remove a container:

    ```
    podman container start woodpecker-server
    podman container stop woodpecker-server
    podman container rm woodpecker-server
    ```

- Inspect a running container:

    ```
    podman inspect woodpecker-server
    ```

- Debug a running container:

    ```
    podman exec --user root -ti woodpecker-server /bin/bash
    podman exec --user woodpecker -ti woodpecker-server /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/woodpecker-server:latest /bin/bash
    ```

- Get woodpecker-server health:

    ```
    curl --silent --request GET --location http://localhost:8000/healthz
    ```

- Get woodpecker-server metrics:

    ```
    curl --silent --request GET --location http://localhost:9001/metrics
    ```

## Parameters

`WOODPECKER_ADMIN`

    Description: --admin | WOODPECKER_ADMIN
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "administrator" | "admin01 admin02"
      None    : ""

`WOODPECKER_AGENT_SECRET`

    Description: --agent-secret | WOODPECKER_AGENT_SECRET
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "Ch4N.wtbm2,4G6MDt-XE" | "bdF-q5vwq,aeW3VmC.Sv"
      None    : ""

`WOODPECKER_BACKEND_HTTPS_PROXY`

    Description: --backend-https-proxy | WOODPECKER_BACKEND_HTTPS_PROXY
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "http://proxy.example.com:3128"
      None    : ""

`WOODPECKER_BACKEND_HTTP_PROXY`

    Description: --backend-http-proxy | WOODPECKER_BACKEND_HTTP_PROXY
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "http://proxy.example.com:3128"
      None    : ""

`WOODPECKER_BACKEND_NO_PROXY`

    Description: --backend-no-proxy | WOODPECKER_BACKEND_NO_PROXY
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "localhost 127.0.0.1 ::1" | "example.org example.com"
      None    : ""

`WOODPECKER_ENVIRONMENT`

    Description: --environment | WOODPECKER_ENVIRONMENT
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "first_var:value1,second_var:value2"
      None    : ""

`WOODPECKER_GITHUB`

    Description: --github | WOODPECKER_GITHUB
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`WOODPECKER_GITHUB_CLIENT`

    Description: --github-client | WOODPECKER_GITHUB_CLIENT
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: "255b8a99e0bc8c02348f" | "f8b4fe1cfe6fa4bff43d"

`WOODPECKER_GITHUB_SECRET`

    Description: --github-secret | WOODPECKER_GITHUB_SECRET
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: "f2186078bf6cffd4432a1d9e2822bb54e1528b2d" | "633fbc1f4124fb22abd15b96dba73b799172b01c"

`WOODPECKER_GITHUB_URL`

    Description: --github-server | WOODPECKER_GITHUB_URL
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : "https://github.com"
    Options    :
      Examples: "https://github.com" | "https://github.co"

`WOODPECKER_GRPC_ADDR`

    Description: --grpc-addr | WOODPECKER_GRPC_ADDR
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: ":9000" | "localhost:9000"

`WOODPECKER_GRPC_SECRET`

    Description: --grpc-secret | WOODPECKER_GRPC_SECRET
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "BG_V-4BCPfvG.ps53pCk" | "7cp8Kwfb5g-vCH.vtGt9"
      None    : ""

`WOODPECKER_HOST`

    Description: --server-host | WOODPECKER_HOST
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "https://ci.example.com" | "https://ci.example.org"

`WOODPECKER_LOG_LEVEL`

    Description: --log-level | WOODPECKER_LOG_LEVEL
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "info"
    Options    :
      Examples: "trace" | "debug" | "info" | "warn" | "error" | "fatal" | "panic" | "disabled"

`WOODPECKER_METRICS_SERVER_ADDR`

    Description: --metrics-server-addr | WOODPECKER_METRICS_SERVER_ADDR
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: ":9001" | "localhost:9001"

`WOODPECKER_OPEN`

    Description: --open | WOODPECKER_OPEN
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`WOODPECKER_ORGS`

    Description: --orgs | WOODPECKER_ORGS
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "organization" | "org01 org02"
      None    : ""

`WOODPECKER_REPO_OWNERS`

    Description: --repo-owners | WOODPECKER_REPO_OWNERS
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "username" | "user01 user02"
      None    : ""

`WOODPECKER_SERVER_ADDR`

    Description: --server-addr | WOODPECKER_SERVER_ADDR
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
    Options    :
      Examples: ":8000" | "localhost:8000"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [Woodpecker CI](https://woodpecker-ci.org)
- [SQLite](https://sqlite.org)
