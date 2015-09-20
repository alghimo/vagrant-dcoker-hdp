# Creates an Ambari Server base on vanilla centos
FROM node-sandbox:0.1
MAINTAINER "Albert Gimenez"

COPY ambari.repo /etc/yum.repos.d/

# Ambari repo
RUN wget -nv http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.1.1/ambari.repo -O /etc/yum.repos.d/ambari.repo
RUN yum install -y ambari-server
RUN chkconfig iptables off
RUN ambari-server setup -s; exit 0
COPY supervisor /scripts/supervisor
COPY supervisord.conf /etc/supervisord.conf

EXPOSE 22 443 80 8080

CMD /usr/bin/supervisord -c /etc/supervisord.conf