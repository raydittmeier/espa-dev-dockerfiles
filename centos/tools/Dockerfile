FROM espa.centos.external:2.12.0


MAINTAINER USGS EROS LSRD http://eros.usgs.gov


LABEL description="This is a build containing additional software for development purposes."

# ----------------------------------------------------------------------------
# Install additional tools for the developer only
# XFCE for multiple terminals to the container
RUN yum install -y \
        epel-release \
        mlocate \
        sudo \
        time \
        valgrind \
        vim-enhanced \
        which \
    && yum groupinstall -y "X Window system" \
    && yum groupinstall -y xfce \
    && yum clean metadata


# Install gosu so that the entrypoint script (installed later) can change the
# specified user.  "gosu is used for easy step-down from root"
COPY external_tools/gosu-amd64 /usr/local/bin/gosu
RUN chmod +x /usr/local/bin/gosu


# ----------------------------------------------------------------------------
# Install newer python modules
RUN pip install --upgrade pip \
    && pip install --upgrade pep8 \
    && pip install --upgrade nose2 \
    && pip install --upgrade coverage \
    && pip install --upgrade cov-core
