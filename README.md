# Build the docker images
## Sandbox Node:
```shell
docker build -t node-sandbox:0.1 projects/hdp-cluster/node-sandbox/
```

## Cluster node:
```shell
docker build -t cluster-node:0.1 projects/hdp-cluster/cluster-node
```

## Ambari node
```shell
docker build -t ambari:2.1 projects/hdp-cluster/ambari
```

# Create your cluster
## Create the network:
```shell
docker network create hdpcluster
```

## Start the nodes
(Ctrl+p, Ctrl+q after running the commands)

```shell
# Ambari
docker run -d --name ambari -h ambari.hdpcluster -p 8080:8080 --publish-service ambari.hdpcluster ambari:2.1
# 2 masters, 2 slaves - Adapt it to your needs
docker run -d --name m1 -h m1.hdpcluster --publish-service m1.hdpcluster cluster-node:0.1
docker run -d --name m2 -h m2.hdpcluster --publish-service m2.hdpcluster cluster-node:0.1
docker run -d --name s1 -h s1.hdpcluster --publish-service s1.hdpcluster cluster-node:0.1
docker run -d --name s2 -h s2.hdpcluster --publish-service s2.hdpcluster cluster-node:0.1
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
* To run your already deployed cluster, you need to run the images you just commited. You don't need to start any services anymore, supervisor will do it for you:
```shell
docker run -d --name ambari -h ambari.hdpcluster -p 8080:8080 --publish-service ambari.hdpcluster ambari-hdpunsecure:2.3
docker run -d --name m1 -h m1.hdpcluster --publish-service m1.hdpcluster m1-hdpunsecure:2.3
docker run -d --name m2 -h m2.hdpcluster --publish-service m2.hdpcluster m2-hdpunsecure:2.3
docker run -d --name s1 -h s1.hdpcluster --publish-service s1.hdpcluster s1-hdpunsecure:2.3
docker run -d --name s2 -h s2.hdpcluster --publish-service s2.hdpcluster s2-hdpunsecure:2.3
```