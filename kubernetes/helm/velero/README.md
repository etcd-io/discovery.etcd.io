## Export chart version

Get the latest version of the velero helm chart [here](https://github.com/vmware-tanzu/helm-charts/tree/master/charts/velero).

```console
$ export VERSION=2.30.2
```

## Installing the Chart

Create the `namespace`:

```console
$ kubectl create namespace velero
```

### Install from vmware-tanzu

```bash
export ENV=(dev|prod)
helm upgrade --install velero vmware-tanzu/velero --namespace velero -f ${ENV}.values.yaml --version ${VERSION} --atomic --debug
```
