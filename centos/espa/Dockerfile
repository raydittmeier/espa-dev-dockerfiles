FROM dev.centos.tools:2.12.1


MAINTAINER USGS EROS LSRD http://eros.usgs.gov


LABEL description="This is a build containing additional software for development purposes."

# ----------------------------------------------------------------------------
# Install newer python modules
RUN pip install \
        git+https://github.com/USGS-EROS/espa-python-library@v1.0.1#espa


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
    && REPO_TAG=product_formatter_v1.9.0 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-spectral-indices \
    && REPO_TAG=spectral_indices_v2.5.0 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-cloud-masking \
    && REPO_TAG=cfmask-version_2.0.1-1 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-surface-water-extent \
    && REPO_TAG=2016_Aug \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-surface-reflectance \
    && REPO_TAG=surface_reflectance_oct2016 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-land-surface-temperature \
    && REPO_TAG=2016_Aug-1 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes ENABLE_THREADING=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}


RUN REPO_NAME=espa-elevation \
    && REPO_TAG=v2.1.0 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
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
    && make install \
    && ln -sf /usr/local/bin/mod53 /usr/local/bin/modtran
#    && make databases \
#    && cp -r DATA /usr/local/share/MODTRAN_DATA \
#    && cd $SRC_DIR \
#    && rm -rf modtran


RUN echo "Release Candidate cobalt-blue"
RUN REPO_NAME=espa-processing \
    && REPO_TAG=espa-2.12.0-release \
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
RUN echo "Release Candidate bubble-gum"
ENV THE_USER=espa \
    DEV_DATA_DIRECTORY=/home/espa/input-data


# ----------------------------------------------------------------------------
# My user environment stuff
COPY environment/bashrc /home/${THE_USER}/.bashrc
COPY environment/bash-aliases /home/${THE_USER}/.bash-aliases
COPY environment/bash-prompt /home/${THE_USER}/.bash-prompt
COPY environment/bash-user /home/${THE_USER}/.bash-user

COPY environment/valgrindrc /home/${THE_USER}/.valgrindrc
COPY environment/valgrind.supp /home/${THE_USER}/valgrind.supp
COPY environment/make /home/${THE_USER}/bin/make
COPY environment/dev-entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
