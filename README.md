# :whale: python-gdal
[![CircleCI](https://circleci.com/gh/andrejreznik/docker-python-gdal/tree/master.svg?style=shield)](https://circleci.com/gh/andrejreznik/docker-python-gdal/tree/master)![](https://images.microbadger.com/badges/image/andrejreznik/python-gdal.svg)![](https://img.shields.io/docker/pulls/andrejreznik/python-gdal.svg)

#### Python + GDAL/OGR Docker image

Get and compile latest CPython 3 and GDAL 2 sources from their official repositories.

#### Usage

Output versions of Python, pip and GDAL

```bash
$ docker run andrejreznik/python-gdal

Python 3.7.2
pip 18.1 from /usr/local/lib/python3.7/site-packages/pip (python 3.7)
GDAL 2.4.0, released 2018/12/14
```

Run container and start an interactive bash session as root 

```bash
$ docker run -it andrejreznik/python-gdal bash
```