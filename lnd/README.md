# lnd

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

OCI container for `lnd`.

## Dependencies

### Build

#### Resources

|Name                                                   |Version      |Type   |
|:---                                                   |:---         |:---   |
|[Debian](https://docker.io/debian)                     |`stable-slim`|Image  |
|[lnd](https://github.com/lightningnetwork/lnd/releases)|`0.21.4-beta`|Archive|

### Runtime

#### Ports

|Port  |Protocol|Service|Description              |
|:---  |:---    |:---   |:---                     |
|`9735`|`tcp`   |p2p    |Bitcoin Lightning Network|

#### Volumes

|Mount Path           |Type                          |Mode|Size |Description|
|:---                 |:---                          |:---|:--- |:---       |
|`/var/local/lnd/data`|`configMap`, `hostPath`, `pvc`|`rw`|`-`  |data       |

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

`ALIAS`

    Description: --alias
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "lnd-node" | "lnd-node-alias"
      None    : ""

`BITCOIND_ESTIMATEMODE`

    Description: --bitcoind.estimatemode
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "ECONOMICAL"
    Options    : "ECONOMICAL" | "CONSERVATIVE"

`BITCOIND_RPCHOST`

    Description: --bitcoind.rpchost
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "127.0.0.1:8332"
    Options    :
      Examples: "10.10.10.10:8332"

`BITCOIND_RPCPASS`

    Description: --bitcoind.rpcpass
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "q-HrBk83.5w9wuhFt,nP" | "J4eQwP_vkMnB8A!s9pRp"
      None    : ""

`BITCOIND_RPCUSER`

    Description: --bitcoind.rpcuser
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "satoshi" | "hal" | "len" | "nick" | "adam" | "david"
      None    : ""

`BITCOIND_ZMQPUBRAWBLOCK`

    Description: --bitcoind.zmqpubrawblock
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5557"
    Options    :
      Examples: "tcp://10.10.10.10:5557"
      None    : ""

`BITCOIND_ZMQPUBRAWTX`

    Description: --bitcoind.zmqpubrawtx
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5558"
    Options    :
      Examples: "tcp://10.10.10.10:5558"
      None    : ""

`BITCOIN_NETWORK`

    Description: --bitcoin.testnet / --bitcoin.mainnet
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "mainnet"
    Options    : "testnet" | "mainnet"

`BITCOIN_NODE`

    Description: --bitcoin.node
    Required   : False
    Value      : Predetermined
    Type       : String
    Default    : "bitcoind"
    Options    : "btcd" | "bitcoind"

`COLOR`

    Description: --color
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "#000000"
    Options    :
      Examples: "#f2a900" | "#cc9900"

`EXTERNALIP`

    Description: --externalip
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`LISTEN`

    Description: --listen
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "0.0.0.0:9735"
    Options    :
      Examples: "127.0.0.1:9735" | "1.2.3.4:9735"

`LNDDIR`

    Description: --lnddir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/lnd/data"
    Options    :
      Examples: "/mnt/lnd"

`RESTLISTEN`

    Description: --restlisten
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "127.0.0.1:8080" | "0.0.0.0:8080" | "[::1]:8080"
      None    : ""

`RPCLISTEN`

    Description: --rpclisten
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "127.0.0.1:10009" | "0.0.0.0:10009" | "[::1]:10009"
      None    : ""

`WALLET_PASSWORD`

    Description: lncli unlock --stdin
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "51!bDsV=SQJbYt3mJarb+ZRYsEyJN,P3" | "VZ.kSMtb8Jea4bc,Ff2JM!a38mx3+l49"
      None    : ""

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [lnd](https://lightning.engineering)
