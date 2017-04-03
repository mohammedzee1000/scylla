# Scylla DB Container

Note: if you run this container on openshift, and need to exec into it for whatever reason, then run the following
commands before attempting debugging

`
export USER_ID=$(id -u);
export GROUP_ID=$(id -g);
export HOME=/home/scylla;
envsubst < /opt/passwd.template > /tmp/passwd;
export LD_PRELOAD=libnss_wrapper.so;
export NSS_WRAPPER_PASSWD=/tmp/passwd;
export NSS_WRAPPER_GROUP=/etc/group;`