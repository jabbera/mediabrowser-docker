# MediaBrowser Server
FROM debian:jessie
MAINTAINER Carlos Hernandez <carlos@techbyte.ca>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Set locale to UTF-8
RUN apt-get update && apt-get install -qy --force-yes locales && apt-get clean
RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8
# Install needed default locale
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen
# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Add keys
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 637D1286; \
    echo 'deb http://ppa.launchpad.net/apps-z/mediabrowser/ubuntu trusty main' > /etc/apt/sources.list.d/20mediabrowser.list
    
# Install latest MediaBrowser release from development PPA 
RUN  apt-get update && apt-get install -qy --force-yes "mediabrowser=3.0.5518.*" && apt-get clean

# Expose config volume
VOLUME /config 

# Default MB3 HTTP/tcp server port
EXPOSE 8096/tcp
# UDP server port
EXPOSE 7359/udp
# ssdp port for UPnP / DLNA discovery
EXPOSE 1900/udp

USER mediabrowser

WORKDIR /opt/mediabrowser

ENTRYPOINT ["mono", "MediaBrowser.Server.Mono.exe"]
CMD ["-programdata", "/config"]
