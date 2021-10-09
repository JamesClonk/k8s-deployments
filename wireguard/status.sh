#!/bin/bash
set -e
set -u
source ../setup.sh

# status
kapp app-change list -a wireguard
kapp inspect -a wireguard --tree
