# btcd

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

OCI container for `btcd`.

## Dependencies

### Build

#### Resources

|Name                                             |Version      |Type   |
|:---                                             |:---         |:---   |
|[Debian](https://docker.io/debian)               |`stable-slim`|Image  |
|[btcd](https://github.com/btcsuite/btcd/releases)|`0.27.0`     |Archive|

### Runtime

#### Ports

|Port  |Protocol|Service|Description |
|:---  |:---    |:---   |:---        |
|`8333`|`tcp`   |Network|Peer to peer|
|`8334`|`tcp`   |RPC    |RPC         |

#### Volumes

|Mount Path          |Type             |Mode|Size |Description|
|:---                |:---             |:---|:--- |:---       |
|`/var/local/btcd/db`|`hostPath`, `pvc`|`rw`|`-`  |Database   |

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

`ADDPEER`

    Description: --addpeer
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "10.1.1.10:8333" | "btc.example.com:8333 btc.example.org:8333"
      None    : ""

`DEBUGLEVEL`

    Description: --debuglevel
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "info"
    Options    :
      Examples: "trace" | "debug" | "info" | "warn" | "error" | "critical"

`EXTERNALIP`

    Description: --externalip
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "1.2.3.4 5.6.7.8"
      None    : ""

`LISTEN`

    Description: --listen
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : "0.0.0.0:8333"
    Options    :
      Examples: "127.0.0.1:8333" | "1.2.3.4:8333 5.6.7.8:8333"

`RPCLISTEN`

    Description: --rpclisten
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : "127.0.0.1:8334"
    Options    :
      Examples: "0.0.0.0:8334" | "1.2.3.4:8334 5.6.7.8:8334"
      None    : ""

`RPCPASS`

    Description: --rpcpass
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "q-HrBk83.5w9wuhFt,nP" | "J4eQwP_vkMnB8A!s9pRp"
      None    : ""

`RPCUSER`

    Description: --rpcuser
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "satoshi" | "hal" | "len" | "nick" | "adam" | "david"
      None    : ""

`SIGCACHEMAXSIZE`

    Description: --sigcachemaxsize
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : ""
    Options    :
      Examples: 100000 | 200000
      None    : ""

`UTXOCACHEMAXSIZE`

    Description: --utxocachemaxsize
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : ""
    Options    :
      Examples: 250 | 500
      None    : ""

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [btcd](https://github.com/btcsuite/btcd)
