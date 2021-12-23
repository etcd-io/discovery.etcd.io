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
helm upgrade ingress-nginx ingress-nginx/ingress-nginx --install --create-namespace --namespace ingress-nginx -f values.yaml --version ${version} --atomic --debug
```
