set -xe
env=$1

helm3 upgrade discoveryserver . \
        --debug --install --atomic --wait \
        --timeout 300s \
        --namespace discoveryserver \
        --values $env.values.yaml
