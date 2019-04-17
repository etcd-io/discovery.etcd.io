## discovery.etcd.io Kubernetes Configurations

This repo contains the Kubernetes configurations to operate the public discovery.etcd.io service.

## Install

Everything should come up with minor customizations. See `discoveryserver-ingress.yaml` and `discoveryserver-certificates.yaml` for hostname customizations.

```
kubectl apply -f etcd-operator/rendered.yaml
kubectl apply -f prometheus/rendered.yaml
for i in *.yaml; do kubectl apply -f $i; done
```

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

Visit http://localhost:8001/api/v1/namespaces/default/services/prometheus-operated:web/proxy/graph
