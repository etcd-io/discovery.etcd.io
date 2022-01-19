#!/usr/bin/env bash
app=kube-prometheus-stack
env=$1

helm upgrade --atomic --debug --install --create-namespace --timeout 900s --namespace prometheus --values values.yaml,$env.values.yaml,$env.secrets.yaml $app .