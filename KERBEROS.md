Build images:
docker build -t kerberos:0.1 projects/hdp-cluster-kerberos/kerberos

Creating initial nodes:
docker run -it --name kerberos -h kerberos.hdpcluster --publish-service kerberos.hdpcluster kerberos:0.1
# Uncomment the lines if you get stuck at "Loading Random Data"
#mv /dev/random /dev/randomOr
#cp /dev/urandom /dev/random &
kdb5_util -r HDPCLUSTER.COM create -s
#pkill cp
#rm -f /dev/random
#mv /dev/randomOr /dev/random
/etc/rc.d/init.d/krb5kdc start
/etc/rc.d/init.d/kadmin start
kadmin.local -q "addprinc admin/admin" # You must enter some password here
/etc/rc.d/init.d/kadmin restart


Once installed, save your progress:
docker commit kerberos kerberos-ready:0.1

You can kill your containers by:
docker kill kerberos
docker rm kerberos

Running your clusters:

docker run -itP --name kerberos -h kerberos.hdpcluster --publish-service kerberos.hdpcluster kerberos-ready:0.1
service sshd start
service ntpd start
setenforce 0
