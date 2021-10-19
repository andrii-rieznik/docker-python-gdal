# :whale: python-gdal
![Build](https://github.com/andrejreznik/docker-python-gdal/workflows/Build/badge.svg)![Layers](https://images.microbadger.com/badges/image/andrejreznik/python-gdal.svg)![Pulls](https://img.shields.io/docker/pulls/andrejreznik/python-gdal.svg)

#### Python + GDAL/OGR Docker image

Get and compile the latest stable GDAL/OGR sources from official repository.

#### Usage

Dockerfile provide defaults when executing a container:

```bash
$ docker run andrejreznik/python-gdal:stable
```

Will output Python, pip and GDAL versions:

```console
Python 3.10.0
pip 21.2.4 from /usr/local/lib/python3.10/site-packages/pip (python 3.10)
GDAL 3.2.3, released 2021/04/27
```

Run container and start an interactive bash session as root

```bash
$ docker run -it andrejreznik/python-gdal:stable bash
```

#### Tags and versions

You can also use a specific version of Python or GDAL by appropriate tag

```bash
$ docker run andrejreznik/python-gdal:py3.7.3-gdal3.0.0
```

or build your own image with passed build args

```bash
$ make image GDAL_VERSION=2.3.1 BASE_IMAGE=python:3.5-jessie
```
