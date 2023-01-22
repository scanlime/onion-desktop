FROM debian:unstable
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y

# Packages needed by the included scripts
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	bash tmux python3-qrcode \
	tigervnc-standalone-server \
	tor novnc xinit

# Desktop environment
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	xfce4 dbus-x11 x11-utils

# Browser
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	firefox

# Other user apps
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	openssh-client vim man-db less \
	neofetch nmap cmatrix vlc

RUN useradd -m user && chsh -s /bin/bash user
WORKDIR /home/user

COPY src/index.html /usr/share/novnc/index.html
COPY src/torrc /etc/tor/torrc

COPY src/xserverrc.sh .xserverrc
COPY src/xinitrc.sh .xinitrc
COPY src/startx.sh .startx
COPY src/banner.sh .banner
RUN chown user:user -R . && chmod 750 .startx .banner

USER user
CMD tmux -u \
	new-session 'exec /home/user/.startx' \;\
	split-window -h 'exec /home/user/.banner' \;\
	select-pane -t 0

