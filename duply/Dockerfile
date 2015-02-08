FROM debian:sid

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /cache

# create the new HOME dir in case it isn't passed in (used to hold backup cache info)
RUN mkdir /cache && cd

# Install packages required
RUN apt-get update && \
	apt-get install -y duply python-requests-oauthlib python-boto

# clean up
RUN apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# set the starting point
ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
