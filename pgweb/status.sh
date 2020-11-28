#!/bin/bash
set -e
set -u
source ../setup.sh

# status
kapp app-change list -a pgweb
kapp inspect -a pgweb --tree
