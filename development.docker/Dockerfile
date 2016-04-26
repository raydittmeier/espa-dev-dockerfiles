FROM usgs.espa.ubuntu.science
MAINTAINER USGS LSRD http://eros.usgs.gov

LABEL description="This is a build containing additional software for development purposes."


# ----------------------------------------------------------------------------
# Install additional tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        less \
        xfce4-terminal \
    && apt-get install -y --no-install-recommends \
        valgrind \
        sudo \
    && apt-get install -y --no-install-recommends \
        rpm

# command line, just to help rebuild the docker
RUN echo "Compile Revision 1"

# ----------------------------------------------------------------------------
# Install newer python modules
RUN . /python-virtual/bin/activate \
    && pip install --upgrade pip \
    && pip install \
        --upgrade git+https://github.com/USGS-EROS/espa-python-library


# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# This section is a slightly modified copy of the ubuntu/science Dockerfile.
# Required to install more up-to-date science applications, without having to
# build any intermediate docker images.
# ----------------------------------------------------------------------------
# Define the installation and library locations
# Assign developer specific environment variables
ENV DEV_SRC=/home/espa/dev-src

# ----------------------------------------------------------------------------
# Clone the software and then build and install it
# ----------------------------------------------------------------------------
RUN mkdir -p /home/espa/dev-src

RUN echo "Release Candidate 1"
RUN REPO_NAME=espa-product-formatter \
    && REPO_TAG=dev_v1.7.0 \
    && cd ${DEV_SRC} \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=no ENABLE_THREADING=yes \
    && make install \
    && cd .. \
    && rm -rf ${REPO_NAME}

RUN REPO_NAME=espa-spectral-indices \
    && REPO_TAG=master \
    && cd ${DEV_SRC} \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=no ENABLE_THREADING=yes \
    && make install \
    && cd .. \
    && rm -rf ${REPO_NAME}

RUN REPO_NAME=espa-cloud-masking \
    && REPO_TAG=master \
    && cd ${DEV_SRC} \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=no ENABLE_THREADING=yes \
    && make install \
    && cd .. \
    && rm -rf ${REPO_NAME}

RUN REPO_NAME=espa-surface-water-extent \
    && REPO_TAG=dev_may2016 \
    && cd ${DEV_SRC} \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=no ENABLE_THREADING=yes \
    && make install \
    && cd .. \
    && rm -rf ${REPO_NAME}

RUN REPO_NAME=espa-surface-reflectance \
    && REPO_TAG=dev_may2016 \
    && cd ${DEV_SRC} \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=no ENABLE_THREADING=yes \
    && make install \
    && cd .. \
    && rm -rf ${REPO_NAME}

RUN REPO_NAME=espa-land-surface-temperature \
    && REPO_TAG=dev_v0.0.3 \
    && cd ${DEV_SRC} \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=no ENABLE_THREADING=yes \
    && make install \
    && cd .. \
    && rm -rf ${REPO_NAME}


# ----------------------------------------------------------------------------
# Build MODTRAN into the docker image
# If ever a new MODTRAN is built, the DATA directory needs to be copied
# to the auxiliaries location
COPY ./modtran-5.3.2 /usr/local/src/modtran
RUN cd /usr/local/src/modtran \
    && ./bootstrap \
    && ./configure \
    && make install \
    && make databases \
    && ln -sf /usr/local/bin/mod53 /usr/local/bin/modtran \
    && cd .. \
    && rm -rf modtran

RUN rm -r ${DEV_SRC}

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Add some of my aliases for me
RUN mkdir -p /home/espa \
    && echo "alias cls='clear;ls'" >> /home/espa/.bash_aliases

# ----------------------------------------------------------------------------
# Add an entrypoint so that we execute the specified application as the
# specified user (THE_USER specified below)
RUN echo "Release Candidate 3"
ENV THE_USER=espa \
    DEV_DATA_DIRECTORY=/home/espa/input-data

COPY valgrindrc /home/${THE_USER}/.valgrindrc
COPY valgrind.supp /home/${THE_USER}/valgrind.supp
COPY make /home/${THE_USER}/bin/make
COPY dev-entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
