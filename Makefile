GDAL_VERSION ?= 3.6.2
PYTHON_VERSION ?= 3.11
DOCKER_REPO ?= vodka/python-gdal-trixie
IMAGE ?= $(DOCKER_REPO):py$(PYTHON_VERSION)-gdal$(GDAL_VERSION)
PLATFORMS ?= linux/amd64,linux/arm64

BUILD_ARGS = \
	--build-arg GDAL_VERSION=$(GDAL_VERSION) \
	--build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
	-t $(IMAGE) .

# Run once per machine: qemu emulation + a builder that can do multi-platform.
setup-buildx:
	docker run --privileged --rm tonistiigi/binfmt --install arm64
	docker buildx create --name python-gdal --use --bootstrap || docker buildx use python-gdal

image:
	docker buildx build --platform $(PLATFORMS) $(BUILD_ARGS)

# Multi-platform images can't be loaded into the local docker image store,
# so testing builds the native arch only.
image-local:
	docker buildx build --load $(BUILD_ARGS)

test: image-local
	docker run --rm $(IMAGE)

lint:
	docker run \
		--rm \
		-v `pwd`/.dockerfilelintrc:/.dockerfilelintrc \
		-v `pwd`/Dockerfile:/Dockerfile \
		replicated/dockerfilelint /Dockerfile

push-image:
	docker buildx build --platform $(PLATFORMS) --push $(BUILD_ARGS)

.PHONY: setup-buildx image image-local test lint push-image
