FROM alpine:latest
MAINTAINER Gavin Brooks <gavin@brks.io>

ENV D_USER docker 
ENV D_UID 1000

VOLUME /config
EXPOSE 8384/tcp 22000/tcp 21025/udp

RUN adduser -D -u 1000 docker users
RUN chown docker:users -R /config
USER docker

RUN apk add --update syncthing \
	ca-certificates \
  && rm -rf /var/cache/apk/*

  RUN syncthing -no-browser -gui-address=0.0.0.0:8384 -home=/config
