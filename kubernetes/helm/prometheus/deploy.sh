env=$1
version="8.3.3"

helm3 upgrade prometheus-operator . \
        --install --debug --atomic \
        --timeout 2m \
        --namespace prometheus \
        --version $version \
        --values values.yaml,$env.values.yaml
