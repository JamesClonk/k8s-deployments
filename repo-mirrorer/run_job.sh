#!/bin/bash
set -e
set -u
source ../setup.sh

# run
echo "run job [repo-mirrorer] ..."
sops -d ../secrets.sops |
	ytt --ignore-unknown-comments -f templates -f values.yml -f run_job.yml -f ../configuration.yml -f - |
	kbld -f - -f image.lock.yml |
	kapp deploy -a repo-mirrorer -c -y -f -
