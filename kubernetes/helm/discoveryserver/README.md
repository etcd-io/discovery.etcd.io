# discoveryserver Helm chart

Installs [discoveryserver](https://github.com/etcd-io/discoveryserver) to create/configure/manage the discovery service required when bootstrapping etcd clusters.

## TL;DR;

```console
$ export ENV=(dev|prod)
$ helm upgrade discoveryserver . --install --namespace discoveryserver -f dev.values.yaml
```

## Introduction

This chart bootstraps a [discoveryserver](https://github.com/etcd-io/discoveryserver) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
  - Kubernetes 1.14+
  - Helm [3+](https://helm.sh)
  - Etcd cluster

To install the chart with the release name `discoveryserver` in the namespace `discoveryserver`:

```console
$ helm upgrade discoveryserver . --install --namespace discoveryserver -f dev.values.yaml --debug
```

The command deploys discoveryserver on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `discoveryserver` deployment:

```console
$ helm uninstall discoveryserver -n discoveryserver
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the discoveryserver chart and their default values.

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `global.imagePullSecrets` | Reference to one or more secrets to be used when pulling images | `[]` |
| `image.repository` | Image repository | `gcr.io/etcd-io-dev/discoveryserver` |
| `image.tag` | Image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `Always` |
| `replicaCount`  | Number of discoveryserver replicas  | `3` |
| `serviceAccount.create` | If `true`, create a new service account | `true` |
| `serviceAccount.name` | Service account to be used. If not set and `serviceAccount.create` is `true`, a name is generated using the fullname template | "" |
| `resources` | CPU/memory resource requests/limits | |
| `securityContext.allowPrivilegeEscalation` | Controls whether a process can gain more privileges than its parent process | `false` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `affinity` |  Constrains which nodes pods are eligible to be scheduled on | [See values](https://github.com/etcd-io/discovery.etcd.io/tree/master/kubernetes/helm/discoveryserver/dev.values.yaml) |
| `minReadySeconds` | How many seconds a pod needs to be ready before killing the next, during update | `5` |
| `strategy.type` | Rollout strategy type | `rollingUpdate` |
| `strategy.rollingUpdate.maxSurge` | Specifies the maximum number of Pods that can be created over the desired number of Pods | `1` |
| `strategy.rollingUpdate.maxUnavailable` | Specifies the maximum number of Pods that can be unavailable during the update process | `1` |
| `metrics.enabled`| Enable metrics scraped by prometheus | `true` |
| `metrics.serviceMonitor.enabled` | Enables the target to be monitored by Prometheus | `true` |
| `metrics.serviceMonitor.additionalLabels` | Additional labels that can be used so ServiceMonitor will be discovered by Prometheus | `{}` |
| `ingress.enabled` | Enable ingress controller resource | `true` |
| `ingress.annotations` | Specify ingress class | `kubernetes.io/ingress.class: nginx` |
| `ingress.hosts.host` | Discoveryserver hostnames | `true` |
| `ingress.hosts.paths` | Paths to match against incoming requests. | `[/]` |
| `ingress.tls.secretNames` | Secret's name where SSL/TLS certificate will be stored. | `discoveryserver-tls` |
| `ingress.tls.hosts` | Hosts for which SSL/TLS certificate must be issued. | `["discovery.etcd.io", "www.discovery.etcd.io"]` |
| `ingress.tls.hosts` | Hosts for which SSL/TLS certificate must be issued. | `["discovery.etcd.io", "www.discovery.etcd.io"]` |
| `environment` | List of environment variables required by the discoveryserver service container.  | [See values](https://github.com/etcd-io/discovery.etcd.io/tree/master/kubernetes/helm/discoveryserver/dev.values.yaml#L31-#L37) |


