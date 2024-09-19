FROM debian:bookworm

LABEL org.opencontainers.image.authors=andrii.rieznik@pm.me
LABEL org.opencontainers.image.source=https://github.com/andrii-reznik/docker-python-gdal
LABEL org.opencontainers.image.description="Debian based image with pre-installed GDAL/OGR libraries and Python bindings"
LABEL org.opencontainers.image.licenses=MIT

ARG PYTHON_VERSION=3.12.6
ARG GDAL_VERSION=3.9.2
ARG SOURCE_DIR=/usr/local/src/python-gdal

ENV PYENV_ROOT="/usr/local/pyenv"
ENV PATH="/usr/local/pyenv/shims:/usr/local/pyenv/bin:$PATH"

RUN \
    # Install runtime dependencies
    apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        wget \
        git \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev \
        ca-certificates \
        \
        curl \
        cmake \
        libproj-dev \
        swig \
    && rm -rf /var/lib/apt/lists/* \
    # Install pyenv
    && git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT} \
    && echo 'export PYENV_ROOT=/usr/local/pyenv' >> /root/.bashrc \
    && echo 'export PATH=/usr/local/pyenv/bin:$PATH' >> /root/.bashrc \
    && echo 'eval "$(pyenv init -)"' >> /root/.bashrc \
    && eval "$(pyenv init -)" && pyenv install ${PYTHON_VERSION} \
    && eval "$(pyenv init -)" && pyenv global ${PYTHON_VERSION} \
    && eval "$(pyenv init -)" && pip install --upgrade pip \
    && eval "$(pyenv init -)" && pip install numpy setuptools \
    # Install GDAL
    && export CMAKE_BUILD_PARALLEL_LEVEL=`nproc --all` \
    && mkdir -p "${SOURCE_DIR}" \
    && cd "${SOURCE_DIR}" \
    && wget "http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz" \
    && tar -xvf "gdal-${GDAL_VERSION}.tar.gz" \
    && cd gdal-${GDAL_VERSION} \
    && mkdir build \
    && cd build \
    && cmake .. \
        -DBUILD_PYTHON_BINDINGS=ON \
        -DCMAKE_BUILD_TYPE=Release \
        -DPYTHON_INCLUDE_DIR=`python -c "import sysconfig; print(sysconfig.get_path('include'))"` \
        -DPYTHON_LIBRARY=`python -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))"` \
        -DGDAL_PYTHON_INSTALL_PREFIX=`pyenv prefix` \
    && cmake --build . \
    && cmake --build . --target install \
    && ldconfig \
    # Clean-up
    && apt-get update -y \
    && apt-get remove -y --purge build-essential wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf "${SOURCE_DIR}"

CMD python -V && pip -V && gdalinfo --version
