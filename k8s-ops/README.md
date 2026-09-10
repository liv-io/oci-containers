# k8s-ops

## Index

- [About](#about)
- [Dependencies](#dependencies)
  - [Build](#build)
    - [Resources](#resources)
  - [Runtime](#runtime)
    - [Ports](#ports)
    - [Volumes](#volumes)
    - [WorkingDir](#WorkingDir)
    - [Environment Variables](#environment-variables)
- [License](#license)
- [Credits](#credits)
- [Appendix](#appendix)

## About

This OCI container contains the following Kubernetes GitOps tools:
- crictl
- ctr
- helm
- k0s
- k0sctl
- kubectl
- kubesoloctl
- kustomize
- yq

## Dependencies

### Build

#### Resources

|Name                                                     |Type   |Version       |
|:---                                                     |:---   |:---          |
|[Debian](https://docker.io/debian)                       |Image  |`stable-slim` |
|[cosign](https://github.com/sigstore/cosign)             |Binary |`3.1.3`       |
|[crictl](https://github.com/kubernetes-sigs/cri-tools)   |Archive|`1.37.0`      |
|[ctr](https://github.com/containerd/containerd)          |Archive|`1.7.35`      |
|[helm](https://get.helm.sh)                              |Archive|`4.3.0`       |
|[k0s](https://github.com/k0sproject/k0s)                 |Binary |`1.36.4+k0s.0`|
|[k0sctl](https://github.com/k0sproject/k0sctl)           |Binary |`0.32.2`      |
|[kubectl](https://dl.k8s.io)                             |Binary |`1.37.0`      |
|[kubesoloctl](https://github.com/portainer/kubesolo)     |Binary |`1.2.0`       |
|[kustomize](https://github.com/kubernetes-sigs/kustomize)|Archive|`5.8.1`       |
|[yq](https://github.com/mikefarah/yq)                    |Archive|`4.53.6`      |

### Runtime

#### Ports

#### Volumes

#### WorkingDir

#### Environment Variables

## License

See `LICENSE` file for more information.

## Credits

See `CREDITS.md` file for more information.

## Appendix
