#!/usr/bin/env bash
env=$1
version=3.1.2

helm upgrade velero vmware-tanzu/velero --install --create-namespace --namespace velero -f ${env}.values.yaml --version ${version} --atomic --debug