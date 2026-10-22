# rest-server

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

OCI container for `rest-server`.

## Dependencies

### Build

#### Resources

|Name                                                    |Version      |Type   |
|:---                                                    |:---         |:---   |
|[Debian](https://docker.io/debian)                      |`stable-slim`|Image  |
|[Go](https://go.dev/dl)                                 |`1.27.3`     |Archive|
|[rest-server](https://github.com/restic/rest-server.git)|`main`       |Git    |

### Runtime

#### Ports

|Port  |Protocol|Service|Description|
|:---  |:---    |:---   |:---       |
|`8000`|`tcp`   |HTTP   |API        |

#### Volumes

|Mount Path                     |Type             |Mode|Size |Description        |
|:---                           |:---             |:---|:--- |:---               |
|`/var/local/rest-server/config`|`emptyDir`       |`rw`|`4Mi`|Configuration files|
|`/var/local/rest-server/data`  |`hostPath`, `pvc`|`rw`|`-`  |Data               |

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

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
