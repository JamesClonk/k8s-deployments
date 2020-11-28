#!/bin/bash
set -e
set -u
source ../setup.sh

# diff
kapp app-change list -a image-puller
cat values.yml |
	envsubst -no-unset -no-empty |
	ytt --ignore-unknown-comments -f templates -f - |
	kbld -f - -f image.lock.yml |
	kapp deploy -a image-puller -c --diff-run -f -
