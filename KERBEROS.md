Build images:
docker build -t kerberos:0.1 projects/hdp-cluster-kerberos/kerberos

Creating initial nodes:
docker run -it --name kerberos -h kerberos.hdpcluster --publish-service kerberos.hdpcluster kerberos:0.1

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
