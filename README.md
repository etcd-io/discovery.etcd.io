## discovery.etcd.io Kubernetes Configurations

This repo contains the code to provision the infrastructure and the Kubernetes configurations to operate the public discovery.etcd.io service.

## Requirements

  * **Helm**  ~> v3.0.0 - Install latest [version](https://github.com/helm/helm/releases) for your OS.
  * **Terraform ~> v0.12.15**  Please [download](https://www.terraform.io/downloads.html) the proper package for your operating system and architecture.

## Building the infrastructure

The infrastructure is built using cloudkite [terraform modules](https://github.com/cloudkite-io/terraform-modules), which are used to provision infrastructure in Google Cloud Platform.
The following modules have been used:

* [vpc](https://github.com/cloudkite-io/terraform-modules/tree/master/modules/gcp/vpc): The vpc module contains Terraform code 
  to provision a GCP Virtual Private Cloud. See [VPC docs](https://cloud.google.com/vpc/docs/).

* [gke](https://github.com/cloudkite-io/terraform-modules/tree/master/modules/gcp/gke): The folder contains Terraform code to deploy a GKE Private Cluster.

### Provisioning a VPC and deploying a GKE cluster per environment

The infrastructure main code is created per environment, and there are two environments:
* [dev](https://github.com/etcd-io/discovery.etcd.io/tree/master/terraform/dev)
* [prod](https://github.com/etcd-io/discovery.etcd.io/tree/master/terraform/prod)

Terraform modules are used within each environment. See `dev` or `prod` [`main.tf`](https://github.com/etcd-io/discovery.etcd.io/blob/master/terraform/dev/main.tf) configuration file

Next step is to apply Terraform for the chosen environment. To ensure that it is configured correctly, apply it and get the expected output, go to the project's [terraform folder](https://github.com/etcd-io/discovery.etcd.io/tree/master/terraform)
and follow the [README](https://github.com/etcd-io/discovery.etcd.io/blob/master/terraform/README.md) instructions.

After applying terraform, a GKE cluster will be up and running in the VPC created. Now the cluster is ready to get deployments.

## Install Releases with Helm

To get the public discovery service running, the following releases have to be installed:

* [Nginx Ingress Controller](https://github.com/etcd-io/discovery.etcd.io/tree/master/kubernetes/helm/nginx-ingress): Used for routing 
traffic from beyond the cluster to internal Kubernetes Services. To install follow instructions in [README](https://github.com/etcd-io/discovery.etcd.io/blob/master/kubernetes/helm/nginx-ingress/README.md).
* [certmanager](https://github.com/etcd-io/discovery.etcd.io/tree/master/terraform/prod): Is the TLS/SSL certificate management controller, and to
get it deployed follow the [README](https://github.com/etcd-io/discovery.etcd.io/blob/master/kubernetes/helm/cert-manager/README.md).
* [prometheus-operator](https://github.com/etcd-io/discovery.etcd.io/tree/master/terraform/dev): Used to create/configure/manage Prometheus clusters atop Kubernetes. To install this operator use the instructions [here](https://github.com/etcd-io/discovery.etcd.io/blob/master/kubernetes/helm/prometheus/README.md).
* [etcd-operator](https://github.com/etcd-io/discovery.etcd.io/tree/master/terraform/prod): Is used to configure and manage etcd clusters. This is a
pre-requisite to have configured properly the discoveryserver release. To install it follow instructions in [README](https://github.com/etcd-io/discovery.etcd.io/blob/master/kubernetes/helm/etcd-operator/README.md).
* [discoveryserver](https://github.com/etcd-io/discovery.etcd.io/tree/master/terraform/prod): Is a service that bootstrap new etcd clusters using an existing one.
This service helps when the IPs of your cluster peers are not known ahead of time. To install the release follow instructions in [README](https://github.com/etcd-io/discovery.etcd.io/blob/master/kubernetes/helm/discoveryserver/README.md).

![block diagram of architecture](img/arch.svg)

## Debugging

**Hit the discovery service via kubectl proxy**

```
kubectl proxy
curl http://localhost:8001/api/v1/namespaces/default/services/discoveryserver/proxy/new
```

**Execute etcdctl on the cluster**

```
kubectl exec -it $(kubectl get pods -l app=etcd -o jsonpath='{.items[0].metadata.name}')  -- /usr/local/bin/etcdctl watch '' --prefix
```

**Access prometheus**

Ensure prometheus's externalURL is set to the right path

```
kubectl edit prometheus prometheus-operator-prometheus
```

```
kubectl proxy
```

Visit http://localhost:8001/api/v1/namespaces/default/services/prometheus-operated:web/proxy
