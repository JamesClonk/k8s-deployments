#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# status
kapp app-change list -a wireguard
kapp inspect -a wireguard --tree
