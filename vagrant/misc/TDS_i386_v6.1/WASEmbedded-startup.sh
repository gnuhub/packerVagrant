#!/bin/bash

# WASServer.sh
###################################################

echo Create /etc/init.d/WASServer.sh
cat > /etc/init.d/WASServer.sh <<DELIM
#!/bin/bash
. /etc/rc.d/init.d/functions
[ -f /etc/sysconfig/network ] && . /etc/sysconfig/network

[ "" = "no" ] && exit 0

start() {
        cd /opt/TDS_WAS/profiles/TDSWebAdminProfile/bin
        ./startServer.sh server1
}

stop() {
        cd /opt/TDS_WAS/profiles/TDSWebAdminProfile/bin
        ./stopServer.sh server1
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

chmod 755 /etc/init.d/WASServer.sh
# rc3.d/rc5.d
###################################################
echo Create rc3.d and rc5.d links
ln -s /etc/init.d/WASServer.sh /etc/rc.d/rc3.d/S99WASServer
ln -s /etc/init.d/WASServer.sh /etc/rc.d/rc5.d/S99WASServer