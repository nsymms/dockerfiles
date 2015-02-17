#!/bin/bash

# if we have SSL certs provided, then use them
if [ ! -z "$SSL_CERT" ];
cat << EOF > /etc/sensu/config.json
{
  "rabbitmq": {
    "ssl": {
      "cert_chain_file": "$SSL_CERT",
      "private_key_file": "$SSL_KEY"
    },
EOF
else
cat << EOF > /etc/sensu/config.json
{
  "rabbitmq": {
EOF
fi

# the rest of the config file
cat <<EOF >> /etc/sensu/config.json
    "host": "$RABBITMQ_HOST",
    "port": $RABBITMQ_PORT,
    "vhost": "$RABBITMQ_VHOST",
    "user": "$RABBITMQ_USER",
    "password": "$RABBITMQ_PASS"
  },
  "redis": {
    "host": "$REDIS_HOST",
    "port": $REDIS_PORT
  }
}
EOF

exec /opt/sensu/bin/sensu-server -vc /etc/sensu/config.json -d /conf.d
