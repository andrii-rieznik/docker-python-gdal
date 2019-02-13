IMAGE := andrejreznik/python-gdal:stable

image:
	docker build -t $(IMAGE) .

test:
	docker run $(IMAGE)

lint:
	docker run -v `pwd`/Dockerfile:/Dockerfile replicated/dockerfilelint /Dockerfile

push-image:
	docker push $(IMAGE)

.PHONY: image test lint push-image
