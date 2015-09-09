#!/bin/sh
mv /dev/random /dev/randomOr
cp /dev/urandom /dev/random &
kdb5_util -r HDCLUSTER.COM create -s -P krb4dm1n
pkill cp
rm -f /dev/random
mv /dev/randomOr /dev/random