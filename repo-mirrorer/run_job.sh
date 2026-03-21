#!/bin/bash
set -e
set -u
set -o pipefail
source ../setup.sh

# run
echo "run job [repo-mirrorer] ..."
sops -d ../secrets.sops |
	ytt --ignore-unknown-comments -f templates -f values.yaml -f run_job.yaml -f ../configuration.yaml -f - |
	kbld -f - -f image.lock.yaml |
	kapp deploy -a repo-mirrorer -c -y -f -
