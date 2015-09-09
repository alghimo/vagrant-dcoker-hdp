#!/bin/sh
mv /dev/random /dev/randomOr
mkdir /etc/kerberos
cp /dev/urandom /dev/random &
kdb5_util create -s -r HDCLUSTER.COM -d /etc/kerberos/kerberos_db -P krb4dm1n
pkill cp ; exit 0
rm -f /dev/random
mv /dev/randomOr /dev/random