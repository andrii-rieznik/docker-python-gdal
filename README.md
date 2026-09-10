# 🌍 python-gdal

## Python GDAL/OGR API

These containers ship with pre-installed GDAL's and OGR's Python bindings.

Powered by [`pyenv`](https://github.com/pyenv/pyenv) which helps to manage Python versions,  and builded from official [`GDAL`](https://github.com/OSGeo/GDAL) sources.
## Usage
The `Dockerfile` provides defaults when executing a container:

```

## Tags and versioning

To use a specific version of Python or GDAL with the appropriate tag:

```bash
docker run vodka/python-gdal-trixie:py3.11-gdal3.6.2
```

To pass as build arguments:

```bash
make image PYTHON_VERSION=3.11 GDAL_VERSION=3.6.2
```

## License

See [MIT](https://github.com/endast/docker-python-gdal/blob/master/LICENSE).
