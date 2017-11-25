#!/bin/sh

# Directories
UNIFI_PATH_APP=/opt/unifi-app
UNIFI_PATH_VAR=/opt/unifi-var

# Only relevant on first run
mkdir -p ${UNIFI_PATH_VAR}/data ${UNIFI_PATH_VAR}/log ${UNIFI_PATH_VAR}/run

JVM_OPTS_PATH="-Dunifi.datadir=${UNIFI_PATH_VAR}/data -Dunifi.logdir=${UNIFI_PATH_VAR}/log -Dunifi.rundir=${UNIFI_PATH_VAR}/run"
JVM_OPTS_MEM="-Xmx1024m -Xms256m"

JVM_OPTS="${JVM_OPTS_PATH} ${JVM_OPTS_MEM} -Djava.awt.headless=true -Dfile.encoding=UTF-8"

cd $UNIFI_PATH_APP
java -jar lib/ace.jar info

trap 'kill -TERM $PID; wait $PID' TERM
java ${JVM_OPTS} -jar lib/ace.jar start &
PID=$!
wait $PID

# On exit, shutdown mongod
echo "Shutting down mongo database"
mongo localhost:27117 --eval "db.getSiblingDB('admin').shutdownServer()" >/dev/null 2>&1