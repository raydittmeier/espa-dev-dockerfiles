#!/bin/bash
set -e

# THE_USER is defined in the Dockerfile

THE_GID=$1
shift # past the argument
THE_UID=$1
shift # past the argument

# Add the user and group to the system
groupadd --gid $THE_GID $THE_USER
useradd --system --gid $THE_GID --uid $THE_UID --shell /bin/bash --create-home $THE_USER

usermod -append --groups sudo $THE_USER
#echo "$THE_USER ALL=(ALL) NOPASSWD: /usr/bin/chattr" >> /etc/sudoers
echo "$THE_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

##############################################################################
# DON'T EVER DO THE FOLLOWING IN A PRODUCTION DOCKER IMAGE ONLY DEV
echo "$THE_USER:bunny-rabbit" | chpasswd
#echo "$THE_USER ALL=(ALL) ALL" >> /etc/sudoers
# DON'T EVER DO THE ABOVE IN A PRODUCTION DOCKER IMAGE ONLY DEV
##############################################################################

# Add the espa runtime installation directory to the path
export PATH=$PREFIX/bin:/home/$THE_USER/bin:$PATH

# Corectly set these environment variables for the user
export USER=$THE_USER
export HOME=/home/$THE_USER

# Don't create *.pyc files
export PYTHONDONTWRITEBYTECODE=1
# Activate the python virtual environment
. /python-virtual/bin/activate

# Fixup the home directory since it was created before the user was
cd $HOME
cp /etc/skel/.bash_logout .
cp /etc/skel/.bashrc .
cp /etc/skel/.profile .
chown $THE_UID:$THE_GID .bash_logout .bashrc .profile .valgrindrc valgrind.supp .
chown --recursive $THE_UID:$THE_GID /usr/local/bin
chown --recursive $THE_UID:$THE_GID /usr/local/espa-cloud-masking
chown --recursive $THE_UID:$THE_GID /usr/local/espa-land-surface-temperature
chown --recursive $THE_UID:$THE_GID /usr/local/espa-product-formatter
chown --recursive $THE_UID:$THE_GID /usr/local/espa-spectral-indices
chown --recursive $THE_UID:$THE_GID /usr/local/espa-surface-reflectance
chown --recursive $THE_UID:$THE_GID /usr/local/espa-surface-water-extent
chown --recursive $THE_UID:$THE_GID /usr/local/etc
chown --recursive $THE_UID:$THE_GID /usr/local/examples
chown --recursive $THE_UID:$THE_GID /usr/local/include
chown --recursive $THE_UID:$THE_GID /usr/local/lib
chown --recursive $THE_UID:$THE_GID /usr/local/libexec
chown --recursive $THE_UID:$THE_GID /usr/local/python
chown --recursive $THE_UID:$THE_GID /usr/local/sbin
chown --recursive $THE_UID:$THE_GID /usr/local/schema
chown --recursive $THE_UID:$THE_GID /usr/local/share
chown --recursive $THE_UID:$THE_GID /usr/local/src
chmod go=u,go-w .bash_logout .bashrc .profile
chmod go= .

# Now execute as the user
exec gosu $THE_USER $@
#exec gosu $THE_USER /bin/bash $@
#exec gosu root /bin/bash
#/bin/bash
