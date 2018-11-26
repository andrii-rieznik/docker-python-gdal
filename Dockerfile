##
# andrejreznik/python-gdal
#
# Debian 9.6 Stretch
FROM debian:latest
MAINTAINER Andrey Reznik <andrey.reznik.ce@gmail.com>

# Latest stable varions
ENV PYTHON_VERSION 3.7.1
ENV PYTHON_PIP_VERSION 18.1
ENV GDAL_VERSION 2.3.2

ENV ROOTDIR /usr/local/src/python-gdal

# Compile and install Python, pip
ADD ./scripts/install-python.sh ${ROOTDIR}/
RUN ${ROOTDIR}/install-python.sh

# Compile and install GDAL, python bindings
ADD ./scripts/install-gdal.sh ${ROOTDIR}/
RUN ${ROOTDIR}/install-gdal.sh

CMD python3 -V && pip -V && gdalinfo --version
