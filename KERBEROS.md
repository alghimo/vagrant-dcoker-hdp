# Setup the Kerberos node
## Build the kerberos image
```shell
docker build -t kerberos:0.1 projects/hdp-cluster/kerberos
```

## Create Kerberos DB and principal
* Run the kerberos container and run the commands to create the db and the admin principal:
```shell
docker run -d --name kerberos -h kerberos.hdpcluster --publish-service kerberos.hdpcluster kerberos:0.1
```

# Kerberizing your cluster

## Start the kerberos containers (and the rest of nodes from xxx-hdpunsecure if you haven't already):
```shell
docker run -d --name kerberos -h kerberos.hdpcluster --publish-service kerberos.hdpcluster kerberos-hdpsecure:2.3
```

## Enable Kerberos with Ambari:
* **Important: To enable kerberos using the Ambari wizard, you will need to add the ambari host to your cluster before enabling Kerberos.**
* You can follow the [security guide from Hortonworks](http://docs.hortonworks.com/HDPDocuments/Ambari-2.1.1.0/bk_Ambari_Security_Guide/bk_Ambari_Security_Guide-20150828.pdf) for a step by step guide.
* Some data you might need
```shell
KDC Host: kerberos.hdpcluster
Realm name: HDPCLUSTER
Domains: .hdpcluster,hdpcluster
Kadmin host: kerberos.hdpcluster
Admin principal: admin/admin@HDPCLUSTER
Admin password: admin  (use the one you chose, if it was a different one)
```
## Save your progress
* Once kerberos is enabled, you can save your progress:
```shell
docker commit kerberos kerberos-hdpsecure:2.3
docker commit ambari ambari-hdpsecure:2.3
docker commit m1 m1-hdpsecure:2.3
docker commit m2 m2-hdpsecure:2.3
docker commit s1 s1-hdpsecure:2.3
docker commit s2 s2-hdpsecure:2.3
```