##
# andrejreznik/python-gdal
#
# Debian 9.4 Stretch
FROM debian:latest
MAINTAINER Andrey Reznik <andrey.reznik.ce@gmail.com>

ENV PYTHON_VERSION 3.6.5
ENV PYTHON_PIP_VERSION 10.0.1
ENV GDAL_DAILY_URL http://www.gdal.org/daily/

ENV ROOTDIR /usr/local/src/python-gdal

# Compile and install Python
ADD ./scripts/install-python.sh ${ROOTDIR}/
RUN ${ROOTDIR}/install-python.sh

# Compile and install GDAL
ADD ./scripts/install-gdal.sh ${ROOTDIR}/
RUN ${ROOTDIR}/install-gdal.sh

CMD python3 -V && pip3 -V && gdalinfo --version
