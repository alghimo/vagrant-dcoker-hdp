# Creates an Ambari Server base on vanilla centos
FROM  node-sandbox:0.1
MAINTAINER "Albert Gimenez"

RUN yum install -y krb5-server krb5-libs krb5-workstation
ADD krb5.conf /etc/
ADD create_krb_db.sh /tmp/
RUN /tmp/create_krb_db.sh