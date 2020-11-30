#!/bin/bash
set -e
set -u
source ../setup.sh

# deploy
echo "deploying [irvisualizer] ..."
cat values.yml |
	envsubst -no-unset -no-empty |
	ytt --ignore-unknown-comments -f templates -f - |
	kbld -f - -f image.lock.yml |
	kapp deploy -a irvisualizer -c -y -f -
kapp app-change garbage-collect -a irvisualizer --max 5 -y
