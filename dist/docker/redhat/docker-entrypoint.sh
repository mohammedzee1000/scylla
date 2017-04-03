#!/usr/bin/env bash

export USER_ID=$(id -u);
export GROUP_ID=$(id -g);
export HOME=/home/scylla;
envsubst < /opt/passwd.template > /tmp/passwd;
export LD_PRELOAD=libnss_wrapper.so;
export NSS_WRAPPER_PASSWD=/tmp/passwd;
export NSS_WRAPPER_GROUP=/etc/group;

if [ $1 == "scylla" ]; then
    shift;
    exec /docker-entrypoint.py $@;
else
    exec $@
fi