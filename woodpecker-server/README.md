# woodpecker-server

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

OCI container for `woodpecker-server`.

## Dependencies

### Build

#### Resources

|Name                                                            |Type   |Version      |
|:---                                                            |:---   |:---         |
|[Debian](https://docker.io/debian)                              |Image  |`stable-slim`|
|[woodpecker-server](https://github.com/woodpecker-ci/woodpecker)|Archive|`3.18.0`     |

### Runtime

#### Ports

|Port  |Protocol|Service|Description |
|:---  |:---    |:---   |:---        |
|`8000`|`tcp`   |HTTP   |Web, API    |
|`9000`|`tcp`   |GRPC   |RPC         |
|`9001`|`tcp`   |HTTP   |Metrics     |

#### Volumes

|Mount Path                       |Type                          |Mode|Size|Description    |
|:---                             |:---                          |:---|:---|:---           |
|`/var/local/woodpecker-server/db`|`configMap`, `hostPath`, `pvc`|`rw`|`-` |SQLite Database|

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

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
