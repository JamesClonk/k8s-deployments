#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# status
kapp app-change list -a syncthing
kapp inspect -a syncthing --tree
