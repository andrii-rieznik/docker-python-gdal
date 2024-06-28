# 🐳 python-gdal
![Build](https://img.shields.io/github/actions/workflow/status/andrii-reznik/docker-python-gdal/push.yml?branch=master)![Pulls](https://img.shields.io/docker/pulls/andrejreznik/python-gdal.svg)![Size](https://img.shields.io/docker/image-size/andrejreznik/python-gdal/latest.svg)
#### Python + GDAL/OGR Docker image

Get and compile the latest stable GDAL/OGR sources from official repository.

#### Usage

Dockerfile provide defaults when executing a container:

```bash
$ docker run andrejreznik/python-gdal:stable
```

Will output Python, pip and GDAL versions:

```console
Python 3.12.4
pip 24.1.1 from /usr/local/pyenv/versions/3.12.4/lib/python3.12/site-packages/pip (python 3.12)
GDAL 3.9.1, released 2024/06/22
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
$ make image GDAL_VERSION=3.8.4 PYTHON_VERSION=3.11
```
