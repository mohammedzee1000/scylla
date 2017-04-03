FROM registry.centos.org/centos/centos:7

MAINTAINER Avi Kivity <avi@cloudius-systems.com>

#enable systemd
ENV container docker
VOLUME [ "/sys/fs/cgroup" ]

RUN yum -y update && yum clean all

#install scylla
RUN curl http://downloads.scylladb.com/rpm/unstable/centos/master/latest/scylla.repo -o /etc/yum.repos.d/scylla.repo
# -- Setup the user
RUN useradd -u 1001 -g 0 -d /home/scylla scylla;
RUN yum -y install epel-release && yum -y clean expire-cache && yum -y remove boost-thread boost-system
RUN yum -y install scylla hostname supervisor nss_wrapper gettext && yum clean all

#install python3 for our main script
RUN yum -y install python34 python34-PyYAML && yum clean all

ADD scylla_bashrc /scylla_bashrc
RUN cat /scylla_bashrc >> /etc/bashrc

# Scylla configuration:
ADD etc/sysconfig/scylla-server /etc/sysconfig/scylla-server

# Supervisord configuration:
ADD etc/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /etc/supervisor.conf.d
ADD etc/supervisord.conf.d/scylla-server.conf /etc/supervisord.conf.d/scylla-server.conf
ADD etc/supervisord.conf.d/scylla-jmx.conf /etc/supervisord.conf.d/scylla-jmx.conf
RUN mkdir -p /var/log/scylla
ADD scylla-service.sh /scylla-service.sh
ADD scylla-jmx-service.sh /scylla-jmx-service.sh

ADD scyllasetup.py /scyllasetup.py
ADD commandlineparser.py /commandlineparser.py
ADD docker-entrypoint.py /docker-entrypoint.py
ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD passwd.template /opt/passwd.template

# Add Permission fixer and fix permissions
ADD ./fix-permissions.sh /opt/fix-permissions.sh
RUN touch /supervisord.log /home/scylla/.cqlshrc
RUN . /opt/fix-permissions.sh /var/lib/scylla scylla &&  . /opt/fix-permissions.sh /etc/scylla.d scylla && \
    . /opt/fix-permissions.sh /supervisord.log scylla && . /opt/fix-permissions.sh /opt scylla && \
    . /opt/fix-permissions.sh /var/log/scylla . && . /opt/fix-permissions.sh /home/scylla scylla

WORKDIR /home/scylla

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["scylla"]

EXPOSE 10000 9042 9160 9180 7000 7001
VOLUME [ "/var/lib/scylla" ]
USER scylla
