# TODO

- switch all templating & secrets management to `plato`
	- dont plato-render secrets into helm chart values.yamls, since helm chart output gets stored in git
	- all helm chart dependencies need to be accounted for and mirrored/vendired too! No internet!
	- get rid of ytt secrets loading, render secrets instead directly in ytt yamls
	- get rid of env var secrets load, render secrets instead directly in shellscripts
	- yaml-encrypted secrets.yaml, instead of binary-encrypted .sops file
	- deployments migrated:
		- backman
		- cf-env
		- home-info
		- image-puller
		- irvisualizer
		- item-monitor
		- jcio
		- minecraft
		- pgweb
		- repo-mirrorer
		- resume
		- wireguard

- migrate all ytt "values.yml" to "values.yaml" (needs a change to all shellscripts which interact with ytt)
- migrate all kbld "image.lock.yml" to "image.lock.yaml" (needs a change to all shellscripts which interact with kbld)

- update deployments (from .yml to .yaml, add httproute.yaml, update network_policy.yaml for envoy-gateway):
		- backman
		- ~cf-env~
		- home-info
		- image-puller
		- irvisualizer
		- item-monitor
		- jcio
		- ~minecraft~
		- ~pgweb~
		- ~repo-mirrorer~
		- ~resume~
		- ~wireguard~

- go through all remaining "# TODO:" comments

- go through image-puller and update all necessary values / sha-checksums / etc..
	- also get the ones from image-lock files of k8s-infrastructure!
