# Fluxion

Dockerized [Fluxion](https://github.com/FluxionNetwork/fluxion) including all dependencies and a web interface using noVNC.

# Usage

## Run the container

```sh
docker run --rm -it --privileged --net=host --cap-add=SYS_ADMIN -p 6080:6080 stevenaldinger/fluxion:latest
```

## Use the web interface to view Kali's GUI

1. Visit [127.0.0.1:6080/vnc.html](127.0.0.1:6080/vnc.html) in your browser.
2. When prompted for a password, type `secretp4ss`.

## Start up Fluxion

1. `Right click on your desktop` within the VNC window.
2. Select `Applications` > `System` > `Xfce Terminal`
3. Change to Fluxion directory: `cd /usr/bin/fluxion`
4. Run Fluxion: `sudo ./fluxion.sh`
