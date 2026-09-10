# k8s-ops

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

|Name                                                     |Version       |Type   |
|:---                                                     |:---          |:---   |
|[Debian](https://docker.io/debian)                       |`stable-slim` |Image  |
|[cosign](https://github.com/sigstore/cosign)             |`3.1.3`       |Binary |
|[crictl](https://github.com/kubernetes-sigs/cri-tools)   |`1.37.0`      |Archive|
|[ctr](https://github.com/containerd/containerd)          |`1.7.35`      |Archive|
|[helm](https://get.helm.sh)                              |`4.3.0`       |Archive|
|[k0s](https://github.com/k0sproject/k0s)                 |`1.36.4+k0s.0`|Binary |
|[k0sctl](https://github.com/k0sproject/k0sctl)           |`0.32.2`      |Binary |
|[kubectl](https://dl.k8s.io)                             |`1.37.0`      |Binary |
|[kubesoloctl](https://github.com/portainer/kubesolo)     |`1.2.0`       |Binary |
|[kustomize](https://github.com/kubernetes-sigs/kustomize)|`5.8.1`       |Archive|
|[yq](https://github.com/mikefarah/yq)                    |`4.53.6`      |Archive|

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
