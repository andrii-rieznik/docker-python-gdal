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
GDAL_DAILY_FL=$(wget -O - "${GDAL_DAILY_URL}" \
    | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' \
    | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' \
    | grep -e 'gdal-svn-trunk-[0-9]*.[0-9]*.[0-9]*.tar.gz$')
cd "${ROOTDIR}"
wget "${GDAL_DAILY_URL}${GDAL_DAILY_FL}"
tar -xvf "${GDAL_DAILY_FL}"


# Compile and install GDAL
cd "${GDAL_DAILY_FL%.tar.gz}"
./configure \
    --with-python \
    --with-curl \
    --with-openjpeg

make -j"$(nproc)"
make install
ldconfig


# Install Python bindings
cd "${ROOTDIR}/${GDAL_DAILY_FL%.tar.gz}/swig/python"
python3 setup.py build
python3 setup.py install
cd /usr/local


# Clean up
apt-get update -y
apt-get remove -y --purge build-essential wget
apt-get autoremove
rm -rf /var/lib/apt/lists/*
rm -rf "${ROOTDIR}"
