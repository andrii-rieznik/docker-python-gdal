IMAGE := andrejreznik/python-gdal:stable

image:
	docker build -t $(IMAGE) .

test:
	docker run $(IMAGE)

push-image:
	docker push $(IMAGE)

.PHONY: image test push-image
