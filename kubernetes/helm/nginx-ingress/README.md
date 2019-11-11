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

## Override values in the chart

To change default values use the `--set` flag and pass configuration from the command line.
For example, if you want to change the default value of autoscaling to enable the Horizontal Pod Autoscaler in production, then run:
```bash
$ export AUTOSCALER=true
$ export ENV=prod
$ helm upgrade etcd-operator stable/etcd-operator --install --namespace etcd-operator -f $ENV.values.yaml --set controller.autoscaling.enabled=true
```

See all configurable parameters of the nginx-ingress chart [here](https://github.com/helm/charts/tree/master/stable/nginx-ingress#configuration).