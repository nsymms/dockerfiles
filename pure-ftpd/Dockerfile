#
#
#

FROM alpine:edge

RUN apk add --update pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
	&& rm -rf /var/cache/apk/* \
	&& addgroup ftpgroup \
	&& adduser -G ftpgroup -D ftpuser

# this is the ftp root dir. Somehow the 'ftp' user is already
# created and this is its home dir.
RUN mkdir /var/lib/ftp && chown ftp: /var/lib/ftp

EXPOSE 21 30000-30009
VOLUME /home/ftpuser

# anonymous only, 15 connections per IP, 5 simul users, anon can create dirs
CMD /usr/sbin/pure-ftpd -e -C 15 -c 5 -M -p 30000:30009
