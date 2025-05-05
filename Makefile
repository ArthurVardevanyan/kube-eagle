
WORKSPACE_RESULTS_PATH ?= /tmp/image
export KO_DOCKER_REPO=registry.arthurvardevanyan.com/homelab/kube-eagle
# https://catalog.redhat.com/software/containers/ubi9-minimal/61832888c0d15aff4912fe0d?image=67625f2743160d79ae9c717e&container-tabs=overview
# No MultiArch SHA Currently Present
export KO_DEFAULTBASEIMAGE=registry.access.redhat.com/ubi9-minimal:9.5-1745855087
TAG ?= $(shell date --utc '+%Y%m%d-%H%M')
EXPIRE ?= 26w

.PHONY: ko-build-pipeline
ko-build-pipeline:
	ko build --platform=linux/amd64,linux/arm64 --bare --sbom none --image-label quay.expires-after="${EXPIRE}" --tags "${TAG}"
	echo "${KO_DOCKER_REPO}:${TAG}" > "${WORKSPACE_RESULTS_PATH}"
