# forgejo

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

OCI container for `forgejo`.

## Dependencies

### Build

#### Resources

|Name                                           |Version      |Type  |
|:---                                           |:---         |:---  |
|[Debian](https://docker.io/debian)             |`stable-slim`|Image |
|[forgejo](https://codeberg.org/forgejo/forgejo)|`16.0.4`     |Binary|

### Runtime

#### Ports

|Port  |Protocol|Service|Description|
|:---  |:---    |:---   |:---       |
|`3000`|`tcp`   |HTTP   |Web, API   |

#### Volumes

|Mount Path               |Type                          |Mode|Size|Description        |
|:---                     |:---                          |:---|:---|:---               |
|`/var/local/forgejo/work`|`configMap`, `hostPath`, `pvc`|`rw`|`-` |Working path       |
|`/var/local/forgejo/ssh` |`configMap`, `hostPath`, `pvc`|`rw`|`-` |SSH authorized_keys|

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

`CONFIG`

    Description: --config
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/forgejo/work/custom/conf/app.ini"
    Options    :
      Examples: "/mnt/work/custom/conf/app.ini"
      None    : ""

`CUSTOM_PATH`

    Description: --custom-path
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/forgejo/work/custom"
    Options    :
      Examples: "/mnt/work/custom"
      None    : ""

`INSTALL_PORT`

    Description: --install-port
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "3000"
    Options    :
      Examples: "6000"
      None    : ""

`PID`

    Description: --pid
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "" | ""
      None    : ""

`PORT`

    Description: --port
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "3000"
    Options    :
      Examples: "6000"
      None    : ""

`WORK_PATH`

    Description: --work-path
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/forgejo/work"
    Options    :
      Examples: "/mnt/work"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [Forgejo](https://forgejo.org)
- [Forgejo Documentation](https://forgejo.org/docs)
- [Forgejo Releases](https://codeberg.org/forgejo/forgejo/releases)
- [SQLite](https://sqlite.org)
