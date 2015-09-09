* Build the docker images
** Sandbox node image:
```
docker build -t node-sandbox:0.1 projects/node-sandbox/
```

** Cluster node image:
```
docker build -t cluster-node:0.1 projects/hdp-cluster-unsecure/cluster-node
```

** Ambari node images
```
docker build -t ambari:2.1 projects/hdp-cluster-unsecure/ambari
```

* Creating your cluster
** Create the docker network:
```
docker network create hdpcluster
```

** Start the ambari node (Ctrl+p, Ctrl+q after running the commands):
```
docker run -it --name ambari -h ambari.hdpcluster -p 8080:8080 --publish-service ambari.hdpcluster ambari:2.1
service sshd start
service ntpd start
setenforce 0
ambari-server start
```

** Start the cluster nodes (Ctrl+p, Ctrl+q after running the commands)
```
docker run -it --name m1 -h m1.hdpcluster --publish-service m1.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0
```
```
docker run -it --name m2 -h m2.hdpcluster --publish-service m2.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0
```
```
docker run -it --name s1 -h s1.hdpcluster --publish-service s1.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0
```
```
docker run -it --name s2 -h s2.hdpcluster --publish-service s2.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0
```

** Open ambari http://localhost:8080 and create your cluster. Username and pass are "admin" / "admin"

** Once installed, save you can save your progress:
```
docker commit ambari ambari-hdpunsecure:2.3
docker commit m1 m1-hdpunsecure:2.3
docker commit m2 m2-hdpunsecure:2.3
docker commit s1 s1-hdpunsecure:2.3
docker commit s2 s2-hdpunsecure:2.3
```

** You can stop your containers by running:
```
docker kill m1 m2 s1 s2 ambari
docker rm m1 m2 s1 s2 ambari
```

** After this, remember that if you want to run your already setup cluster again, you need to run the images you just commited:
```
docker run -itP --name ambari -h ambari.hdpcluster -p 8080:8080 --publish-service ambari.hdpcluster ambari-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-server start
```
```
docker run -itP --name m1 -h m1.hdpcluster --publish-service m1.hdpcluster m1-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start
```
```
docker run -itP --name m2 -h m2.hdpcluster --publish-service m2.hdpcluster m2-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start
```
```
docker run -itP --name s1 -h s1.hdpcluster --publish-service s1.hdpcluster s1-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start
```
```
docker run -itP --name s2 -h s2.hdpcluster --publish-service s2.hdpcluster s2-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start
```