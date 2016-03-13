FROM debian:sid

# ---------------- #
#   Installation   #
# ---------------- #

# Install prerequisites
RUN     apt-get -y update && \
        apt-get -y install wget curl supervisor libfontconfig1


# Install InfluxDB
RUN     wget http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb && \
        dpkg -i influxdb_latest_amd64.deb && \
        rm influxdb_latest_amd64.deb


# Install StatsD (we're not using this for now)
#RUN     npm -g install statsd && \
#        npm -g install statsd-influxdb-backend && \
#        ln -s /usr/bin/nodejs /usr/bin/node


# Install Grafana
### MIGHT BE EASIER TO DOWNLOAD & EXTRACT .tar.gz FILE
RUN     wget https://grafanarel.s3.amazonaws.com/builds/grafana_2.5.0_amd64.deb && \
        dpkg -i grafana*.deb && \
        rm grafana*.deb



# ----------------- #
#   Configuration   #
# ----------------- #

# Configure InfluxDB
ADD     ./influxdb/setup.sh /tmp/setup.sh
RUN     /bin/sh /tmp/setup.sh && sleep 2 && rm /tmp/setup.sh

# Configure StatsD
#RUN     mkdir /statsd
#ADD     ./statsd/config.js /statsd/config.js

# Add influxDB as a grafana data source
### NEED A SCRIPT TO INJECT THIS AND DASHBOARDS INTO THE DATABASE
# RUN ???

# Add the default dashboards
### NEED A SCRIPT TO INJECT THESE INTO THE DATABASE
#RUN     mkdir -p /grafana/dashboards ?? where to put them ??
#ADD     ./grafana/dashboards/* /grafana/dashboards/

# Configure supervisord
ADD     ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# ---------------- #
#   Expose Ports   #
# ---------------- #

# Grafana
EXPOSE  3000

# InfluxDB management UI
EXPOSE 8083

# InfluxDB API
EXPOSE 8086

# InfluxDB "Carbon-like" API
EXPOSE 2003

# StatsD UDP port
#EXPOSE  8125/udp

# StatsD Management port
#EXPOSE  8126


# --------------------- #
#  Expose Data Volumes  #
# --------------------- #

# InfluxDB data
VOLUME /opt/influxdb/shared

# Grafana data
VOLUME /usr/share/grafana/data


# -------- #
#   Run!   #
# -------- #

CMD     ["/usr/bin/supervisord"]
