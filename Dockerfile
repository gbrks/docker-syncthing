FROM alpine:latest
MAINTAINER Gavin Brooks <gavin@brks.io>

ENV VERSION 0.11.13

# Add user to run syncthing as, must exist on host and have access to files
RUN adduser -D -u 1000 syncthing users

# Add dependencies, add build environment, download from Github and build, then clean up
RUN apk add --update ca-certificates \
    --virtual build_go \
	    git godep go mercurial bash && \
    rm -rf /var/cache/apk/* && \
	mkdir -p /go/src/github.com/syncthing && \
    cd /go/src/github.com/syncthing && \
	git clone https://github.com/syncthing/syncthing.git && \
	cd syncthing && \
	git checkout v$VERSION && \
	go run build.go %% \
	mv bin/syncthing /home/syncthing/syncthing && \
	chown syncthing:syncthing /home/syncthing/syncthing && \
	rm -rf /go && \
	apk del build_go
		

EXPOSE 8384 22000 21025/udp

VOLUME /config

USER syncthing

CMD ["-no-browser", "-no-restart", "-gui-address=0.0.0.0:8384", "-home=/config"]  

ENTRYPOINT ["/home/syncthing/syncthing"]  


  
