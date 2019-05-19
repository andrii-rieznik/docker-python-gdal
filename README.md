# :whale: python-gdal
[![Build Status](https://travis-ci.org/andrejreznik/docker-python-gdal.svg?branch=master)](https://travis-ci.org/andrejreznik/docker-python-gdal)![](https://images.microbadger.com/badges/image/andrejreznik/python-gdal.svg)![](https://img.shields.io/docker/pulls/andrejreznik/python-gdal.svg)

#### Python + GDAL/OGR Docker image

Get and compile latest stable GDAL/OGR sources from official repository.

#### Usage

Dockerfile provide defaults when executing a container: 

```bash
$ docker run andrejreznik/python-gdal:stable
```

Will output Python, pip and GDAL versions:

```console
Python 3.7.3
pip 19.1.1 from /usr/local/lib/python3.7/site-packages/pip (python 3.7)
GDAL 3.0.0, released 2019/05/05
```

Run container and start an interactive bash session as root 

```bash
$ docker run -it andrejreznik/python-gdal:stable bash
```
