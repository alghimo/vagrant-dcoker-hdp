# Creates an Ambari Server base on vanilla centos
FROM centos:6
MAINTAINER "Albert Gimenez"

# increase timeouts to avoid "No more mirrors to try" if yum repos are busy for a few minutes
RUN echo "retries=0" >> /etc/yum.conf
RUN echo "timeout=60" >> /etc/yum.conf

RUN yum install -y scp curl unzip tar wget expect sshd ntp sudo

# 1.8 jdk
RUN yum -y install java-1.8.0-openjdk.x86_64 

# add ssh key
RUN mkdir -p /root/.ssh
ADD ssh/id_rsa /root/.ssh/
ADD ssh/id_rsa.pub /root/.ssh/
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh/id_rsa*
RUN chmod 600 ~/.ssh/authorized_keys

# install ssh
RUN yum -y install openssh-server openssh-clients
# autostart sshd on startup
RUN chkconfig sshd on
RUN chkconfig ntpd on
RUN setenforce 0;exit 0
