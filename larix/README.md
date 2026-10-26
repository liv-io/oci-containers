# larix

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

OCI container for `larix`.

## Dependencies

### Build

#### Resources

|Name                              |Version      |Type   |
|:---                              |:---         |:---   |
|[Debian](https://docker.io/debian)|`stable-slim`|Image  |
|[Go](https://go.dev/dl)           |`1.27.3`     |Archive|

### Runtime

#### Ports

|Port  |Protocol|Service|Description|
|:---  |:---    |:---   |:---       |
|`8080`|`tcp`   |HTTP   |Web        |

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

- [larix](https://github.com/liv-io/oci-containers/tree/main/larix)
