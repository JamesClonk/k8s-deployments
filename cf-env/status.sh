#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# status
kapp app-change list -a cf-env
kapp inspect -a cf-env --tree
