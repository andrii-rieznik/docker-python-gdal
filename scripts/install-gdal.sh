#!/bin/sh

# Install runtime dependencies
apt-get update -y \
    && apt-get install -y \
        build-essential \
        python3-dev \
        python3-numpy \
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
    && rm -rf /var/lib/apt/lists/*


# Get latest GDAL source
cd "${ROOTDIR}"
wget "http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz"
tar -xvf "gdal-${GDAL_VERSION}.tar.gz"


# Compile and install GDAL
cd "gdal-${GDAL_VERSION}"
./configure \
    --with-python \
    --with-curl \
    --with-openjpeg

make -j"$(nproc)"
make install
ldconfig


# Install Python bindings
cd "${ROOTDIR}/gdal-${GDAL_VERSION}/swig/python"
python3 setup.py build
python3 setup.py install
cd /usr/local


# Clean up
apt-get update -y
apt-get remove -y --purge build-essential wget
apt-get autoremove
rm -rf /var/lib/apt/lists/*
rm -rf "${ROOTDIR}"
