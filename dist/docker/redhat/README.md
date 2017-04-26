# Scylla DB Container


### Container arguments

The entry point to the container has been altered and is no longer directly docker-entrypoint.py. 

Instead, it is docker-entrypoint.sh which fixes up nss configurations, before passing it on to docker-entrypoint.py. 

What this means basically, is when you pass the arguments, please make sure that scylla is the first argument you pass.

For example : 

 `docker run --name some-scylla -d scylladb/scylla scylla --broadcast-address x.x.x.x`

### Debugging container on openshift 

If you run this container on openshift, and need to exec into it for whatever reason, then run the following
commands before attempting debugging

`
export USER_ID=$(id -u);
export GROUP_ID=$(id -g);
export HOME=/home/scylla;
envsubst < /opt/passwd.template > /tmp/passwd;
export LD_PRELOAD=libnss_wrapper.so;
export NSS_WRAPPER_PASSWD=/tmp/passwd;
export NSS_WRAPPER_GROUP=/etc/group;`
