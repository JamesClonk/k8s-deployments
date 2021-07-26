#!/bin/bash
source $(dirname ${BASH_SOURCE[0]})/.env* 1>/dev/null 2>&1 || true # source any hidden env config files if available

########################################################################################################################
####### kubernetes #####################################################################################################
########################################################################################################################
export KUBECONFIG="$HOME/.kube/k8s-deployments"
########################################################################################################################
