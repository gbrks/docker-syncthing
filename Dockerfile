FROM alpine:latest
MAINTAINER Gavin Brooks <gavin@brks.io>

ENV VERSION v0.11.26

# Add user to run syncthing as, must exist on host and have access to files
RUN adduser -D -u 1000 syncthing users

# Add dependencies
RUN apk add --update ca-certificates \

# Add build environment
    --virtual build_go \
	    git godep go mercurial bash && \
    rm -rf /var/cache/apk/* && \

# Download from Github and build
	mkdir -p /go/src/github.com/syncthing && \
    cd /go/src/github.com/syncthing && \
	git clone https://github.com/syncthing/syncthing.git && \
	cd syncthing && \
	git checkout $VERSION && \
	go run build.go -no-upgrade && \
	mv bin/syncthing /home/syncthing/syncthing && \
	chown syncthing:syncthing /home/syncthing/syncthing && \

# Clean up
	rm -rf /go && \
	apk del build_go

USER syncthing

EXPOSE 8384 22000 21025/udp

VOLUME /config

CMD ["-no-browser", "-no-restart", "-gui-address=0.0.0.0:8384", "-home=/config"]

ENTRYPOINT ["/home/syncthing/syncthing"]
