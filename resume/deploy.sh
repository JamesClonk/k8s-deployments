#!/bin/bash
set -e
set -u
source ../setup.sh

# deploy
echo "deploying [resume] ..."
sops -d ../secrets.sops |
	ytt --ignore-unknown-comments -f templates -f values.yml -f ../configuration.yml -f - |
	kbld -f - -f image.lock.yml |
	kapp deploy -a resume -c -y -f -
kapp app-change garbage-collect -a resume --max 5 -y
