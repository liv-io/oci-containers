# step-ca

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

This OCI container contains the `step-ca`.

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [cli](https://github.com/smallstep/cli/releases/download/v0.28.7/step_linux_0.28.7_amd64.tar.gz) `cli`
- [cosign](https://github.com/sigstore/cosign/releases/download/v2.6.1/cosign-linux-amd64) `cosign`
- [step-ca](https://github.com/smallstep/certificates/releases/download/v0.28.4/step-ca_linux_0.28.4_amd64.tar.gz) `step-ca`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "step-ca:20000:65534" | sudo tee --append /etc/subgid
    echo "step-ca:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'step-ca' --create-home --password '!' --shell '/bin/bash' step-ca
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger step-ca
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal step-ca
    ```

### Storage

- Create the directories for the persistent data:

    ```
    sudo mkdir -p /opt/step-ca/data
    sudo chown step-ca:step-ca /opt/step-ca
    sudo chmod 0750 /opt/step-ca
    sudo chown -R 29999:29999 /opt/step-ca/data
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - step-ca
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `step-ca` container directory:

    ```
    cd ./oci-containers/step-ca/
    ```

- Build the `step-ca` container:

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
    podman run --detach --name step-ca --network=host \
        --volume /opt/step-ca/data:/var/local/step-ca/data \
        step-ca:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow step-ca
    ```

- Start, stop, remove a container:

    ```
    podman container start step-ca
    podman container stop step-ca
    podman container rm step-ca
    ```

- Inspect a running container:

    ```
    podman inspect step-ca
    ```

- Debug a running container:

    ```
    podman exec --user root -ti step-ca /bin/bash
    podman exec --user step-ca -ti step-ca /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/step-ca:latest /bin/bash
    ```

## Parameters

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
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "*.example.com"
    Options    :
      Examples: "*.example.org"

`ALLOW_EMAIL`

    Description: .authority.policy.ssh.user.allow.email
    Required   : False
    Value      : Arbitrary
    Type       : String
    Default    : "@example.com"
    Options    :
      Examples: "@example.org"

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
