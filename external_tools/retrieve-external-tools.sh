#!/bin/bash

#-----------------------------------------------------------------------------
validate_tool () {
    sha256sum -c external_sha256_sums/$1.sha | grep OK
    if [ $? != 0 ]; then
        echo "Failed to validate [$1]"
        exit 1
    fi
}

#-----------------------------------------------------------------------------
retrieve_tool () {
    if [ ! -f $1 ]; then
        wget $2/$1
        if [ $? != 0 ]; then
            echo "Failed to retrieve [$1]"
            exit 1
        fi
    fi
}

#-----------------------------------------------------------------------------
tool=gosu-amd64
retrieve_tool $tool https://github.com/tianon/gosu/releases/download/1.8
validate_tool $tool

#-----------------------------------------------------------------------------
#tool=package_name
#retrieve_tool $tool URL
#validate_tool $tool
