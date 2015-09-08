# Creates an Ambari Server base on vanilla centos
FROM centos:6
MAINTAINER "Albert Gimenez"

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
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# install ssh
RUN yum -y install openssh-server openssh-clients

# autostart sshd on startup
RUN chkconfig sshd on

RUN chmod 700 /root/.ssh/id_rsa*
RUN chmod 600 ~/.ssh/authorized_keys

RUN yum -y install ntp sudo
RUN chkconfig ntpd on
RUN setenforce 0; exit 0;

EXPOSE 10000 10020 10030 10200 12999 13562 16000 16010 16020 16030 19888 22 2181 2888 3306 3888 443 45454 5151 6080 6083 6182 6183 8025 8030 8050 80 8080 8085 8088 8141 8188 8190 88 9090 9095 9292 9293 9933 9999
