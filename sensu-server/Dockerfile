FROM debian:sid
MAINTAINER Neal Symms <neal.symms@gmail.com>

# default config parameters
ENV RABBITMQ_HOST=rabbitmq
ENV RABBITMQ_USER=sensu
ENV RABBITMQ_PASS=sensu
ENV RABBITMQ_VHOST=/sensu
ENV RABBITMQ_PORT=5671
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379

# install sensu
ADD http://repos.sensuapp.org/apt/pubkey.gpg /tmp/sensu-pubkey.gpg
RUN \
  apt-key add /tmp/sensu-pubkey.gpg \
  && echo 'deb http://repos.sensuapp.org/apt sensu main' > /etc/apt/sources.list.d/sensu.list \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y sensu \
  && chown -R sensu:sensu /etc/sensu


# The run.sh script builds the config file specifying redis and rabbitmq
# and then runs sensu

ADD run.sh /bin/run.sh
ENTRYPOINT ["/bin/run.sh"]
