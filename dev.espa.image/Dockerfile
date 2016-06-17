FROM dev.espa.centos.tools


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
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-elevation \
    && REPO_TAG=dev_v1.0.0 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Add an entrypoint so that we execute the specified application as the
# specified user (THE_USER specified below)
RUN echo "Release Candidate 1"
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
