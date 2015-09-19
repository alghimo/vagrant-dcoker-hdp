# Creates an Ambari Server base on vanilla centos
FROM  node-sandbox:0.1
MAINTAINER "Albert Gimenez"

RUN yum install -y krb5-server krb5-libs krb5-workstation
COPY krb5.conf /etc/
COPY kdc.conf /var/kerberos/krb5kdc/
COPY kadm.acl /var/kerberos/krb5kdc/
COPY kadm.acl /var/kerberos/krb5kdc/kadm5.acl
EXPOSE 88

RUN mkdir /scripts
COPY create_krb_db.sh /scripts/
COPY create_krb_db.exp /scripts/
COPY create_admin_principal.exp /scripts/
RUN /scripts/create_krb_db.sh
RUN yum install -y python-setuptools
RUN easy_install supervisor
COPY supervisor /scripts/
COPY supervisord.conf /etc/supervisord.conf
CMD /usr/bin/supervisord -c /etc/supervisord.conf