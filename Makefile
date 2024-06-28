GDAL_VERSION ?= 3.9.1
PYTHON_VERSION ?= 3.12.4
DOCKER_REPO ?= andrejreznik/python-gdal
IMAGE ?= $(DOCKER_REPO):py$(PYTHON_VERSION)-gdal$(GDAL_VERSION)

image:
	docker build \
		--build-arg GDAL_VERSION=$(GDAL_VERSION) \
		--build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
		-t $(IMAGE) .

test:
	docker run --rm $(IMAGE)

lint:
	docker run \
		--rm \
		-v `pwd`/.dockerfilelintrc:/.dockerfilelintrc \
		-v `pwd`/Dockerfile:/Dockerfile \
		replicated/dockerfilelint /Dockerfile

push-image:
	docker push $(IMAGE)

.PHONY: image test lint push-image
