#!/bin/bash

set -e

[[ -n "$1" ]] && config_file=$1 || config_file=mesos-site.xml

set_config () {
    config_node="  <property>\n    <name>$1</name>\n    <value>$2</value>\n  </property>"
    sed -i "s,.*</configuration>.*,$config_node\n&," $3
}

if [ -n "$DEFAULT_PRINCIPAL" ]; then
    set_config "mesos.hdfs.principal" $DEFAULT_PRINCIPAL $config_file
fi

if [ -n "$DEFAULT_SECRET" ]; then
    set_config "mesos.hdfs.secret" $DEFAULT_SECRET $config_file
fi
