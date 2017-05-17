#!/bin/bash

# Expected parameters
VERSION=${VERSION:-5.3.2}

# Install elasticsearch
curl -o /tmp/elasticsearch.deb https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$VERSION.deb
dpkg -i /tmp/elasticsearch.deb

service elasticsearch status > /dev/null
SERVICE_STATUS=$?

if [ $SERVICE_STATUS -eq 0 ]; then
  service elasticsearch restart
fi
