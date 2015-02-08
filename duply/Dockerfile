FROM debian:sid

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /cache

# create the new HOME dir in case it isn't passed in (used to hold backup cache info)
RUN mkdir /cache && cd

# Install packages required
RUN apt-get update && \
	apt-get install -y duply python-requests-oauthlib

# clean up
RUN apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Set the ENTRYPOINT.
# The allow-source-mismatch option is required since each time we run
# we're effectively on a different (virtual) host.
ENTRYPOINT [ "/usr/local/bin/duplicity", "--archive-dir=/cache", "--allow-source-mismatch" ]
