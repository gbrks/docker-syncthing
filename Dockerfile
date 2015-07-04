FROM alpine:latest
MAINTAINER Gavin Brooks <gavin@brks.io>

ENV D_USER user 
ENV D_UID 1000

RUN apk add --update syncthing \
	ca-certificates \
  && rm -rf /var/cache/apk/*

VOLUME /config
EXPOSE 8384/tcp 22000/tcp 21025/udp

USER user
RUN syncthing -no-browser -gui-address=0.0.0.0:8384 -home=/config
