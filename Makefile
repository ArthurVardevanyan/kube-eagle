TAG ?= $(shell date --utc '+"%Y.%m.%d.%H%M%S"'-local)
EXPIRE ?= 26w
WORKSPACE_RESULTS_PATH ?= /tmp/image
# Image URL to use all building/pushing image targets
IMG ?= registry.arthurvardevanyan.com/homelab/kube-eagle:$(TAG)
export KO_DOCKER_REPO=$(shell echo $(IMG) | cut -d: -f1)
# https://catalog.redhat.com/software/containers/ubi9/ubi-micro/615bdf943f6014fa45ae1b58?architecture=amd64&image=662a8edd22c80ead7411ec6c&container-tabs=overview
export KO_DEFAULTBASEIMAGE=cgr.dev/chainguard/static

.PHONY: ko-build-pipeline
ko-build-pipeline:
	ko build --platform=linux/amd64,linux/arm64 --bare --sbom none --image-label quay.expires-after="${EXPIRE}" --tags "${TAG}"
	echo "${KO_DOCKER_REPO}:${TAG}" > "${WORKSPACE_RESULTS_PATH}"
