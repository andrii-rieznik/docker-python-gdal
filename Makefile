IMAGE := andrejreznik/python-gdal

test:
	docker run $(IMAGE)

image:
	docker build -t $(IMAGE) .

push-image:
	docker push $(IMAGE)

.PHONY: image push-image test
