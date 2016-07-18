FROM dev.espa.centos.tools:0.1.0


MAINTAINER USGS LSRD http://eros.usgs.gov


LABEL description="This is a build containing additional software for development purposes."

# ----------------------------------------------------------------------------
# Install newer python modules
RUN . /python-env/bin/activate \
    && pip install \
        --upgrade git+https://github.com/USGS-EROS/espa-python-library@dev_201608#espa


# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# This section is a slightly modified copy of the centos/science Dockerfile.
# Required to install more up-to-date science applications, without having to
# build any intermediate docker images.
# ----------------------------------------------------------------------------


ENV PREFIX=/usr/local \
    ESPAINC=/usr/local/include \
    ESPALIB=/usr/local/lib


# ----------------------------------------------------------------------------
# Clone the software and then build and install it
# ----------------------------------------------------------------------------


RUN REPO_NAME=espa-product-formatter \
    && REPO_TAG=dev_v1.8.0 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-spectral-indices \
    && REPO_TAG=dev_v2.5.0 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-cloud-masking \
    && REPO_TAG=dev_aug2016 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-surface-water-extent \
    && REPO_TAG=dev_aug2016 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-surface-reflectance \
    && REPO_TAG=dev_aug2016 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-land-surface-temperature \
    && REPO_TAG=dev_v0.0.4 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes ENABLE_THREADING=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-elevation \
    && REPO_TAG=dev_v2.0.1 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}

# ----------------------------------------------------------------------------
# Build MODTRAN into the docker image
# If ever a new MODTRAN is built, the DATA directory needs to be copied
# to the auxiliaries location
COPY external_tools/modtran-5.3.2 /usr/local/src/modtran
RUN cd $SRC_DIR \
    && cd modtran \
    && ./bootstrap \
    && ./configure \
    && make install
#    && make databases \
#    && cp -r DATA /usr/local/share/MODTRAN_DATA \
#    && ln -sf /usr/local/bin/mod53 /usr/local/bin/modtran \
#    && cd $SRC_DIR \
#    && rm -rf modtran


RUN echo "Release Candidate Paper-Pancake"
RUN REPO_NAME=espa-processing \
    && REPO_TAG=dev_bridge_work \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Add an entrypoint so that we execute the specified application as the
# specified user (THE_USER specified below)
RUN echo "Release Candidate Paper-Pancake"
ENV THE_USER=espa \
    DEV_DATA_DIRECTORY=/home/espa/input-data

# ----------------------------------------------------------------------------
# My user environment stuff
COPY bashrc /home/${THE_USER}/.bashrc
COPY bash-aliases /home/${THE_USER}/.bash-aliases
COPY bash-prompt /home/${THE_USER}/.bash-prompt
COPY bash-user /home/${THE_USER}/.bash-user
COPY processing.conf /home/${THE_USER}/.usgs/espa/processing.conf

COPY valgrindrc /home/${THE_USER}/.valgrindrc
COPY valgrind.supp /home/${THE_USER}/valgrind.supp
COPY make /home/${THE_USER}/bin/make
COPY dev-entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
