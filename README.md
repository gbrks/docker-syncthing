Small, lightweight Alpine based Syncthing container.  
[![](https://badge.imagelayers.io/gbrks/syncthing:v0.11.26.svg)](https://imagelayers.io/?images=gbrks/syncthing:v0.11.26 'Get your own badge on imagelayers.io')

https://www.alpinelinux.org/  
http://syncthing.net

This image contains Syncthing built from source, as the official Alpine package tended to lag by a few releases.

This release is at *v0.11.26* which is the final *v0.11* release of Syncthing. Later versions are not backwards compatible with this release.
This tag is maintained for use only if you cannot update to the latest version of Syncthing.

## Usage

Mount any desired folders using `-v <host_dir>:<docker_dir>` when running the container.

If running behind a NAT router, ensure port 22000 is open and forwarded to the docker host.  
If this is not possible, the docker may be started with `--net=host` to the docker run line, which will allow uPnP to open the ports in the router. However, be aware of the implications of this [detailed here.](https://docs.docker.com/articles/networking/#how-docker-networks-a-container)

Run with:

```bash
docker run -d --name=syncthing \
  --restart=on-failure:20 \
  -v /opt/appdata/syncthing:/config \
  -v /<host sync folder>:/sync/<sync folder> \
  -p 8384:8384/tcp \
  -p 22000:22000/tcp \
  -p 21025:21025/udp \
  gbrks/syncthing:v0.11.26
```

## Container User Permissions
The container will by default run as the user with uid 1000.  
Ensure /opt/appdata/syncthing/ (or other mapped folder) on the host is read/writable by this user.

## Sync folder
On initial run, prior to a config file being created, a default share will be established at /home/syncthing/Sync  
This should be removed, as it will be internal to the container. Any sync'ed folders should be located in /sync/
