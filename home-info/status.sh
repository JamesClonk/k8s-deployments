#!/bin/bash
set -e
set -u
source ../setup.sh

# status
kapp app-change list -a home-info
kapp inspect -a home-info --tree
