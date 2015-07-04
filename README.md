## Under development - do not use

# Syncthing

Alpine (https://www.alpinelinux.org/) based Syncthing (http://syncthing.net) container

Run with:

```
docker run -d --name=syncthing \
	--net="host" \
	-p 8384:8384/tcp \
	-p 22000:22000/tcp \
	-p 21025:21025/udp \
	-v /opt/appdata/syncthing:/config
	-v /path/to/syncs:/sync \
	gbrks/syncthing
```
