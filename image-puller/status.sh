#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# status
kapp app-change list -a image-puller
kapp inspect -a image-puller --tree
