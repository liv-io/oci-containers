# woodpecker-agent

## Index

- [About](#about)
- [Dependencies](#dependencies)
  - [Build](#build)
    - [Resources](#resources)
  - [Runtime](#runtime)
    - [Ports](#ports)
    - [Volumes](#volumes)
    - [WorkingDir](#workingdir)
    - [Environment Variables](#environment-variables)
- [License](#license)
- [Credits](#credits)
- [Appendix](#appendix)

## About

OCI container for `woodpecker-agent`.

## Dependencies

### Build

#### Resources

|Name                                                           |Type   |Version      |
|:---                                                           |:---   |:---         |
|[Debian](https://docker.io/debian)                             |Image  |`stable-slim`|
|[plugin-git](https://github.com/woodpecker-ci/plugin-git)      |Binary |`3.18.0`     |
|[woodpecker-agent](https://github.com/woodpecker-ci/woodpecker)|Archive|`2.10.0`     |

### Runtime

#### Ports

|Port  |Protocol|Service|Description|
|:---  |:---    |:---   |:---       |
|`3000`|`tcp`   |HTTP   |API        |

#### Volumes

|Mount Path                          |Type      |Mode|Size   |Description                                           |
|:---                                |:---      |:---|:---   |:---                                                  |
|`/var/local/woodpecker-agent/certs` |`volume`  |`rw`|`-`    |Volume containing CA certificates for "docker" backend|
|`/var/local/woodpecker-agent/config`|`emptyDir`|`rw`|`4Mi`  |Configuration files                                   |
|`/var/local/woodpecker-agent/tmp`   |`emptyDir`|`rw`|`128Mi`|Temporary files                                       |
|`/run/podman/podman.sock`           |`bind`    |`rw`|`-`    |Podman socket for "docker" backend                    |

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

`WOODPECKER_AGENT_CONFIG_FILE`

    Description:
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/woodpecker-agent/config/agent.conf"
    Options    :
      Examples: ""

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

`WOODPECKER_BACKEND_K8S_NAMESPACE`

    Description:
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "woodpecker-runtime"
    Options    :
      Examples: "" | ""

`WOODPECKER_BACKEND_K8S_NAMESPACE_PER_ORGANIZATION`

    Description:
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`WOODPECKER_BACKEND_K8S_PERMISSION_INIT_IMAGE`

    Description:
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "busybox:stable-musl"
    Options    :
      Examples: "busybox:stable-musl"

`WOODPECKER_BACKEND_K8S_POD_LABELS`

    Description:
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "{\"app.kubernetes.io/managed-by\": \"woodpecker\"}"
    Options    :
      Examples: "{\"app.kubernetes.io/managed-by\": \"woodpecker\"}"

`WOODPECKER_BACKEND_K8S_PULL_SECRET_NAMES`

    Description:
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: ""
      None    : ""

`WOODPECKER_BACKEND_K8S_STORAGE_CLASS`

    Description:
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "local-path"
    Options    :
      Examples: ""

`WOODPECKER_BACKEND_K8S_STORAGE_RWX`

    Description:
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`WOODPECKER_BACKEND_K8S_VOLUME_SIZE`

    Description:
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "10G"
    Options    :
      Examples: ""

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
