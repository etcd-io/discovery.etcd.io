# etcd Operator
The etcd operator and the etcd cluster are installed using the stable chart version from helm repos.

## Requirements

helm 3 | Download [here](https://github.com/helm/helm/releases)

## Create the `namespace`:
```bash
$ kubectl create namespace discoveryserver
```

## Install Custom Resource Definition
```bash
$ kubectl apply -f crds/etcd-cluster-crd.yaml
```
## Install etcd-operator from helm repos
```bash
$ helm upgrade etcd-operator stable/etcd-operator --install --namespace discoveryserver -f values.yaml
```
