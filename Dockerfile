##
# andrejreznik/python-gdal
#
# Debian 9.6 Stretch
FROM debian:9.6
MAINTAINER Andrey Reznik <andrey.reznik.ce@gmail.com>

# Latest stable varions
ENV PYTHON_VERSION=3.7.2 \
    PYTHON_PIP_VERSION=18.1 \
    GDAL_VERSION=2.4.0 \
    ROOTDIR=/usr/local/src/python-gdal

# Copy installing scripts
ADD ./scripts ${ROOTDIR}/

# Compile and install Python, pip, GDAL, python bindings
RUN ${ROOTDIR}/install-python.sh && ${ROOTDIR}/install-gdal.sh

CMD python3 -V && pip -V && gdalinfo --version
