#!/bin/bash
set -e
set -u
source ../setup.sh

# status
kapp app-change list -a syncthing
kapp inspect -a syncthing --tree
