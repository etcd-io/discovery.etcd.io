## Installing the Chart

Create the `namespace`:

```console
$ kubectl create namespace prometheus-operator
```

To install the chart with release name `prometheus-operator` run:


```console
$ export ENV=(dev|prod)
$ helm upgrade prometheus-operator . --install --namespace prometheus-operator -f $ENV.values.yaml
```

The command deploys prometheus-operator on the Kubernetes cluster in custom values configuration. The [configuration](https://github.com/helm/charts/blob/master/stable/prometheus-operator/README.md#configuration) section lists the parameters that can be configured during installation.

The default installation includes Prometheus Operator, Alertmanager, Grafana, and configuration for scraping Kubernetes infrastructure.

## Uninstalling the Chart

To uninstall/delete the `prometheus` deployment:

```console
$ helm delete prometheus-operator
```

## Work-Arounds for Known Issues

### Running on private GKE clusters
When Google configure the control plane for private clusters, they automatically configure VPC peering between your Kubernetes cluster’s network and a separate Google managed project. In order to restrict what Google are able to access within your cluster, the firewall rules configured restrict access to your Kubernetes pods. This means that in order to use the webhook component with a GKE private cluster, you must configure an additional firewall rule to allow the GKE control plane access to your webhook pod.

You can read more information on how to add firewall rules for the GKE control plane nodes in the [GKE docs](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#add_firewall_rules)

Alternatively, you can disable the hooks by setting `prometheusOperator.admissionWebhooks.enabled=false`.

### Helm fails to create CRDs
Due to a bug in helm, it is possible for the 5 CRDs that are created by this chart to fail to get fully deployed before Helm attempts to create resources that require them. This affects all versions of Helm with a [potential fix pending](https://github.com/helm/helm/pull/5112). In order to work around this issue when installing the chart you will need to make sure all 5 CRDs exist in the cluster first and disable their previsioning by the chart:

1. Create CRDs
```console
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/alertmanager.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/prometheus.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/prometheusrule.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/servicemonitor.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/podmonitor.crd.yaml
```

2. Wait for CRDs to be created, which should only take a few seconds

3. Install the chart, but disable the CRD provisioning by setting `prometheusOperator.createCustomResource=false`
```console
$ helm install --name my-release stable/prometheus-operator --set prometheusOperator.createCustomResource=false
```

## Uninstalling the Chart

To uninstall/delete the `prometheus` deployment:

```console
$ helm delete prometheus
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

CRDs created by this chart are not removed by default and should be manually cleaned up:

```console
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
```