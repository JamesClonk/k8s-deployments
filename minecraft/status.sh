#!/bin/bash
set -e
set -u
source ../setup.sh

# status
kapp app-change list -a minecraft
kapp inspect -a minecraft --tree
