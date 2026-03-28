#!/bin/bash
set -e
set -u
set -o pipefail
source $(dirname ${BASH_SOURCE[0]})/setup.sh

echo ""
echo "displaying cluster information ..."
kubectl cluster-info || true
kubectl get ns || true

# list apps
echo ""
echo "displaying all apps ..."
kapp version
kapp list -A
