#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# diff
kapp app-change list -a pgweb
sops -d ../secrets.sops |
	ytt --ignore-unknown-comments -f templates -f values.yaml -f ../configuration.yaml -f - |
	kbld -f - -f image.lock.yaml |
	kapp deploy -a pgweb -c --diff-run -f -
