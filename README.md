# Build the docker images
## Sandbox Node:
```shell
docker build -t node-sandbox:0.1 projects/node-sandbox/
```

## Cluster node:
```shell
docker build -t cluster-node:0.1 projects/hdp-cluster-unsecure/cluster-node
```

## Ambari node
```shell
docker build -t ambari:2.1 projects/hdp-cluster-unsecure/ambari
```

# Create your cluster
## Create the network:
```shell
docker network create hdpcluster
```

## Start the nodes
(Ctrl+p, Ctrl+q after running the commands)
* Ambari
```shell
docker run -it --name ambari -h ambari.hdpcluster -p 8080:8080 --publish-service ambari.hdpcluster ambari:2.1
service sshd start
service ntpd start
setenforce 0
ambari-server start
```
* This example uses two master and two slaves.
```shell
docker run -it --name m1 -h m1.hdpcluster --publish-service m1.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0
```
```shell
docker run -it --name m2 -h m2.hdpcluster --publish-service m2.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0
```
```shell
docker run -it --name s1 -h s1.hdpcluster --publish-service s1.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0
```
```shell
docker run -it --name s2 -h s2.hdpcluster --publish-service s2.hdpcluster cluster-node:0.1
service sshd start
service ntpd start
setenforce 0
```

## Deploy the cluster
* Open the [Ambari Web Interface](http://localhost:8080) in your browser and create your cluster.
* Username and password are "admin" / "admin"

## Save your progress
```shell
docker commit ambari ambari-hdpunsecure:2.3
docker commit m1 m1-hdpunsecure:2.3
docker commit m2 m2-hdpunsecure:2.3
docker commit s1 s1-hdpunsecure:2.3
docker commit s2 s2-hdpunsecure:2.3
```

## Stop your containers
```shell
docker kill $(docker ps -a -q)
docker rm $(docker ps -a -q)
```

## Starting your cluster
* To run your already deployed cluster, you need to run the images you just commited:
```shell
docker run -it --name ambari -h ambari.hdpcluster -p 8080:8080 --publish-service ambari.hdpcluster ambari-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-server start
```
```shell
docker run -it --name m1 -h m1.hdpcluster --publish-service m1.hdpcluster m1-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start
```
```shell
docker run -it --name m2 -h m2.hdpcluster --publish-service m2.hdpcluster m2-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start
```
```shell
docker run -it --name s1 -h s1.hdpcluster --publish-service s1.hdpcluster s1-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start
```
```shell
docker run -it --name s2 -h s2.hdpcluster --publish-service s2.hdpcluster s2-hdpunsecure:2.3
service sshd start
service ntpd start
setenforce 0
ambari-agent start
```