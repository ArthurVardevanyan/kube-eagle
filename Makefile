
export KO_DOCKER_REPO=registry.arthurvardevanyan.com/homelab/kube-eagle
# https://catalog.redhat.com/software/containers/ubi9/ubi-micro/615bdf943f6014fa45ae1b58?architecture=amd64&image=662a8edd22c80ead7411ec6c&container-tabs=overview
export KO_DEFAULTBASEIMAGE=registry.access.redhat.com/ubi9-minimal:9.4-1194
TAG ?= $(shell date --utc '+%Y%m%d-%H%M')
EXPIRE ?= 26w

.PHONY: ko-build-pipeline
ko-build-pipeline:
	ko build --platform=linux/amd64,linux/arm64 --bare --sbom none --image-label quay.expires-after="${EXPIRE}" --tags "${TAG}"
