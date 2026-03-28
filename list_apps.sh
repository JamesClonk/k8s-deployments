#!/bin/bash
set -e
set -u
set -o pipefail
source $(dirname ${BASH_SOURCE[0]})/setup.sh

# list apps
echo "displaying all apps ..."
echo ${KUBECONFIG} || true
kubectl cluster-info || true
kubectl get ns || true
kapp list
