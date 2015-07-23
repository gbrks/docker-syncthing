Small, lightweight Alpine based Syncthing container.  
[![](https://badge.imagelayers.io/gbrks/syncthing:latest.svg)](https://imagelayers.io/?images=gbrks/syncthing:latest 'Get your own badge on imagelayers.io')

https://www.alpinelinux.org/  
http://syncthing.net

This image contains Syncthing built from source, as the official Alpine package tended to lag by a few releases.  
The build is at a defined version (as per the Dockerfile), however an ```edge``` branch/tag is available to allow automatic updating. See below for details.

## Usage

Mount any desired folders using ```-v <host_dir>:<docker_dir>``` when running the container.

If running behind a NAT router, ensure port 22000 is open and forwarded to the docker host.  
If this is not possible, the docker may be started with ```--net=host``` to the docker run line, which will allow uPnP to open the ports in the router. However, be aware of the implications of this [detailed here.](https://docs.docker.com/articles/networking/#how-docker-networks-a-container)

Run with:

```
docker run -d --name=syncthing \
  --restart=on-failure:20 \
  -v /opt/appdata/syncthing:/config \
  -v /<host sync folder>:/sync/<sync folder> \
  -p 8384:8384/tcp \
  -p 22000:22000/tcp \
  -p 21025:21025/udp \
  gbrks/syncthing
```

## Edge

Alpine utilises musl instead of glibc, this causes an issue with the automatic updating of Syncthing since the update simply pulls the latest compiled version from Github which references glibc libraries.  
The ```edge``` branch pulls in an unofficial glibc Alpine package, [located here](https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk).
The Syncthing binary is then simply pulled from a Github release, with automatic updating available.

On an upgrade, Syncthing will exit, and the container will stop. The ```--restart``` parameter below will restart the container on these events.

Image size will be slightly higher with the extra dependencies.  
[![](https://badge.imagelayers.io/gbrks/syncthing:edge.svg)](https://imagelayers.io/?images=gbrks/syncthing:edge 'Get your own badge on imagelayers.io')

Run with:

```
docker run -d --name=syncthing \
  --restart=on-failure:20 \
  -v /opt/appdata/syncthing:/config \
  -v /<host sync folder>:/sync/<sync folder> \
  -p 8384:8384/tcp \
  -p 22000:22000/tcp \
  -p 21025:21025/udp \
  gbrks/syncthing:edge
```


## Container User
The container will by default run as the user with uid 1000, if this is not suitable, it can be run as the root user by including ```-u="root"``` in the docker ```run``` command.  
Ensure /opt/appdata/syncthing/ (or other mapped folder) on the host is read/writable by the syncthing user

## Sync folder
On initial run, a default share will be established at /home/syncthing/Sync  
This should be removed, as it will be internal to the container. Any sync'ed folders should be located in /sync/

