FROM debian:sid

ENV DEBIAN_FRONTEND noninteractive

# Install packages required
RUN apt-get update && \
	apt-get install -y duplicity python-requests-oauthlib python-boto

# clean up
RUN apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Set the ENTRYPOINT.
# The allow-source-mismatch option is required since each time we run
# we're effectively on a different (virtual) host.
ENTRYPOINT [ "/usr/bin/duplicity", "--allow-source-mismatch" ]
