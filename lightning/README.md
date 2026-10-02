# lightning

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

OCI container for `lightning`.

## Dependencies

### Build

#### Resources

|Name                                                     |Version      |Type   |
|:---                                                     |:---         |:---   |
|[Debian](https://docker.io/debian)                       |`stable-slim`|Image  |
|[bitcoin-core](https://bitcoincore.org/bin)              |`31.1`       |Archive|
|[lightning](https://github.com/ElementsProject/lightning)|`26.06.8`    |Archive|

### Runtime

#### Ports

|Port  |Protocol|Service|Description              |
|:---  |:---    |:---   |:---                     |
|`9735`|`tcp`   |p2p    |Bitcoin Lightning Network|

#### Volumes

|Mount Path                 |Type                          |Mode|Size |Description|
|:---                       |:---                          |:---|:--- |:---       |
|`/var/local/lightning/data`|`configMap`, `hostPath`, `pvc`|`rw`|`-`  |data       |

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

`ADDR`

    Description: --addr
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`ALIAS`

    Description: --alias
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "lightning-node" | "lightning-node-alias"
      None    : ""

`ANNOUNCE_ADDR`

    Description: --announce-addr
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`ANNOUNCE_ADDR_DISCOVERED`

    Description:
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "false"
    Options    :
      Examples: "true" | "false" | "auto"

`ANNOUNCE_ADDR_DISCOVERED_PORT`

    Description: --announce-addr-discovered-port
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "9735"
    Options    :
      Examples: "9735" | "8735"

`AUTOLISTEN`

    Description: --autolisten
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`BIND_ADDR`

    Description: --bind-addr
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "0.0.0.0"
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`BITCOIN_CLI`

    Description: --bitcoin-cli
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/usr/local/bin/bitcoin-cli"
    Options    :
      Examples: "/mnt/bin/bitcoin-cli"

`BITCOIN_DATADIR`

    Description: --bitcoin-datadir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lightning/bitcoin-cli"
    Options    :
      Examples: "/mnt/lightning/bitcoin-cli"

`BITCOIN_RPCCONNECT`

    Description: --bitcoin-rpcconnect
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "127.0.0.1"
    Options    :
      Examples: "10.10.10.10"

`BITCOIN_RPCPASSWORD`

    Description: --bitcoin-rpcpassword
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "q-HrBk83.5w9wuhFt,nP" | "J4eQwP_vkMnB8A!s9pRp"
      None    : ""

`BITCOIN_RPCPORT`

    Description: --bitcoin-rpcport
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "8332"
    Options    :
      Examples: "8334"

`BITCOIN_RPCUSER`

    Description: --bitcoin-rpcuser
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "satoshi" | "hal" | "len" | "nick" | "adam" | "david"
      None    : ""

`CLNREST_HOST`

    Description: --clnrest-host
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "0.0.0.0"
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`CLNREST_PORT`

    Description: --clnrest-port
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "3010"
    Options    :
      Examples: "6020"

`CLNREST_PROTOCOL`

    Description: --clnrest-protocol
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "HTTP"
    Options    :
      Examples: "HTTP" | "HTTPS"
      None    : ""

`LIGHTNING_DIR`

    Description: --lightning-dir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lightning/data"
    Options    :
      Examples: "/mnt/data"

`LOG_LEVEL`

    Description: --log-level
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "info"
    Options    :
      Examples: "io" | "debug" | "info" | "unusual" | "broken"

`LOG_TIMESTAMPS`

    Description: --log-timestamps
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : true
    Options    : true | false

`NETWORK`

    Description: --network / --mainnet / --testnet
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "mainnet"
    Options    : "testnet" | "mainnet"

`RGB`

    Description: --rgb
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "000000"
    Options    :
      Examples: "f2a900" | "cc9900"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [lightning](https://corelightning.org)
