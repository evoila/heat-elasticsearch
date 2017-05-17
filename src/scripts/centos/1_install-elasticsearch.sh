#!/bin/bash

# Expected parameters
VERSION=${VERSION:-5.4.0}

# Install elasticsearch
curl -o /tmp/elasticsearch.rpm https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$VERSION.rpm
rpm -i /tmp/elasticsearch.rpm

service elasticsearch status > /dev/null
SERVICE_STATUS=$?

if [ $SERVICE_STATUS -eq 0 ]; then
  service elasticsearch restart
fi
