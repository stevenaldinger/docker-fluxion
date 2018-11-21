FROM kalilinux/kali-linux-docker

RUN apt-get update && apt-get -y install \
              ca-certificates \
              curl \
              dbus-x11 \
              faenza-icon-theme \
              git \
              openbox \
              openssl \
              x11vnc \
              xfce4 \
              xfce4-terminal \
              xvfb \
 && git clone https://github.com/novnc/noVNC.git /usr/bin/noVNC \
 && git clone https://www.github.com/FluxionNetwork/fluxion.git /usr/bin/fluxion \
 && apt-get -y install \
              python3-numpy \
              sudo \
              supervisor \
 && addgroup --gid 1000 user \
 && useradd --uid 1000 --shell /bin/bash user -g 1000 \
 && echo "user:user" | /usr/sbin/chpasswd \
 && echo "user    ALL=(ALL) ALL" >> /etc/sudoers \
 # its defined in conf/conf.d/novnc.sv.conf to start by 'user' user
 && chown -R user:user /usr/bin/noVNC \
 && mkdir -p /etc/supervisor/conf.d \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# RUN apt-get update && apt-get -y install \
#               cairo-dock \
#               cairo-dock-plug-ins \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# service configuration
COPY /conf/supervisord.conf /etc/supervisord.conf
COPY /conf/conf.d/ /etc/supervisor/conf.d/

COPY conf/entrypoint.sh /usr/bin/container_entrypoint
COPY conf/entrypoint_functions.sh /usr/bin/container_entrypoint_functions

RUN chmod a+x /usr/bin/container_entrypoint /usr/bin/container_entrypoint_functions

WORKDIR /home/user

RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt-get update \
 && apt-get install -fy \
      aircrack-ng \
      "awk:awk|gawk|mawk" \
      bc \
      cowpatty \
      curl \
      isc-dhcp-server \
      hostapd \
      wireless-tools \
      psmisc \
      lighttpd \
      macchanger \
      mdk3 \
      nmap \
      openssl \
      php-cgi \
      pyrit \
      rfkill \
      net-tools \
      unzip \
      xterm \
      p7zip

# start the system
CMD container_entrypoint
