#!/bin/bash
set -e
set -u
source ../setup.sh

# deploy
echo "deploying [repo-mirrorer] ..."
cat values.yml |
	envsubst -no-unset -no-empty |
	ytt --ignore-unknown-comments -f templates -f - |
	kbld -f - -f image.lock.yml |
	kapp deploy -a repo-mirrorer -c -y -f -
kapp app-change garbage-collect -a repo-mirrorer --max 5 -y
