# coredns

## Index

- [About](#about)
- [Dependencies](#dependencies)
  - [Build](#build)
    - [Resources](#resources)
  - [Runtime](#runtime)
    - [Ports](#ports)
    - [Volumes](#volumes)
    - [Environment Variables](#environment-variables)
- [License](#license)
- [Credits](#credits)
- [Appendix](#appendix)

## About

OCI container for `coredns`.

## Dependencies

### Build

|Name|Type|Version|
|:---|:---|:---|
|[Debian](https://docker.io/debian)|Image|`stable-slim`|
|[Go](https://go.dev/dl)|Archive|`1.27.1`|
|[coredns](https://github.com/coredns/coredns.git)|Git|`main`|

### Runtime

#### Ports

|Port|Protocol|Service|Description|
|:---|:---|:---|:---|
|`8080`|`tcp`|HTTP|Web API|
|`1053`|`tcp`|DNS|DNS over TCP|
|`1053`|`udp`|DNS|DNS over UDP|

#### Volumes

|Mount Path|Type|Mode|Size|Description|
|:---|:---|:---|:---|:---|
|`/var/local/coredns/config`|`emptyDir`|`rw`|`4Mi`|Configuration files|
|`/var/local/coredns/zones`|`configMap`, `hostPath`, `pvc`|`rw`|-|Zone files (prefixed with `db.`)|

#### Environment Variables

`CACHE`

    Description: cache
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 60
    Options    :
      Examples: 30 | 300

`CONF`

    Description: -conf
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/coredns/config/corefile"
    Options    :
      Examples: "/var/local/coredns/config/corefile"

`FORWARD`

    Description: forward
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "10.1.11.1"
      None    : ""

`HEALTH`

    Description: health
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ":8080"
    Options    :
      Examples: ""

`LOG`

    Description: record queries (log) and errors (comma-separated dictionary)
    Required   : False
    Value      : Arbitrary
    Type       : Dictionary
    Default    : "errors"
    Options    :
      Examples: "log" | "log,errors" | "log, errors"
      None    : ""

`PORT`

    Description: -dns.port
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 1053
    Options    :
      Examples: 8053

`RELOAD`

    Description: reload
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "30s"
    Options    :
      Examples: "10s" | "60s"

`ROOT`

    Description: root
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/coredns/zones"
    Options    :
      Examples: "/data"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [CoreDNS](https://coredns.io)
- [Plugins](https://github.com/coredns/coredns/tree/master/plugin)
