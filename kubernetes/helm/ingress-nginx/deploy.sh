#!/usr/bin/env bash

helm upgrade ingress-nginx ingress-nginx/ingress-nginx --install --create-namespace --namespace ingress-nginx -f values.yaml --version 3.35.0 --atomic --debug