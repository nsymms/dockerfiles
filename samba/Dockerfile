FROM alpine:latest

RUN apk add --update samba samba-common-tools

ADD run.sh /run.sh
RUN chmod u+x /run.sh

EXPOSE 445

ENTRYPOINT ["/run.sh"]
CMD ["-h"]
