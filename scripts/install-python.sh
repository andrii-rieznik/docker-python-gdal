#!/bin/sh

# Install runtime dependencies
apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    make \
    gcc \
    dpkg-dev \
    zlib1g-dev \
    libssl-dev libffi-dev tk-dev libncursesw5-dev libsqlite3-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Download and unpack the downloaded archive
cd ${ROOTDIR}
wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
tar -xvzf Python-3.6.5.tgz

# Install Python from source

cd Python-${PYTHON_VERSION}
./configure \
    --enable-optimizations \
    --enable-shared \
    --without-ensurepip

make -j$(nproc)
make install
ldconfig

rm -rf ${ROOTDIR}/Python-${PYTHON_VERSION}
