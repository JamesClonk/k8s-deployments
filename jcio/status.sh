#!/bin/bash
set -e
set -u
source ../setup.sh

# status
kapp app-change list -a jcio
kapp inspect -a jcio --tree
