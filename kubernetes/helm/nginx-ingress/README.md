## Installing the Chart

Create the `namespace`:

```console
$ kubectl create namespace nginx-ingress
```

### Install from helm hub

```bash
helm upgrade nginx-ingress stable/nginx-ingress --install --namespace nginx-ingress -f values.yaml --atomic --debug
```
