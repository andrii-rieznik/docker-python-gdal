##
# andrejreznik/python-gdal
#
# Official Python 3.7.2 image based on slim Debian 9.6 Stretch image.
FROM python:3.7-slim-stretch
MAINTAINER Andrey Reznik <andrey.reznik.ce@gmail.com>

ENV GDAL_VERSION=2.4.0 \
    SOURCE_DIR="/usr/local/src/python-gdal"

RUN \
# Install runtime dependencies
    apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        wget \
        libpq-dev \
        libcurl4-gnutls-dev \
        libproj-dev \
        libxml2-dev \
        libgeos-dev \
        libnetcdf-dev \
        libpoppler-dev \
        libspatialite-dev \
        libhdf4-alt-dev \
        libhdf5-serial-dev \
        libopenjp2-7-dev \
    && rm -rf /var/lib/apt/lists/* \
    \
# Get latest GDAL source
    && mkdir -p "${SOURCE_DIR}" \
    && cd "${SOURCE_DIR}" \
    && wget "http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz" \
    && tar -xvf "gdal-${GDAL_VERSION}.tar.gz" \
    \
# Compile and install GDAL
    && cd "gdal-${GDAL_VERSION}" \
    && ./configure \
            --with-python \
            --with-curl \
            --with-openjpeg \
    && make -j"$(nproc)" \
    && make install \
    && ldconfig \
    \
# Install Python bindings
    && cd "${SOURCE_DIR}/gdal-${GDAL_VERSION}/swig/python" \
    && python3 setup.py build \
    && python3 setup.py install \
    && cd /usr/local \
    \
# Clean up
    && apt-get update -y \
    && apt-get remove -y --purge build-essential wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf "${SOURCE_DIR}"

CMD python3 -V && pip -V && gdalinfo --version
