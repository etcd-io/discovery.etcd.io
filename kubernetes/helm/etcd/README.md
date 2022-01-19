The discoveryserver etcd cluster uses the bitnami etcd helm chart

https://artifacthub.io/packages/helm/bitnami/etcd

# Install/Upgrade
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
# Install
helm install etcd bitnami/etcd --version 6.12.2 --namespace discoveryserver --f values.yaml
# Upgrade
helm upgrade etcd bitnami/etcd --version 6.12.2 --namespace discoveryserver --debug -f values.yaml
```
