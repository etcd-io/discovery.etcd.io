## Export chart version

Get the latest nginx-ingress chart version [here](https://hub.helm.sh/charts/stable/nginx-ingress).

```console
$ export VERSION=1.29.6
```

## Installing the Chart

Create the `namespace`:

```console
$ kubectl create namespace nginx-ingress
```

### Install from helm hub

```bash
helm upgrade nginx-ingress stable/nginx-ingress --install --namespace nginx-ingress -f values.yaml --version ${VERSION} --atomic --debug
```
