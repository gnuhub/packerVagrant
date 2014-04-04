#!/bin/bash

# db2.sh
###################################################
echo Create /etc/init.d/db2.sh
cat > /etc/init.d/db2.sh <<DELIM
#!/bin/bash
. /etc/rc.d/init.d/functions
[ -f /etc/sysconfig/network ] && . /etc/sysconfig/network

[ "${NETWORKING}" = "no" ] && exit 0

prog="DB2"
inst="idsldap"

start() {
        su - $inst -c "db2start"
}

stop() {
        su - $inst -c "db2stop force"
}

case "\$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart)
        stop
        sleep 3
        start
        ;;
  *)
        echo "Usage: \$0 {start|stop|restart}"
        exit 1
esac
DELIM

# tds.sh
###################################################
echo Create /etc/init.d/tds.sh
cat > /etc/init.d/tds.sh <<DELIM
	#!/bin/bash
. /etc/rc.d/init.d/functions
[ -f /etc/sysconfig/network ] && . /etc/sysconfig/network

[ "${NETWORKING}" = "no" ] && exit 0



# Set variables
prog="idsslapd"
inst="idsldap"

start() {
        echo -n "Starting $prog: "
        /opt/ibm/ldap/V6.1/sbin/idsdiradm -I idsldap
        sleep 3
        /opt/ibm/ldap/V6.1/sbin/idsslapd -I idsldap
}

stop() {
        echo -n "Stopping $prog: "
        /opt/ibm/ldap/V6.1/sbin/idsdiradm -I idsldap -k
        sleep 3
        /opt/ibm/ldap/V6.1/sbin/idsslapd -I idsldap -k
}

case "\$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart)
        stop
        start
        ;;
  *)
        echo "Usage: \$0 {start|stop|restart}"
        exit 1
esac
DELIM

# rc3.d/rc5.d
###################################################
echo Create rc3.d and rc5.d links
ln -s /etc/init.d/db2.sh /etc/rc.d/rc3.d/S99db2.sh
ln -s /etc/init.d/tds.sh /etc/rc.d/rc3.d/S99tds.sh
ln -s /etc/init.d/db2.sh /etc/rc.d/rc5.d/S99db2.sh
ln -s /etc/init.d/tds.sh /etc/rc.d/rc5.d/S99tds.sh
chmod 755 /etc/init.d/db2.sh
chmod 755 /etc/init.d/tds.sh