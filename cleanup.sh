#!/bin/bash
set -e
set -u
source $(dirname ${BASH_SOURCE[0]})/env.sh # source env configuration files

# $HOME/.ssh
echo "removing writing [$HOME/.ssh/id_rsa] ..."
rm -f "$HOME/.ssh/id_rsa" || true

# aws config
echo "removing writing [$HOME/.aws/config] ..."
rm -f "$HOME/.aws/config" || true
echo "removing writing [$HOME/.aws/credentials] ..."
rm -f "$HOME/.aws/credentials" || true

# kubectl config
echo "removing writing [${KUBECONFIG}] ..."
rm -f "${KUBECONFIG}" || true
