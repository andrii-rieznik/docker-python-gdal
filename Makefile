GDAL_VERSION ?= 3.0.0
PYTHON_VERSION ?= 3.7.3
PYTHON_IMAGE_TAG ?= $(PYTHON_VERSION)-slim-stretch
IMAGE ?= andrejreznik/python-gdal:py$(PYTHON_VERSION)-gdal$(GDAL_VERSION)

image:
	docker build \
		--build-arg GDAL_VERSION=$(GDAL_VERSION) \
		--build-arg PYTHON_IMAGE_TAG=$(PYTHON_IMAGE_TAG) \
		-t $(IMAGE) .

test:
	docker run $(IMAGE)

lint:
	docker run -v `pwd`/Dockerfile:/Dockerfile replicated/dockerfilelint /Dockerfile

push-image:
	docker push $(IMAGE)

.PHONY: image test lint push-image
