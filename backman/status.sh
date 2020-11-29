#!/bin/bash
set -e
set -u
source ../setup.sh

# status
kapp app-change list -a backman
kapp inspect -a backman --tree
