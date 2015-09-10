* Build the kerberos image
```
docker build -t kerberos:0.1 projects/hdp-cluster-kerberos/kerberos
```

* Run the kerberos node and create the kerberos db and the admin principal:
```
docker run -it --name kerberos -h kerberos.hdpcluster --publish-service kerberos.hdpcluster kerberos:0.1
kdb5_util -r HDPCLUSTER create -s
/etc/rc.d/init.d/krb5kdc start
/etc/rc.d/init.d/kadmin start
kadmin.local -q "addprinc admin/admin@HDPCLUSTER" # You must enter some password here
/etc/rc.d/init.d/kadmin restart
```
- If you get stuck at "Loading random data" when creating the database with kdb5_util, run this instead:
```
mv /dev/random /dev/randomOr
cp /dev/urandom /dev/random &
kdb5_util -r HDPCLUSTER create -s
pkill cp
rm -f /dev/random
mv /dev/randomOr /dev/random
/etc/rc.d/init.d/krb5kdc start
/etc/rc.d/init.d/kadmin start
kadmin.local -q "addprinc admin/admin@HDPCLUSTER" # You must enter some password here
/etc/rc.d/init.d/kadmin restart
```

Once installed, save your progress:
```
docker commit kerberos kerberos-hdpsecure:2.3
```
You can now kill your kerberos container:
docker kill kerberos
docker rm kerberos

* Start the kerberos containers (and the rest of nodes from xxx-hdpunsecure if you haven't already):

```
docker run -itP --name kerberos -h kerberos.hdpcluster --publish-service kerberos.hdpcluster kerberos-hdpsecure:2.3
service sshd start
service ntpd start
setenforce 0
/etc/rc.d/init.d/krb5kdc start
/etc/rc.d/init.d/kadmin start
```

* Enabling Kerberos with Ambari:
- Important: If you want to enable kerberos using the Ambari wizard, you will need to add the ambari host to your cluster before enabling Kerberos.
- You can follow the [security guide from Hortonworks](http://docs.hortonworks.com/HDPDocuments/Ambari-2.1.1.0/bk_Ambari_Security_Guide/bk_Ambari_Security_Guide-20150828.pdf)
- Some data you might need
```
KDC Host: kerberos.hdpcluster
Realm name: HDPCLUSTER
Domains: .hdpcluster,hdpcluster
Kadmin host: kerberos.hdpcluster
Admin principal: admin/admin@HDPCLUSTER
Admin password: admin  (use the one you chose, if it was a different one)
```

- Once kerberos is enabled, you can save your progress:

```
docker commit kerberos kerberos-hdpsecure:2.3
docker commit ambari ambari-hdpsecure:2.3
docker commit m1 m1-hdpsecure:2.3
docker commit m2 m2-hdpsecure:2.3
docker commit s1 s1-hdpsecure:2.3
docker commit s2 s2-hdpsecure:2.3
```