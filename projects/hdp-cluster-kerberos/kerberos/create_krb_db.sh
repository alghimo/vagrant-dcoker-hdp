#!/bin/sh
mv /dev/random /dev/randomOr
cp /dev/urandom /dev/random &
/scripts/create_krb_db.exp
pkill cp
rm -f /dev/random
mv /dev/randomOr /dev/random
/etc/rc.d/init.d/krb5kdc start
/etc/rc.d/init.d/kadmin start
/scripts/create_admin_principal.exp
/etc/rc.d/init.d/kadmin restart
exit 0