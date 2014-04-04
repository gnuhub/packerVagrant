#!/bin/bash

# WASNode.sh
###################################################
echo Create /etc/init.d/WASNode.sh
cat > /etc/init.d/WASNode.sh <<DELIM
#!/bin/bash
. /etc/rc.d/init.d/functions
[ -f /etc/sysconfig/network ] && . /etc/sysconfig/network

[ "${NETWORKING}" = "no" ] && exit 0

start() {
	cd /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin
	./startNode.sh
}

stop() {
	cd /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin
	./stopNode.sh 
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

# WASServer.sh
###################################################
echo Create /etc/init.d/WASDM.sh
cat > /etc/init.d/WASDM.sh <<DELIM
#!/bin/bash
. /etc/rc.d/init.d/functions
[ -f /etc/sysconfig/network ] && . /etc/sysconfig/network

[ "" = "no" ] && exit 0

start() {
        cd /opt/IBM/WebSphere/AppServer/profiles/DMgr01/bin
        ./startManager.sh
}

stop() {
        cd /opt/IBM/WebSphere/AppServer/profiles/DMgr01/bin
        ./stopManager.sh
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

# WASServer.sh
###################################################
echo Create /etc/init.d/WASServer.sh
cat > /etc/init.d/WASServer.sh <<DELIM
#!/bin/bash
. /etc/rc.d/init.d/functions
[ -f /etc/sysconfig/network ] && . /etc/sysconfig/network

[ "" = "no" ] && exit 0

start() {
        cd /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin
        ./startServer.sh server1
}

stop() {
        cd /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin
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
chmod 755 /etc/init.d/WASDM.sh
chmod 755 /etc/init.d/WASNode.sh
chmod 755 /etc/init.d/WASServer.sh
# rc3.d/rc5.d
###################################################
echo Create rc3.d and rc5.d links
ln -s /etc/init.d/WASNode.sh /etc/rc.d/rc3.d/S99WASNode
ln -s /etc/init.d/WASNode.sh /etc/rc.d/rc5.d/S99WASNode
ln -s /etc/init.d/WASServer.sh /etc/rc.d/rc3.d/S99WASServer
ln -s /etc/init.d/WASServer.sh /etc/rc.d/rc5.d/S99WASServer
ln -s /etc/init.d/WASDM.sh /etc/rc.d/rc3.d/S99WASDM
ln -s /etc/init.d/WASDM.sh /etc/rc.d/rc5.d/S99WASDM