#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# status
kapp app-change list -a item-monitor
kapp inspect -a item-monitor --tree
