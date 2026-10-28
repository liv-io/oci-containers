# bitcoin-core

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

OCI container for `bitcoin-core`.

## Dependencies

### Build

#### Resources

|Name                                       |Version      |Type   |
|:---                                       |:---         |:---   |
|[Debian](https://docker.io/debian)         |`stable-slim`|Image  |
|[bitcoin-core](https://bitcoincore.org/bin)|`32.1`       |Archive|

### Runtime

#### Ports

|Port  |Protocol|Service|Description |
|:---  |:---    |:---   |:---        |
|`5555`|`tcp`   |ZeroMQ |PubHashBlock|
|`5556`|`tcp`   |ZeroMQ |PubHashTx   |
|`5557`|`tcp`   |ZeroMQ |PubRawBlock |
|`5558`|`tcp`   |ZeroMQ |PubRawTx    |
|`8332`|`tcp`   |RPC    |RPC         |
|`8333`|`tcp`   |Network|Peer to peer|

#### Volumes

|Mount Path                  |Type             |Mode|Size |Description|
|:---                        |:---             |:---|:--- |:---       |
|`/var/local/bitcoin-core/db`|`hostPath`, `pvc`|`rw`|-    |Database   |

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

`ADDNODE`

    Description: -addnode
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "10.1.1.10:8333" | "btc.example.com:8333 btc.example.org:8333"
      None    : ""

`BIND`

    Description: -bind
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "0.0.0.0"
    Options    :
      Examples: "127.0.0.1" | "1.2.3.4" | "5.6.7.8:8333"

`CHAIN`

    Description: -chain
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "main"
    Options    :
      Examples: "main" | "testnet3" | "testnet4"

`DATADIR`

    Description: -datadir
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/var/local/bitcoin-core/db"
    Options    :
      Examples: "/mnt/db"

`DBCACHE`

    Description: -dbcache
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 2048
    Options    :
      Examples: 4096

`EXTERNALIP`

    Description: -externalip
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ""
    Options    :
      Examples: "1.2.3.4" | "5.6.7.8"
      None    : ""

`MAXUPLOADTARGET`

    Description: -maxuploadtarget (MiB per day)
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : ""
    Options    :
      Examples: 25787 | 103148 | 515738 | 1031475
      None    : ""

`ONLYNET`

    Description: -onlynet
    Required   : False
    Value      : Predetermined
    Type       : Array
    Default    : "ipv4"
    Options    :
      Examples: "ipv4 ipv6" | "onion" | "i2p" | "cjdns"

`PORT`

    Description: -port
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    :
      main:     8333
      testnet3: 18333
      testnet4: 48333
    Options    :
      Examples: 8333 | 18333 | 48333

`REST`

    Description: -rest
    Required   : False
    Value      : Predetermined
    Type       : Boolean
    Default    : false
    Options    : true | false

`RPCALLOWIP`

    Description: -rpcallowip
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : "127.0.0.0/8"
    Options    :
      Examples: "127.0.0.0/8" | "0.0.0.0/0"
      None    : ""

`RPCAUTH`

    Description: -rpcauth
                 https://github.com/bitcoin/bitcoin/tree/master/share/rpcauth
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "satoshi:d7316644b50aa7ea8792daf5c6b897e4$54194677335fcb771aa39533ddc2833927de9626b0d8fcb7940a7f56aa8a9569" |
                "satoshi:63c20cd63c1eed39bfd8ecc04cf8d816$83340b182b07b1b2d55352797eab617b821f83c4f1c28bd3dfc40240e412ec7a"
      None    : ""

`RPCBIND`

    Description: -rpcbind
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : "127.0.0.1"
    Options    :
      Examples: "0.0.0.0" | "1.2.3.4 5.6.7.8:8332"

`RPCPORT`

    Description: -rpcport
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    :
      main:     8332
      testnet3: 18332
      testnet4: 48332
    Options    :
      Examples: 8332 | 18332 | 48332

`RPCWORKQUEUE`

    Description: -rpcworkqueue
    Required   : False
    Value      : Arbitrary
    Type       : Integer
    Default    : 32
    Options    :
      Examples: 16 | 32 | 64

`ZMQPUBHASHBLOCK`

    Description: -zmqpubhashblock
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5555"
    Options    :
      Examples: "tcp://0.0.0.0:5555"
      None    : ""

`ZMQPUBHASHTX`

    Description: -zmqpubhashtx
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5556"
    Options    :
      Examples: "tcp://0.0.0.0:5556"
      None    : ""

`ZMQPUBRAWBLOCK`

    Description: -zmqpubrawblock
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5557"
    Options    :
      Examples: "tcp://0.0.0.0:5557"
      None    : ""

`ZMQPUBRAWTX`

    Description: -zmqpubrawtx
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "tcp://127.0.0.1:5558"
    Options    :
      Examples: "tcp://0.0.0.0:5558"
      None    : ""

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [bitcoin-core](https://bitcoincore.org)
