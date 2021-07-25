#!/bin/bash
set -e
set -u
source ../setup.sh

# deploy
echo "deploying [image-puller] ..."
sops -d ../secrets.sops |
	ytt --ignore-unknown-comments -f templates -f values.yml -f ../configuration.yml -f - |
	kbld -f - -f image.lock.yml |
	kapp deploy -a image-puller -c -y -f -
kapp app-change garbage-collect -a image-puller --max 5 -y
