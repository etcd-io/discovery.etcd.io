Getting started:
Must have helm 3 installed.

Upgrade/Installation:
```bash
$ export version=8.1.6 
$ helm upgrade prometheus-operator kubernetes/prometheus-operator \
        --install \
        --version $version --namespace prometheus \
```
