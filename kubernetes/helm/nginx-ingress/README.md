## Installing the Chart

Create the `namespace`:

```console
$ kubectl create namespace nginx-ingress
```

### Install from helm hub

```bash
export ENV=(dev|prod)
helm upgrade nginx-ingress stable/nginx-ingress --install --namespace nginx-ingress -f $ENV.values.yaml
```
