FROM alpine:latest
MAINTAINER Gavin Brooks <gavin@brks.io>

ENV D_USER docker 
ENV D_UID 1000

RUN adduser -D -u 1000 docker users \
  && chown docker:users -R /config
USER docker

RUN apk add --update syncthing \
	ca-certificates \
  && rm -rf /var/cache/apk/*

EXPOSE 8384 22000 21025/udp

VOLUME /config /sync

CMD ["-no-browser", "-no-restart", "-gui-address=0.0.0.0:8384", "-home=/config"]  

ENTRYPOINT ["/usr/bin/syncthing"]  


  