# step-ca

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

OCI container for `step-ca`.

## Dependencies

### Build

#### Resources

|Name                                                         |Version      |Type   |
|:---                                                         |:---         |:---   |
|[Debian](https://docker.io/debian)                           |`stable-slim`|Image  |
|[cli](https://github.com/smallstep/cli/releases)             |`0.30.6`     |Archive|
|[cosign](https://github.com/sigstore/cosign/releases)        |`3.1.3`      |Binary |
|[step-ca](https://github.com/smallstep/certificates/releases)|`0.30.2`     |Archive|

### Runtime

#### Ports

|Port  |Protocol|Service|Description|
|:---  |:---    |:---   |:---       |
|`8080`|`tcp`   |HTTP   |API        |

#### Volumes

|Mount Path               |Type             |Mode|Size |Description|
|:---                     |:---             |:---|:--- |:---       |
|`/var/local/step-ca/data`|`hostPath`, `pvc`|`rw`|`-`  |Data       |

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

`ADDRESS`

    Description: .address
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : ":1443"
    Options    :
      Examples: ":2443" | ":3443"

`ALLOW_DNS`

    Description: .authority.policy.x509.allow.dns
                 .authority.policy.ssh.host.allow.dns
                 (white-space or comma-separated)
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "example.com, *.example.com"

`ALLOW_EMAIL`

    Description: .authority.policy.ssh.user.allow.email
                 (white-space or comma-separated)
    Required   : False
    Value      : Arbitrary
    Type       : Array
    Default    : ""
    Options    :
      Examples: "@example.com, @example.org"

`CA_JSON`

    Description: ca.json
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/home/step-ca/.step/config/ca.json"
    Options    :
      Examples: "/home/step-ca/.step/config/ca.json"

`COMMON_NAME`

    Description: .commonName
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "example CA"
    Options    :
      Examples: "example CA"

`CRT`

    Description: intermediate_ca.crt
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/home/step-ca/.step/certs/intermediate_ca.crt"
    Options    :
      Examples: "/home/step-ca/.step/certs/intermediate_ca.crt"

`DATA_SOURCE`

    Description: db
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/home/step-ca/.step/db"
    Options    :
      Examples: "/home/step-ca/.step/db"

`DNS_NAMES`

    Description: .dnsNames
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "ca.example.com"
    Options    :
      Examples: "ca.example.org"

`KEY`

    Description: intermediate_ca_key
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/home/step-ca/.step/secrets/intermediate_ca_key"
    Options    :
      Examples: "/home/step-ca/.step/secrets/intermediate_ca_key"

`PASSWORD_TXT`

    Description: password.txt
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/home/step-ca/.step/password.txt"
    Options    :
      Examples: "/home/step-ca/.step/password.txt"

`ROOT`

    Description: password.txt
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "/home/step-ca/.step/certs/root_ca.crt"
    Options    :
      Examples: "/home/step-ca/.step/certs/root_ca.crt"

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [Step CA](https://smallstep.com/docs/step-ca)
