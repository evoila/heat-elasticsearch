#!/bin/bash

# Expected parameters
CLUSTER_NAME=${CLUSTER_NAME:-cluster}
NODE_NAMES=${NODE_NAMES}
MINIMUM_MASTER_NODES=${MINIMUM_MASTER_NODES:-2}
VOLUME_PATH=${VOLUME_PATH:-/mnt}

HOSTNAME=$(hostname -s)

# Create data and log paths
ELASTICSEARCH_PATH=${VOLUME_PATH}/elasticsearch
PATH_LIST="$ELASTICSEARCH_PATH/data $ELASTICSEARCH_PATH/logs"
mkdir -p $PATH_LIST
chown elasticsearch:elasticsearch $PATH_LIST

cat <<EOF > /etc/sysconfig/elasticsearch
MAX_OPEN_FILES=65536
MAX_LOCKED_MEMORY=unlimited
MAX_MAP_COUNT=262144
EOF

cat <<EOF > /etc/elasticsearch/elasticsearch.yml
cluster.name: $CLUSTER_NAME
node.name: $HOSTNAME
path.data: $ELASTICSEARCH_PATH/data
path.logs: $ELASTICSEARCH_PATH/logs
network.host: 0.0.0.0
http.port: 9200
discovery.zen.ping.unicast.hosts: $NODE_NAMES
discovery.zen.minimum_master_nodes: $MINIMUM_MASTER_NODES
gateway.recover_after_nodes: $MINIMUM_MASTER_NODES
transport.profiles.default.port: 9300-9400
EOF

service elasticsearch restart
