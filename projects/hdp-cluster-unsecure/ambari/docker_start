Build images:
docker build -t cluster-node:0.1 /projects/hdp-cluster-unsecure/cluster-node
docker build -t ambari:2.1 /projects/hdp-cluster-unsecure/ambari

Create network so containers can see each other:
docker network create hdpcluster
Used to be able to connect from outside the VM. We'll bind our ambari container to this IP:
sudo ip addr add 10.12.0.117/21 dev eth1

Creating initial nodes:
docker run -it --name ambari -h ambari.hdpcluster -p 10.12.0.117:8090:8080 --publish-service ambari.hdpcluster ambari:2.1
service sshd start
service ntpd start
setenforce 0
ambari-server start

docker run -it --name m1 -h m1.hdpcluster --publish-service m1.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0

docker run -it --name s1 -h s1.hdpcluster --publish-service s1.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0

docker run -it --name s2 -h s2.hdpcluster --publish-service s2.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0

Open ambari and create your cluster

Once installed, save your progress:
docker commit ambari ambari-hdpunsecure:2.3
docker commit m1 m1-hdpunsecure:2.3
docker commit s1 s1-hdpunsecure:2.3
docker commit s2 s2-hdpunsecure:2.3

You can kill your containers by:
docker kill m1 s1 s2 ambari
docker rm m1 s1 s2 ambari

Running your clusters:

docker run -itP --name ambari -h ambari.hdpcluster -p 10.12.0.117:8090:8080 --publish-service ambari.hdpcluster ambari-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-server start

docker run -itP --name m1 -h m1.hdpcluster --publish-service m1.hdpcluster m1-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start

docker run -itP --name s1 -h s1.hdpcluster --publish-service s1.hdpcluster s1-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start

docker run -itP --name s2 -h s2.hdpcluster --publish-service s2.hdpcluster s2-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start
