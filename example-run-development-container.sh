
container_name="$USER-xfce"

tag=":latest"
if [ $1 ]; then
    tag=:$1
fi

d_image=dev.centos.espa${tag}

d_cmdline=/usr/bin/xfce4-terminal
d_cmdline=${d_cmdline}" "--title" "${tag}-one
d_cmdline=${d_cmdline}" "--tab" "--title" "${tag}-two
d_cmdline=${d_cmdline}" "--tab" "--title" "${tag}-three
d_cmdline=${d_cmdline}" "--tab" "--title" "${tag}-four
#d_cmdline=/bin/bash

# X11 stuff
D_XSOCKET=/tmp/.X11-unix
D_XAUTHORITY=/tmp/.docker.xauth
D_ICE=/tmp/.ICE-unix
touch $D_XAUTHORITY
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $D_XAUTHORITY nmerge -

# Create the command components
d_rm="--rm"

# DEV Only - Use a pseudo-TTY
d_tty="--tty"

# DEV Only - Use a pseudo-TTY
d_interactive="--interactive"

# Special linux capabilities for allowing chattr to work on external volumes
# which support extended attributes
d_linux_capabilities="--cap-add LINUX_IMMUTABLE"

# DEV PROD? - Setup the hostname
d_host="--hostname ${container_name}"
# DEV PROD? - Name the running container the same as the hostname
d_name="--name ${container_name}"

# Required to sync the docker time with the host, so the host must have that
# file available
d_time="--volume /etc/localtime:/etc/localtime:ro"

# ALL - Work directory for orders
d_mount_1="--volume /data2/$USER/work-dir:/home/espa/work-dir:rw"
# ALL - Output directory for products
d_mount_2="--volume /data2/$USER/output-data:/home/espa/output-data:rw"
# ALL - Auxiliary input data
d_mount_3="--volume /usr/local/auxiliaries:/usr/local/auxiliaries:ro"
# ALL - Configuration
d_mount_4="--volume $HOME/.usgs:/home/espa/.usgs:ro"
# DEV ONLY - LSRD source code
d_mount_5="--volume /data2/$USER/lsrd-src:/home/espa/lsrd-src:rw"
# DEV ONLY - Input data
d_mount_6="--volume /data2/$USER/input-data:/home/espa/input-data:rw"

# DEV ONLY - Required for X11 forwarding to the host display
d_x11_1="--volume $D_XSOCKET:$D_XSOCKET:rw"
d_x11_2="--volume $D_XAUTHORITY:$D_XAUTHORITY:rw"
d_x11_3="--env XAUTHORITY=${D_XAUTHORITY}"
d_x11_4="--env DISPLAY"

# DEV? PROD? - Starting directory
d_workdir="--workdir /home/espa"

# Set the user's ID to this
d_userid=`id -u`
# Set the user's group ID to this
d_groupid=`id -g`

cmd="docker run"
cmd=${cmd}" "${d_rm}
cmd=${cmd}" "${d_tty}
cmd=${cmd}" "${d_interactive}
#cmd=${cmd}" "${d_linux_capabilities}
cmd=${cmd}" "${d_host}
cmd=${cmd}" "${d_name}
#cmd=${cmd}" "${d_time}
cmd=${cmd}" "${d_mount_1}
cmd=${cmd}" "${d_mount_2}
cmd=${cmd}" "${d_mount_3}
cmd=${cmd}" "${d_mount_4}
cmd=${cmd}" "${d_mount_5}
cmd=${cmd}" "${d_mount_6}
cmd=${cmd}" "${d_x11_1}
cmd=${cmd}" "${d_x11_2}
cmd=${cmd}" "${d_x11_3}
cmd=${cmd}" "${d_x11_4}
cmd=${cmd}" "${d_workdir}
cmd=${cmd}" "${d_image}
cmd=${cmd}" "${d_userid}
cmd=${cmd}" "${d_groupid}
cmd=${cmd}" "${d_cmdline}

# Remove any pre-existing version
# docker rm ${container_name}
# Let the user know what we are doing, and then execute the command
echo $cmd
$cmd
