#!/bin/sh

# edit the config to enable the carbon (graphite) compatible listener
perl -0777 -i -pe 's/(\[input_plugins.graphite\]\s+enabled =)\s+false/$1 true\n  port = 2003\n  database = "stats"\n  udp_enabled = true/' /opt/influxdb/shared/config.toml

# Start influxdb and create a new database to hold our statistics
/etc/init.d/influxdb start

# database to hold statistics
until (curl -X POST 'http://localhost:8086/db?u=root&p=root' \
  -d '{"name": "stats"}' 2>/dev/null) do sleep 1; done # Loop until success
echo 'Created database: "stats"'

/etc/init.d/influxdb stop
