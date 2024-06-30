FROM debian:buster-slim

ARG server
ARG domain

ENV SME_GM_CONTROL=7

# x86-64
#RUN apt-get update \
#  && apt-get install -y wget \
#  && rm -rf /var/lib/apt/lists/* \
#  && wget -c "https://firmware.secomea.com/api/download?product=6111&installer=true" -O - | tar -xz && mkdir /etc/sitemanager \
#  && cd /SiteManager_Installer && ./install.sh -y -n -d / -c /dev/null && rm -rf /SiteManager_Installer

# arm64
RUN apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/* \
  && wget -c "https://firmware.secomea.com/api/download?product=6142&installer=true" -O -  | tar -xz && mkdir /etc/sitemanager \
  && cd /SiteManager_Installer && ./install.sh -y -n -d / -c /dev/null && rm -rf /SiteManager_Installer


RUN echo "Server=$server" >> /etc/sitemanager/sme.txt
RUN echo "Domain=$domain" >> /etc/sitemanager/sme.txt

EXPOSE 11444/tcp

ENTRYPOINT "/sitemanager"
