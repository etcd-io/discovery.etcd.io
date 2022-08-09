#!/usr/bin/env bash
env=$1
version=2.30.2

helm upgrade velero vmware-tanzu/velero --install --create-namespace --namespace velero -f ${env}.values.yaml --version ${version} --atomic --debug