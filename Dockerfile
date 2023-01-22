FROM debian:latest
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
	tmux vim man-db less python3-qrcode \
	tigervnc-standalone-server \
	novnc tor xinit dbus-x11 \
	xfce4 firefox-esr

RUN useradd -m user && chsh -s /bin/bash user
WORKDIR /home/user

COPY index.html /usr/share/novnc/index.html
COPY torrc /etc/tor/torrc

COPY xserverrc.sh .xserverrc
COPY xinitrc.sh .xinitrc
COPY startx.sh .startx
COPY banner.sh .banner
RUN chown user:user -R . && chmod 750 .startx .banner

USER user
CMD tmux -u new-session 'exec /home/user/.startx' \; split-window -h 'exec /home/user/.banner' \; select-pane -t 0
