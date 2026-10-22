# blockbook

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

OCI container for `blockbook`.

## Dependencies

### Build

#### Resources

|Name                                                |Version      |Type   |
|:---                                                |:---         |:---   |
|[Debian](https://docker.io/debian)                  |`stable-slim`|Image  |
|[Go](https://go.dev/dl)                             |`1.27.3`     |Archive|
|[blockbook](https://github.com/trezor/blockbook.git)|`master`     |Git    |

### Runtime

#### Ports

|Port  |Protocol|Service|Description|
|:---  |:---    |:---   |:---       |
|`8080`|`tcp`   |HTTP   |API        |

#### Volumes

|Mount Path                   |Type                          |Mode|Size |Description        |
|:---                         |:---                          |:---|:--- |:---               |
|`/var/local/blockbook/config`|`emptyDir`                    |`rw`|`4Mi`|Configuration files|
|`/var/local/blockbook/db`    |`configMap`, `hostPath`, `pvc`|`rw`|`-`  |Database           |

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

`BLOCK_ADDRESSES_TO_KEEP`

    Description: .block_addresses_to_keep
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 300
    Options    :
      Examples: 600 | 900
      None    : ""

`COIN_LABEL`

    Description: .coin_label
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "Bitcoin"
    Options    :
      Examples: "Bitcoin"

`COIN_NAME`

    Description: .coin_name
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "Bitcoin"
    Options    :
      Examples: "Bitcoin"

`COIN_SHORTCUT`

    Description: .coin_shortcut
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "BTC"
    Options    :
      Examples: "BTC"

`MESSAGE_QUEUE_BINDING`

    Description: .rpc_url
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "tcp://1.2.3.4:5555" | "tcp://5.6.7.8:5555"

`PARSE`

    Description: .parse
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`PORT`

    Description: -public
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 8080
    Options    :
      Examples: 8090 | 8100
      None    : ""

`RPC_PASS`

    Description: .rpc_pass
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "q-HrBk83.5w9wuhFt,nP" | "J4eQwP_vkMnB8A!s9pRp"

`RPC_TIMEOUT`

    Description: .rpc_timeout
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : 25
    Options    :
      Examples: 50 | 100
      None    : ""

`RPC_URL`

    Description: .rpc_url
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "http://1.2.3.4:8332" | "http://5.6.7.8:8332"

`RPC_USER`

    Description: .rpc_user
    Required   : True
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "satoshi" | "hal" | "len" | "nick" | "adam" | "david"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [blockbook](https://github.com/trezor/blockbook)
