# MediaBrowser Server
FROM jacobalberty/mb-base:latest
MAINTAINER Jacob Alberty <jacob.alberty@foundigital.com>

# Install latest MediaBrowser release from development PPA 
RUN apt-get -q update && \
    apt-get install -qy --force-yes mediabrowser && \
    apt-get -q clean && \
    rm -rf /var/lib/apt/lists/*

# Expose config volume
VOLUME /config 

# Default MB3 HTTP/tcp server port
EXPOSE 8096/tcp
# Default MB3 SSL/tcp server port
EXPOSE 8920/tcp
# UDP server port
EXPOSE 7359/udp
# ssdp port for UPnP / DLNA discovery
EXPOSE 1900/udp

USER mediabrowser

WORKDIR /opt/mediabrowser

ENTRYPOINT ["mono", "MediaBrowser.Server.Mono.exe"]
CMD ["-programdata", "/config"]
