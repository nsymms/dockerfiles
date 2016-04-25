FROM alpine:3.3

# Install packages required
RUN apk add --update duplicity openssh openssl py-crypto py-pip py-requests-oauthlib py-boto rsync \
	&& pip install pydrive==1.0.1 \
	&& apk del --purge py-pip \
	&& rm /var/cache/apk/* \
	&& adduser -D -u 1896 duplicity \
	&& mkdir -p /home/duplicity/.cache/duplicity \
	&& mkdir -p /home/duplicity/.gnupg \
	&& chmod -R go+rwx /home/duplicity/

# support for mega.co.nz
COPY mega.py-master /tmp/mega.py/
RUN cd /tmp/mega.py && \
	python setup.py install

ENV HOME=/home/duplicity

USER duplicity

# Set the ENTRYPOINT.
# The allow-source-mismatch option is required since each time we run
# we're effectively on a different (virtual) host.
ENTRYPOINT [ "/usr/bin/duplicity", "--allow-source-mismatch" ]
