#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# diff
kapp app-change list -a backman
sops -d ../secrets.sops |
	ytt --ignore-unknown-comments -f templates -f values.yaml -f ../configuration.yaml -f - |
	kbld -f - -f image.lock.yaml |
	kapp deploy -a backman -c --diff-run -f -
