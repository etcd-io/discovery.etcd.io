# Prometheus Operator
Installs prometheus, grafana, and alertmanager
Reference: https://github.com/helm/charts/tree/master/stable/prometheus-operator#prometheus-operator

## Alerts
Alerts are handled by alertmanager. To configure, add edit the `alertmanager` section in the values.yaml file. 
Reference: https://github.com/helm/charts/tree/master/stable/prometheus-operator#alertmanager 

## Authentication
For Grafana, we are using it's built-in authentication: https://grafana.com/docs/grafana/latest/auth/overview/ ,
and for alertmanager and prometheus, we are using Basic auth at the Nginx Ingress level.

`example.secrets.yaml` contains all necessary secrets to deploy this chart.
Please copy it, and update the values accordingly
```console
$ cp example.secrets.yaml <env>.secrets.yaml
```

## Setup Grafana auth
The simplest setup would be to set the `prometheus-operator.grafana.adminPassword` to some value.
This can be done by copying `example.secrets.yaml`

## Setup Basic Auth:
Slack api credentials, google auth tokens, etc.

Reference: https://kubernetes.github.io/ingress-nginx/examples/auth/basic/
Encrypt the password
```console
$ htpasswd -c <env>-auth <username>
New password: <pwd>
New password:
Re-type new password:
Adding password for user <username>
```

Create a Kubernetes Secret from the file contents. The Kubernetes Ingress will look for the value in the `<env>-auth` key.
```console
# <env>.secrets.yaml
secrets:
  auth: "<username>:<encrypted-pwd>"
```
and then update the `<env>.secrets.yaml` file you created.

## Install or Upgrade
`$ ./deploy.sh <env>`

