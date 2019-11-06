# etcd Operator
The etcd operator and the etcd cluster are installed using the stable chart version from helm repos.

## Requirements

helm 3 | Download [here](https://github.com/helm/helm/releases)

## Install Custom Resource Definition
```bash
$ kubectl apply -f crds/etcd-cluster-crd.yaml
```
## Install etcd-operator from helm repos
```bash
$ export ENV=(dev|prod)
$ helm upgrade etcd-operator stable/etcd-operator --install --namespace etcd-operator -f $ENV.values.yaml
```
