#!/bin/bash
set -e
set -u
source ../setup.sh

# deploy
echo "deploying [home-info] ..."
cat values.yml |
	envsubst -no-unset -no-empty |
	ytt --ignore-unknown-comments -f templates -f - |
	kbld -f - -f image.lock.yml |
	kapp deploy -a home-info -c -y -f -
kapp app-change garbage-collect -a home-info --max 5 -y
