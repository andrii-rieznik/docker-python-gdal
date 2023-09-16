##
# andrejreznik/python-gdal
#
# Build args can be redefined in Makefile or passed as build args to Docker build command

ARG BASE_IMAGE=python:3.10.0-slim-bullseye

FROM ${BASE_IMAGE}

LABEL maintainer="Andrii Rieznik <andrii.rieznik@protonmail.com>"

LABEL org.opencontainers.image.source=https://github.com/andriyreznik/docker-python-gdal
LABEL org.opencontainers.image.description="Debian based image with pre-installed GDAL/OGR libraries and Python bindings"
LABEL org.opencontainers.image.licenses=MIT

ARG GDAL_VERSION=3.2.3
ARG SOURCE_DIR=/usr/local/src/python-gdal

RUN \
# Install runtime dependencies
    apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        wget \
        automake libtool pkg-config libsqlite3-dev sqlite3 \
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
# Install numpy
    && pip install numpy \
# Build against PROJ master (which will be released as PROJ 6.0)
    && wget "http://download.osgeo.org/proj/proj-6.0.0.tar.gz" \
    && tar -xzf "proj-6.0.0.tar.gz" \
    && mv proj-6.0.0 proj \
    && echo "#!/bin/sh" > proj/autogen.sh \
    && chmod +x proj/autogen.sh \
    && cd proj \
    && ./autogen.sh \
    && CXXFLAGS='-DPROJ_RENAME_SYMBOLS' CFLAGS='-DPROJ_RENAME_SYMBOLS' ./configure --disable-static --prefix=/usr/local \
    && make -j"$(nproc)" \
    && make -j"$(nproc)" install \
    # Rename the library to libinternalproj
    && mv /usr/local/lib/libproj.so.15.0.0 /usr/local/lib/libinternalproj.so.15.0.0 \
    && rm /usr/local/lib/libproj.so* \
    && rm /usr/local/lib/libproj.la \
    && ln -s libinternalproj.so.15.0.0 /usr/local/lib/libinternalproj.so.15 \
    && ln -s libinternalproj.so.15.0.0 /usr/local/lib/libinternalproj.so \
    \
# Get latest GDAL source
    && mkdir -p "${SOURCE_DIR}" \
    && cd "${SOURCE_DIR}" \
    && wget "http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz" \
    && tar -xvf "gdal-${GDAL_VERSION}.tar.gz" \
    \
# Compile and install GDAL
    && cd "gdal-${GDAL_VERSION}" \
    && export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH \
    && ./configure \
            --with-python \
            --with-curl \
            --with-openjpeg \
            --without-libtool \
            --with-proj=/usr/local \
    && make -j"$(nproc)" \
    && make install \
    && ldconfig \
    \
# Install Python bindings as standalone module via pip
    && pip install GDAL==${GDAL_VERSION} \
    && cd /usr/local \
    \
# Clean up
    && apt-get update -y \
    && apt-get remove -y --purge build-essential wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf "${SOURCE_DIR}"

CMD python3 -V && pip -V && gdalinfo --version
