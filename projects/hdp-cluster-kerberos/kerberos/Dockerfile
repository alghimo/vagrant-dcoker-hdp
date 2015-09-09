# Creates an Ambari Server base on vanilla centos
FROM  node-sandbox:0.1
MAINTAINER "Albert Gimenez"

RUN yum install -y krb5-server krb5-libs krb5-workstation
ADD krb5.conf /etc/
ADD kdc.conf /var/kerberos/krb5kdc/
ADD kadm.acl /var/kerberos/krb5kdc/