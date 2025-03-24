# forgejo

## Index

- [About](#about)
  - [Support](#support)
  - [Dependencies](#dependencies)
    - [Archives](#archives)
    - [Images](#images)
- [Setup](#setup)
  - [Podman](#podman)
  - [User](#user)
  - [Storage](#storage)
  - [Container](#container)
    - [Build](#build)
    - [Run](#run)
    - [Troubleshoot](#troubleshoot)
- [Parameters](#parameters)
- [License](#license)
- [Credits](#credits)
- [Appendix](#appendix)

## About

This OCI container contains the `forgejo`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [forgejo](https://codeberg.org/forgejo/forgejo/releases/download/v10.0.3/forgejo-10.0.3-linux-amd64) `10.0.3`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "forgejo:20000:65534" | sudo tee --append /etc/subgid
    echo "forgejo:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'forgejo' --create-home --password '!' --shell '/bin/bash' forgejo
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger forgejo
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal forgejo
    ```

### Storage

- Create the directories for the persistent data:

    ```
    sudo mkdir -p /opt/forgejo/{ssh,work}
    sudo chown forgejo:forgejo /opt/forgejo
    sudo chmod 0750 /opt/forgejo
    sudo chmod 0700 /opt/forgejo/ssh
    sudo chown -R 29999:29999 /opt/forgejo/{ssh,work}
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - forgejo
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `forgejo` container directory:

    ```
    cd ./oci-containers/forgejo/
    ```

- Build the `forgejo` container:

    ```
    podman build --tag $(basename ${PWD}):$(cat ./VERSION) .
    ```

- _Optional:_ Tag and push the image to a registry:

    ```
    podman build --tag registry.example.com/$(basename ${PWD}):$(cat ./VERSION) .
    podman push registry.example.com/$(basename ${PWD}):$(cat ./VERSION)
    ```

#### Run

- Start the container with custom parameters:

    ```
    podman run --detach --name forgejo --network=host \
        --volume /opt/forgejo/ssh:/var/local/forgejo/ssh \
        --volume /opt/forgejo/work:/var/local/forgejo/work \
        forgejo:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow forgejo
    ```

- Start, stop, remove a container:

    ```
    podman container start forgejo
    podman container stop forgejo
    podman container rm forgejo
    ```

- Inspect a running container:

    ```
    podman inspect forgejo
    ```

- Debug a running container:

    ```
    podman exec --user root -ti forgejo /bin/bash
    podman exec --user forgejo -ti forgejo /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/forgejo:latest /bin/bash
    ```

- Get forgejo:

    ```
    curl --silent --request GET --location http://localhost:3000/
    ```

## Parameters

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
