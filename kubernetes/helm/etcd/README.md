The discoveryserver etcd cluster uses the bitnami etcd helm chart

https://artifacthub.io/packages/helm/bitnami/etcd

# Install/Upgrade
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install etcd bitnami/etcd -f values.yaml
```
