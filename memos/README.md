# memos

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

OCI container for `memos`.

## Dependencies

### Build

#### Resources

|Name                                             |Version      |Type   |
|:---                                             |:---         |:---   |
|[Debian](https://docker.io/debian)               |`stable-slim`|Image  |
|[Go](https://go.dev/dl)                          |`1.27.3`     |Archive|
|[memos](https://github.com/usememos/memos.git)   |`main`       |Git    |
|[nodejs](https://deb.nodesource.com/node_24.x)   |`24.x`       |Package|

### Runtime

#### Ports

|Port  |Protocol|Service|Description|
|:---  |:---    |:---   |:---       |
|`8081`|`tcp`   |HTTP   |Web        |

#### Volumes

|Mount Path           |Type             |Mode|Size |Description|
|:---                 |:---             |:---|:--- |:---       |
|`/var/local/memos/db`|`hostPath`, `pvc`|`rw`|`-`  |Database   |

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

`DATA`

    Description: --data
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/memos/db"
    Options    :
      Examples: "/var/local/memos/db"

`PORT`

    Description: --port
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 8081
    Options    :
      Examples: 8080

`URL`

    Description: --instance-url
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "https://memos.example.com"
      None    : ""

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [memos](https://github.com/usememos/memos)
