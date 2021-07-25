#!/bin/bash
set -e
set -u
source $(dirname ${BASH_SOURCE[0]})/env.sh # source env configuration files

# $HOME/.ssh
rm -f "$HOME/.ssh/id_rsa" || true

# aws config
rm -f "$HOME/.aws/config" || true
rm -f "$HOME/.aws/credentials" || true

# kubectl config
rm -f "${KUBECONFIG}" || true
