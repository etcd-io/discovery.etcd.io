#!/usr/bin/env bash
app=version-checker
env=$1

helm upgrade --atomic --debug --install --create-namespace --timeout 900s --namespace prometheus --values $env.values.yaml $app .