# 🌍 python-gdal

![Build](https://img.shields.io/github/actions/workflow/status/andrii-rieznik/docker-python-gdal/push.yml?branch=master)![Pulls](https://img.shields.io/docker/pulls/andrejreznik/python-gdal)![Size](https://img.shields.io/docker/image-size/andrejreznik/python-gdal)

## Python GDAL/OGR API

These containers ship with pre-installed GDAL's and OGR's Python bindings.

Powered by [`pyenv`](https://github.com/pyenv/pyenv) which helps to manage Python versions,  and builded from official [`GDAL`](https://github.com/OSGeo/GDAL) sources.
## Usage

The `Dockerfile` provides defaults when executing a container:

```bash
# prints Python, pip, and GDAL versions

docker run ghcr.io/andrii-rieznik/python-gdal
```

To run a container and start an interactive bash session as root:

```bash
docker run -it ghcr.io/andrii-rieznik/python-gdal /bin/bash
```

## Tags and versioning

To use a specific version of Python or GDAL with the appropriate tag:

```bash
docker run ghcr.io/andrii-rieznik/python-gdal:py3.12.6-gdal3.9.2
```

To pass as build arguments:

```bash
make image PYTHON_VERSION=3.12.6 GDAL_VERSION=3.9.2
```

## License

See [MIT](https://github.com/andrii-rieznik/docker-python-gdal/blob/master/LICENSE).
