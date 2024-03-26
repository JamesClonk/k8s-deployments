#!/bin/bash
set -e
set -u
set -o pipefail
source setup.sh

########################################################################################################################
# deployments
########################################################################################################################
deployments=(
	# demo/test apps
	"cf-env"
	# "kuard"
	"resume"

	# what's my db up to?
	"pgweb"

	# all your backups are belong to us!
	"backman"

	# actual useful apps go here..
	"jcio"
	"home-info"
	"irvisualizer"

	# # put my files into the clouds!
	# "syncthing"

	# # building stuff with blocks..
	# "minecraft"

	# # monitor stuff on websites..
	"item-monitor"

	# also some cronjobs for good fun..
	"image-puller"
	"repo-mirrorer"
)

########################################################################################################################
# deploy it all, all of it!
########################################################################################################################
for deployment in ${deployments[@]}; do
	pushd $deployment
	./deploy.sh
	popd
	echo -e "\n\n"
done
kapp list
echo " "
