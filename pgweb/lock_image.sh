#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# lock image
echo "locking images for [pgweb] ..."
sops -d ../secrets.sops |
	ytt --ignore-unknown-comments -f templates -f values.yml -f ../configuration.yml -f - |
	kbld -f - --lock-output "image.lock.yml"
