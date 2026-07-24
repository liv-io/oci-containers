# k8s-ops

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

This OCI container contains the following Kubernetes GitOps tools:
- helm
- k0s
- k0sctl
- kubectl
- kubesoloctl
- kustomize
- yq

### Support

The following operating system-level virtualization technologies are supported:
- Docker `>= 20.0.0`
- Podman `>= 3.0.0`

### Dependencies

#### Archives

- [cosign](https://github.com/sigstore/cosign/releases/download/v3.1.2/cosign-linux-amd64) `3.1.2`
- [helm](https://get.helm.sh/helm-v4.2.3-linux-amd64.tar.gz) `4.2.3`
- [k0s](https://github.com/k0sproject/k0s/releases/download/v1.36.2%2Bk0s.0/k0s-v1.36.2+k0s.0-amd64) `1.36.2+k0s.0`
- [k0sctl](https://github.com/k0sproject/k0sctl/releases/download/v0.32.1/k0sctl-linux-amd64) `0.32.1`
- [kubectl](https://dl.k8s.io/release/v1.36.2/bin/linux/amd64/kubectl) `1.36.2`
- [kubesoloctl](https://github.com/portainer/kubesolo/releases/download/v1.1.9/kubesoloctl-linux-amd64) `1.1.9`
- [kustomize](https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.8.1/kustomize_v5.8.1_linux_amd64.tar.gz) `5.8.1`
- [yq](https://github.com/mikefarah/yq/releases/download/v4.53.3/yq_linux_amd64.tar.gz) `4.53.3`

#### Images

- [Debian](docker.io/debian) `stable-slim`

## Setup

### Podman

Please refer to the [README.md](../README.md) file in the root directory of this Git repository.

### User

The following commands ought to be executed on the system running the container.

- Enable rootless mode for the respective user:

    ```
    echo "k0s:20000:65534" | sudo tee --append /etc/subgid
    echo "k0s:20000:65534" | sudo tee --append /etc/subuid
    ```

- Create the user running the container:

    ```
    sudo useradd --uid 10000 --user-group --comment 'k0s' --create-home --password '!' --shell '/bin/bash' k0s
    ```

- Allow the user to run long-running services

    ```
    sudo loginctl enable-linger k0s
    ```

- Add the user to the `systemd-journal` group

    ```
    sudo usermod -a -G systemd-journal k0s
    ```

### Storage

- Create the directories for the persistent data:

    ```
    sudo mkdir -p /opt/k0s
    sudo chown k0s:k0s /opt/k0s
    sudo chmod 0750 /opt/k0s
    ```

### Container

#### Build

- Switch to the user running the container:

    ```
    sudo su - k0s
    ```

- Clone the `oci-containers` Git repository:

    ```
    git clone https://github.com/liv-io/oci-containers.git
    ```

- Change to the `k0s` container directory:

    ```
    cd ./oci-containers/k0s/
    ```

- Build the `k0s` container:

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
    podman run --detach --name k0s --network=host \
        k0s:latest
    ```

#### Troubleshoot

- Show the running container:

    ```
    podman ps --all
    podman container ls --all
    ```

- Show and follow the logs:

    ```
    podman logs --follow k0s
    ```

- Start, stop, remove a container:

    ```
    podman container start k0s
    podman container stop k0s
    podman container rm k0s
    ```

- Inspect a running container:

    ```
    podman inspect k0s
    ```

- Debug a running container:

    ```
    podman exec --user root -ti k0s /bin/bash
    podman exec --user k0s -ti k0s /bin/bash
    ```

- Debug a crashing image:

    ```
    podman run --user root -ti <checksum> /bin/bash
    podman run --user root -ti registry.example.com/k0s:latest /bin/bash
    ```

## Parameters

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix
