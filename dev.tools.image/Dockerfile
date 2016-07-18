FROM usgs.espa.centos.external:0.1.0


MAINTAINER USGS LSRD http://eros.usgs.gov


LABEL description="This is a build containing additional software for development purposes."

# ----------------------------------------------------------------------------
# Install additional tools for the developer only
# XFCE for multiple terminals to the container
RUN yum install -y epel-release time \
    && yum groupinstall -y "X Window system" \
    && yum groupinstall -y xfce \
    && yum clean metadata

# ----------------------------------------------------------------------------
# Install newer python modules
RUN . /python-env/bin/activate \
    && pip install --upgrade pip \
    && pip install --upgrade pep8
