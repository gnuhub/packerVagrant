#! /bin/bash
rm -rf /opt/ibm/db2/
rm -rf /home/db2inst1/sqllib/
rm -rf /home/db2inst1/db2inst1/
rm /home/db2inst1/.local/share/applications/IBM*
# One more command to kill all processes that have db2 in them, except for one.
killall -u db2inst1 -s 9
