#!/bin/bash

touch /opt/cloudezz-config/join_output.txt

echo ${SERF_TAG_IS_SERVICE} >> join_output.txt

if [ "${SERF_TAG_IS_SERVICE}" != "false" ]; then
    echo "Not an lb. Ignoring member join." >> join_output.txt
    exit 0
fi


echo "Member Joining to LB" >> join_output.txt

rm /tmp/listen.cfg
echo "Python Execution Begin" >> join_output.txt

exec python serf_haproxy.py > /dev/null 2>&1 &

wait %2

echo "Python Execution End" >> join_output.txt

cat /opt/cloudezz-config/haproxy.cfg.base /tmp/listen.cfg > /opt/cloudezz-config/haproxy.cfg

echo "Copied HAProxy files" >> join_output.txt

supervisorctl restart haproxy