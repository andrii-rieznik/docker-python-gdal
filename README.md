# 🐍🌍 python-gdal

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

## Multi-architecture builds

`make image` and `make push-image` build for `linux/amd64` and `linux/arm64`.
Once per machine, set up qemu emulation and a multi-platform builder:

```bash
make setup-buildx
```

Emulated builds are slow (GDAL and Python are compiled from source); build on
native hardware per architecture where you can. Override the target list with
`make image PLATFORMS=linux/arm64`. `make test` builds the native architecture
only, since a multi-platform image cannot be loaded into the local image store.

## License

See [MIT](https://github.com/endast/docker-python-gdal/blob/master/LICENSE).
