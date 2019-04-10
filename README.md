# :whale: python-gdal
[![Build Status](https://travis-ci.org/andrejreznik/docker-python-gdal.svg?branch=master)](https://travis-ci.org/andrejreznik/docker-python-gdal)![](https://images.microbadger.com/badges/image/andrejreznik/python-gdal.svg)![](https://img.shields.io/docker/pulls/andrejreznik/python-gdal.svg)

#### Python + GDAL/OGR Docker image

Get and compile latest stable GDAL/OGR sources from official repository.

#### Usage

Output versions of Python, pip and GDAL

```bash
$ docker run andrejreznik/python-gdal:stable

Python 3.7.3
pip 19.0.3 from /usr/local/lib/python3.7/site-packages/pip (python 3.7)
GDAL 2.4.1, released 2019/03/15
```

Run container and start an interactive bash session as root 

```bash
$ docker run -it andrejreznik/python-gdal:stable bash
```
