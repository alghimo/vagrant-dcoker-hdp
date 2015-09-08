# Creates an Ambari Server base on vanilla centos
FROM centos:6
MAINTAINER "Albert Gimenez"

ADD ambari.repo /etc/yum.repos.d/

# increase timeouts to avoid "No more mirrors to try" if yum repos are busy for a few minutes
RUN echo "retries=0" >> /etc/yum.conf
RUN echo "timeout=60" >> /etc/yum.conf

RUN yum install -y scp curl unzip tar wget expect sshd

# install Ambari specified 1.8 jdk
RUN yum -y install java-1.8.0-openjdk.x86_64 

# add ssh key
RUN mkdir -p /root/.ssh
ADD ssh/id_rsa /root/.ssh/
ADD ssh/id_rsa.pub /root/.ssh/

# install ssh
RUN yum -y install openssh-server openssh-clients
# autostart sshd on startup
RUN chkconfig sshd on

RUN chmod 700 /root/.ssh/id_rsa*
RUN yum -y install ntp sudo
RUN chkconfig ntpd on
#RUN setenforce 0

# Ambari repo
RUN wget -nv http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.1.1/ambari.repo -O /etc/yum.repos.d/ambari.repo
RUN yum install -y ambari-server
RUN chkconfig iptables off
RUN ambari-server setup -s; exit 0
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

EXPOSE 22 443 80 8080