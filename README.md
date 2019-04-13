## discovery.etcd.io Kubernetes Configurations

This repo contains the Kubernetes configurations to operate the public discovery.etcd.io service.

## Debugging

Hit the discovery service via kubectl proxy

```
kubectl proxy
curl http://localhost:8001/api/v1/namespaces/default/services/discoveryserver/proxy/new
```

Execute etcdctl on the cluster

```
kubectl exec -it $(kubectl get pods -l app=etcd -o jsonpath='{.items[0].metadata.name}')  -- /usr/local/bin/etcdctl watch '' --prefix
```