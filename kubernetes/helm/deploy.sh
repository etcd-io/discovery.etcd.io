#!/bin/bash

### Source this script and set these values:
#SERVICE=
#NAMESPACE=
#CHART=
#VERSION=

function select_env() {
  env_values=( *.values.yaml )
  select env in "${env_values[@]}"; do
    if [ -f "${env}" ]; then
      echo "${env}" | cut -f 1 -d .
      break
    fi
  done
}

function verify() {
  local env="${1}"
  printf "\nYour current kubecontext: $(kubectl config current-context)\n"
  printf "Chosen env values file: ${env}.values.yaml\n"
  read -r -p "Do you wish to continue deployment? [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY]) 
      true
      ;;
    *)
      exit 1
      ;;
  esac
}

function create_ns() {
  kubectl get ns ${NAMESPACE}
  if [ $? -eq 1 ]; then 
    echo "Creating namespace ${NAMESPACE}..."
    kubectl create ns ${NAMESPACE}
  fi
}

function do_helm_upgrade() {
  local env="${1}"
  if [ -f "${env}".secrets.yaml ]; then
      helm upgrade ${SERVICE} ${CHART} --atomic --timeout 900s --version ${VERSION} --install --namespace ${NAMESPACE} -f $env.values.yaml -f $env.secrets.yaml
  else
      helm upgrade ${SERVICE} ${CHART} --atomic --timeout 900s --version ${VERSION} --install --namespace ${NAMESPACE} -f $env.values.yaml
  fi
  if [ $? != 0 ]; then
    echo "Error. Exiting."
    exit 1
  fi
}

function apply_patches() {
  printf "\nApplying post-helm patches...\n"
  if [ -d ./patches ]; then
    for patch in ./patches/*.sh; do
      bash $patch
    done
  fi
}

function main() {
  printf "\nChoose the helm values that matches your kube context:\n"
  selected_env=$(select_env)
  verify ${selected_env}
  create_ns
  do_helm_upgrade ${selected_env}
  apply_patches
}
