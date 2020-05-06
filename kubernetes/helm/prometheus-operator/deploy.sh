#!/usr/bin/env bash
app=prometheus-operator
env=$1

helm3 upgrade --atomic --debug --install --namespace prometheus --values values.yaml,$env.values.yaml,$env.secrets.yaml $app .
