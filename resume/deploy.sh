#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# deploy
echo "deploying [resume] ..."
sops -d ../secrets.sops |
	ytt --ignore-unknown-comments -f templates -f values.yaml -f ../configuration.yaml -f - |
	kbld -f - -f image.lock.yaml |
	kapp deploy -a resume -c -y -f -
kapp app-change garbage-collect -a resume --max 5 -y
