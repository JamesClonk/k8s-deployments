#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# status
kapp app-change list -a repo-mirrorer
kapp inspect -a repo-mirrorer --tree
