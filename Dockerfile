FROM debian:latest
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
	tmux vim man-db less python3-qrcode \
	tigervnc-standalone-server \
	novnc tor xinit dbus-x11 \
	xfce4 firefox-esr

RUN useradd -m user
WORKDIR /home/user

COPY index.html /usr/share/novnc/index.html
COPY torrc /etc/tor/torrc

COPY xserverrc .xserverrc
COPY xinitrc.sh .xinitrc
COPY startx.sh .startx
COPY banner.sh .banner
RUN chown user:user -R . && chmod 750 .startx .xinitrc .banner

USER user
CMD tmux -u new-session /home/user/.startx \; split-window -h /home/user/.banner \; select-pane -t 0
