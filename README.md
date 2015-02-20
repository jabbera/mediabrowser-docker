# Description
This image is the "MediaBrowser Server" [(*http://mediabrowser.tv*)](http://mediabrowser.tv)
I created it to use in place of the official mediabrowser/mbserver image using a lighter weight debian:jessie base and without the circusd process manager to use the built in docker user parameter.

# Volumes:

## `/config`

Configuration files and state of MediaBrowser Server folder. (i.e. /opt/appdata/mediabrowser)

# Environment Variables:

## `TZ`

TimeZone. (i.e America/Chicago)

# User:

By default this this runs as the mediabrowser user/group created by package installation.
This can be overridden by bind mounting an appropriate /etc/passwd and /etc/group file and using --user to set the user.

# Docker run command:

```
docker run -d --net=host -v /*your_config_location*:/config -v /*your_media_location*:/media -e TZ=<TIMEZONE> --name=mbserver jacobalberty/mediabrowser

```


