#!/bin/bash
set -e
set -u
set -o pipefail
source $(dirname ${BASH_SOURCE[0]})/.env* 1>/dev/null 2>&1 || true # source any hidden env config files if available

########################################################################################################################
# environment configuration
########################################################################################################################
export CONFIGURATION_FILE="$(dirname ${BASH_SOURCE[0]})/configuration.yml"
export SECRETS_FILE="$(dirname ${BASH_SOURCE[0]})/secrets.sops"
export KUBECONFIG="$HOME/.kube/k8s-deployments"

########################################################################################################################
# helper functions
########################################################################################################################
function basic_auth() {
	local -r username="$1"
	shift
	local -r password="$1"
	shift
	echo "${username}:$(openssl passwd -apr1 \"${password}\")"
}

function retry() {
	local -r -i max_attempts="$1"
	shift
	local -r -i sleep_time="$1"
	shift
	local -i attempt_num=1
	until "$@"; do
		if ((attempt_num == max_attempts)); then
			echo "#$attempt_num failures!"
			exit 1
		else
			echo "#$((attempt_num++)): trying again in $sleep_time seconds ..."
			sleep $sleep_time
		fi
	done
}

function install_tool {
	local -r tool_name="$1"
	shift
	local -r tool_url="$1"
	shift
	local -r tool_checksum="$1"
	shift
	if [ ! -f "$HOME/bin/${tool_name}" ]; then
		echo "downloading [${tool_name}] ..."
		wget -q "${tool_url}" -O "$HOME/bin/${tool_name}" 2>/dev/null
		chmod +x "$HOME/bin/${tool_name}"
	fi
	sha256sum "$HOME/bin/${tool_name}" | grep "${tool_checksum}" >/dev/null || (echo "checksum failed for [${tool_name}]" && rm -f "$HOME/bin/${tool_name}" && exit 1)
}

function install_tool_from_tarball {
	local -r tool_path="$1"
	shift
	local -r tool_name="$1"
	shift
	local -r tool_url="$1"
	shift
	local -r tool_checksum="$1"
	shift
	if [ ! -f "$HOME/bin/${tool_name}" ]; then
		echo "downloading [${tool_name}] ..."
		wget -q "${tool_url}" -O "$HOME/bin/${tool_name}.tgz" 2>/dev/null
		echo "unpacking [${tool_name}.tgz] ..."
		STRIP_COMPONENTS=$(echo "${tool_path}" | awk -F"/" '{print NF-1}')
		tar -xvzf "$HOME/bin/${tool_name}.tgz" --strip-components=${STRIP_COMPONENTS} -C "$HOME/bin/" "${tool_path}" >/dev/null
		chmod +x "$HOME/bin/${tool_name}"
		rm -f "$HOME/bin/${tool_name}.tgz"
	fi
	sha256sum "$HOME/bin/${tool_name}" | grep "${tool_checksum}" >/dev/null || (echo "checksum failed for [${tool_name}]" && rm -f "$HOME/bin/${tool_name}" && exit 1)
}

########################################################################################################################
# $HOME/bin
########################################################################################################################
if [ ! -d "$HOME/bin" ]; then mkdir "$HOME/bin"; fi
export PATH="$HOME/bin:$PATH"

########################################################################################################################
# install tools
########################################################################################################################
install_tool "sops" "https://github.com/mozilla/sops/releases/download/v3.9.1/sops-v3.9.1.linux.amd64" "cd795109851c3a483bbaa66d15d19ddb2227ac0352b39e25d96b67d51edb6225"
install_tool "kubectl" "https://storage.googleapis.com/kubernetes-release/release/v1.25.8/bin/linux/amd64/kubectl" "80e70448455f3d19c3cb49bd6ff6fc913677f4f240d368fa2b9f0d400c8cd16e"
install_tool "kapp" "https://github.com/vmware-tanzu/carvel-kapp/releases/download/v0.46.0/kapp-linux-amd64" "130f648cd921761b61bb03d7a0f535d1eea26e0b5fc60e2839af73f4ea98e22f"
install_tool "ytt" "https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.40.1/ytt-linux-amd64" "11222665c627b8f0a1443534a3dde3c9b3aac08b322d28e91f0e011e3aeb7df5"
install_tool "vendir" "https://github.com/vmware-tanzu/carvel-vendir/releases/download/v0.26.0/vendir-linux-amd64" "98057bf90e09972f156d1c4fbde350e94133bbaf2e25818b007759f5e9c8b197"
install_tool "kbld" "https://github.com/vmware-tanzu/carvel-kbld/releases/download/v0.32.0/kbld-linux-amd64" "de546ac46599e981c20ad74cd2deedf2b0f52458885d00b46b759eddb917351a"
install_tool "imgpkg" "https://github.com/vmware-tanzu/carvel-imgpkg/releases/download/v0.25.0/imgpkg-linux-amd64" "14ce0b48a3a00352cdf0ef263aa98a9bcd90d5ea8634fdf6b88016e2a08f09d1"
install_tool "yq" "https://github.com/mikefarah/yq/releases/download/v4.21.1/yq_linux_amd64" "50778261e24c70545a3ff8624df8b67baaff11f759e6e8b2e4c9c781df7ea8dc"
install_tool "jq" "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" "af986793a515d500ab2d35f8d2aecd656e764504b789b66d7e1a0b727a124c44"
install_tool "kind" "https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64" "949f81b3c30ca03a3d4effdecda04f100fa3edc07a28b19400f72ede7c5f0491"
install_tool_from_tarball "cmctl" "cmctl" "https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cmctl-linux-amd64.tar.gz" "6e22fda56e0fa62cb3fab9340be23ba3fa0da341e737006a9552abdcc80c789e"
install_tool_from_tarball "hcloud" "hcloud" "https://github.com/hetznercloud/cli/releases/download/v1.30.3/hcloud-linux-amd64.tar.gz" "0e6c2c1bf8be9747059c811004ba37bba884b4b194d8f3e0262cbab6c1c0e339"
install_tool_from_tarball "linux-amd64/helm" "helm" "https://get.helm.sh/helm-v3.10.3-linux-amd64.tar.gz" "cc5223b23fd2ccdf4c80eda0acac7a6a5c8cdb81c5b538240e85fe97aa5bc3fb"
install_tool_from_tarball "age/age" "age" "https://github.com/FiloSottile/age/releases/download/v1.1.1/age-v1.1.1-linux-amd64.tar.gz" "0c6ddc31c276f55e9414fe27af4aada4579ce2fb824c1ec3f207873a77a49752"
install_tool_from_tarball "age/age-keygen" "age-keygen" "https://github.com/FiloSottile/age/releases/download/v1.1.1/age-v1.1.1-linux-amd64.tar.gz" "e279f64ccd11347e57b8d28304e3e358ae1a5ef4f19107e7a1f9c9156fdcad91"

########################################################################################################################
# git config
########################################################################################################################
git config --local core.hooksPath .githooks/
git config --local diff.sopsdiffer.textconv "sops -d"

########################################################################################################################
# $HOME/.ssh
########################################################################################################################
if [ ! -d "$HOME/.ssh" ]; then mkdir "$HOME/.ssh"; fi
chmod 700 "$HOME/.ssh" || true
set +u
if [ ! -z "${HETZNER_PRIVATE_SSH_KEY}" ]; then
	cat >"$HOME/.ssh/id_rsa" <<EOF
${HETZNER_PRIVATE_SSH_KEY}
EOF
	chmod 600 "$HOME/.ssh/id_rsa"
fi
set -u
set -o pipefail

########################################################################################################################
# kubectl config
########################################################################################################################
if [ ! -d "$HOME/.kube" ]; then mkdir "$HOME/.kube"; fi
chmod 700 "$HOME/.kube" || true
set +u
if [ ! -f "${KUBECONFIG}" ]; then
	echo "writing [${KUBECONFIG}] ..."
	sops -d $(dirname ${BASH_SOURCE[0]})/kubeconfig.sops >"${KUBECONFIG}"
	chmod 600 "${KUBECONFIG}"
fi
set -u
set -o pipefail
