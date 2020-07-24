#!/bin/bash
#
# MIT License
#
# Copyright (c) 2020 Cloudkite.io
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

### Usage ###
# In a deployment bash script, source this script and set these values,
# and run the main function:
#
#SERVICE=
#NAMESPACE=
#CHART=
#VERSION=
#
#main

function select_env() {
  env_values=( *values.yaml )
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
  if [ -f values.yaml ]; then
    printf "Chosen env values file: values.yaml\n"
  else
    printf "Chosen env values file: ${env}.values.yaml\n"
  fi
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
  local values_files=""

  if [ -f values.yaml ]; then
      values_files="values.yaml"
  elif [ -f "${env}".secrets.yaml ]; then
      values_files="${values_files},${env}.values.yaml,${env}.secrets.yaml"
  else
      values_files="${values_files},${env}.values.yaml"
  fi

  helm upgrade ${SERVICE} ${CHART} --atomic --timeout 900s --version ${VERSION} --install --namespace ${NAMESPACE} -f ${values_files}

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