# tink

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

OCI container for `tink`.

## Dependencies

### Build

#### Resources

|Name                                      |Version      |Type   |
|:---                                      |:---         |:---   |
|[Debian](https://docker.io/debian)        |`stable-slim`|Image  |
|[Go](https://go.dev/dl)                   |`1.27.1`     |Archive|
|[tink](https://github.com/liv-io/tink.git)|`main`       |Git    |

### Runtime

#### Ports

|Port  |Protocol|Service|Description |
|:---  |:---    |:---   |:---        |
|`8080`|`tcp`   |HTTP   |Web         |

#### Volumes

#### WorkingDir

|Directory|Description   |
|:---     |:---          |
|`/`      |root directory|

#### Environment Variables

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix

- [tink](https://github.com/liv-io/tink)
