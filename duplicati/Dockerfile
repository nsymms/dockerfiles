FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

# Install packages required
RUN apt-get update && \
    apt-get install -y mono-runtime  libmono-system2.0-cil libmono-system-core4.0-cil \
	libmono-system-windows-forms4.0-cil libmono-system-data-linq4.0-cil \
	libmono-system-data4.0-cil expect wget unzip \
	libmono-sqlite4.0-cil

# Download and install duplicati
RUN cd /tmp && \
    wget http://updates.duplicati.com/preview/latest.zip && \
    mkdir /opt/duplicati && \
    cd /opt/duplicati && \
    unzip /tmp/latest.zip

# clean up
RUN apt-get purge -y wget unzip && \
    apt-get autoremove -y && \
    cd && \
    rm -rf /var/lib/apt/lists/* /tmp/latest.zip

# Set the ENTRYPOINT
ENTRYPOINT [ "/opt/duplicati/Duplicati.CommandLine.exe" ]


