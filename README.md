#  python-gdal [![Build Status](https://travis-ci.org/andrejreznik/docker-python-gdal.svg?branch=master)](https://travis-ci.org/andrejreznik/docker-python-gdal)

#### Python + GDAL/OGR Docker image

Get and compile latest CPython and GDAL sources from their official repositories.

#### Usage

Output verions of Python, pip and GDAL

```bash
docker run andrejreznik/python-gdal
```

Run container and start an interactive bash session as root 

```bash
docker run -it andrejreznik/python-gdal bash
```