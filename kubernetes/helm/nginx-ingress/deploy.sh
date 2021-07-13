#!/usr/bin/env bash

helm upgrade nginx-ingress stable/nginx-ingress --install --create-namespace --namespace nginx-ingress -f values.yaml --version 1.29.6 --atomic --debug