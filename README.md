## Under development - do not use

# Syncthing

Alpine (https://www.alpinelinux.org/) based Syncthing (http://syncthing.net) container

Run with:

```
docker run -d --name=syncthing \
  --restart=on-failure:20 \
  -v /opt/appdata/syncthing:/config \
  -v /opt/appdata/syncmounts:/sync \
  -p 8384:8384/tcp \
  -p 22000:22000/tcp \
  -p 21025:21025/udp \
  gbrks/syncthing
```

On initial run, a default share will be established at /sync.
This should be removed, as it will point to your sync root directory.
Bind mount any individual paths into this directory, and set them up as shares.

For example:
mount --bind /path/to/sync1 /opt/appdata/syncmounts/sync1
mount --bind /path/to/sync2 /opt/appdata/syncmounts/sync2