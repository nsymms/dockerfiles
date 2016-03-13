FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

# Install packages required
RUN apt-get update && \
	apt-get install -y duplicity python-requests-oauthlib python-boto
COPY mega.py-master /tmp/mega.py/
RUN cd /tmp/mega.py && \
	python setup.py install

# clean up
RUN apt-get autoremove -y && \
	apt-get autoclean -y && \
	rm -rf /var/lib/apt/lists/* /tmp/mega.py

# Set the ENTRYPOINT.
# The allow-source-mismatch option is required since each time we run
# we're effectively on a different (virtual) host.
ENTRYPOINT [ "/usr/bin/duplicity", "--allow-source-mismatch" ]
