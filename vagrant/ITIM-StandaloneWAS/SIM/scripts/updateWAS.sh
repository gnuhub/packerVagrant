/etc/init.d/wasServer stop
#/etc/init.d/wasNode stop
#/etc/init.d/wasDM stop
/installFiles/UpdateInstaller/install -options /vagrant/WAS/updateInstaller.rsp -silent
/opt/IBM/WebSphere/UpdateInstaller/update.sh -options /vagrant/WAS/was-fp31.rsp -silent
grep -i version /opt/IBM/WebSphere/AppServer/properties/version/WAS.product | grep -v = | awk '-F>' '{print $2}' | awk '-F<' '{print $1}'
#cp /vagrant/SIM/jars/* /opt/IBM/WebSphere/AppServer/lib/ext/ # Bodge. ISIM installer should do this!
#cp /vagrant/SIM/Properties.properties /opt/IBM/WebSphere/AppServer/lib/ext/
#cp /vagrant/SIM/Properties.properties /opt/IBM/WebSphere/AppServer/properties/
#cp /vagrant/SIM/Properties.properties /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/properties/

#/etc/init.d/wasDM start
#/etc/init.d/wasNode start
/etc/init.d/wasServer start
