#!/usr/bin/env bash
env=$1
version=2.23.1

helm upgrade ingress-nginx ingress-nginx/ingress-nginx --install --create-namespace --namespace velero -f ${env}.values.yaml --version ${version} --atomic --debug