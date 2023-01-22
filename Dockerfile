FROM debian:latest
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
	tmux vim man-db less python3-qrcode \
	tigervnc-standalone-server \
	novnc tor xinit dbus-x11 \
	xfce4 firefox-esr

RUN useradd -m user
WORKDIR /home/user

COPY torrc .torrc
COPY xserverrc .xserverrc
COPY xinitrc.sh .xinitrc
COPY startx.sh .startx
RUN chown user:user -R . && chmod 750 .startx .xinitrc

USER user
CMD /home/user/.startx
