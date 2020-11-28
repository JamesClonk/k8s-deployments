#!/bin/bash
set -e
set -u
source ../setup.sh

# deploy
echo "deploying [kuard] ..."
cat values.yml |
	envsubst -no-unset -no-empty |
	ytt --ignore-unknown-comments -f templates -f - |
	kbld -f - -f image.lock.yml |
	kapp deploy -a kuard -c -y -f -
kapp app-change garbage-collect -a kuard --max 5 -y
