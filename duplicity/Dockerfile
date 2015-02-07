FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /cache

# create the new HOME dir in case it isn't passed in (used to hold backup cache info)
RUN mkdir /cache && cd

# Install packages required
RUN apt-get update && \
	apt-get install -y wget python python-dev python-pip librsync-dev ncftp lftp rsync \
        s3cmd python-setuptools gnupg ca-certificates && \
    pip install --upgrade lockfile paramiko pycrypto boto pyrax dropbox \
	urllib3 gdata python-swiftclient python-keystoneclient requests-oauthlib

# Download and install duplicity
RUN cd /tmp/ && \
    wget https://launchpad.net/duplicity/0.7-series/0.7.01/+download/duplicity-0.7.01.tar.gz && \
    cd /opt/ && \
    tar xf /tmp/duplicity-*.tar.gz && \
    rm /tmp/duplicity-*.tar.gz && \
    cd duplicity-* && \
    ./setup.py install

# clean up
RUN apt-get purge -y python-dev librsync-dev librsync1+ wget ca-certificates gcc g++ \
	python-pip dpkg-dev cpp make && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/duplicity* /opt/duplicity*

# Set the ENTRYPOINT.
# The allow-source-mismatch option is required since each time we run
# we're effectively on a different (virtual) host.
ENTRYPOINT [ "/usr/local/bin/duplicity", "--archive-dir=/cache", "--allow-source-mismatch" ]
