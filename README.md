## Under development - do not use

# Syncthing

Lightweight Alpine based Syncthing container, with an image size of 18Mb.

https://www.alpinelinux.org/
http://syncthing.net

The container will build syncthing from source. This was primarily due to the Alpine packages being built with the ```-no-upgrade``` flag, and thus will not automatically upgrade itself.

On an upgrade, syncthing will exit, and the container will stop. The ```--restart``` parameter below will restart the container on these events.


## Usage

Mount any desired folders using ```-v <host_dir>:<docker_dir>``` when running the container.

If running behind a NAT router, ensure port 22000 is open and forwarded to the docker host.
If this is not possible, the docker may be started with ```--net=host``` to the docker run line, which will allow uPnP to open the ports in the router. 

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

## Container User
The container will by default run as the user with uid 1000, if this is not suitable, it can be run as the root user by including ```-u="root"``` in the docker ```run``` command.
Ensure /opt/appdata/syncthing/ (or other mapped folder) on the host is read/writable by the syncthing user

## Sync folder
On initial run, a default share will be established at /home/syncthing/Sync
This should be removed, as it will be internal to the container. Any sync'ed folders should be located in /sync/
