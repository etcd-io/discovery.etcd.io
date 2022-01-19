## Export chart version

Get the latest ingress-nginx chart version [here](https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx).

```console
$ export VERSION=4.0.13
```

## Installing the Chart

Create the `namespace`:

```console
$ kubectl create namespace ingress-nginx
```

### Install from helm hub

```bash
helm upgrade ingress-nginx ingress-nginx/ingress-nginx --install --create-namespace --namespace ingress-nginx -f values.yaml --version ${VERSION} --atomic --debug
```
