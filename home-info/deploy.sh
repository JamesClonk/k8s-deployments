#!/bin/bash
set -e
set -u
source ../setup.sh

# deploy
echo "deploying [home-info] ..."
sops -d ../secrets.sops |
	ytt --ignore-unknown-comments -f templates -f values.yml -f ../configuration.yml -f - |
	kbld -f - -f image.lock.yml |
	kapp deploy -a home-info -c -y -f -
kapp app-change garbage-collect -a home-info --max 5 -y
