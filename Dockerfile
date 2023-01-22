FROM debian:latest
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
	tmux man-db less python3-qrcode \
	tigervnc-standalone-server \
	novnc tor xinit xfce4

COPY torrc /etc/tor/torrc
RUN useradd -m user
USER user
WORKDIR /home/user
COPY xserverrc .xserverrc
COPY xsession .xsession
COPY banner .banner
CMD tor -f /etc/tor/torrc& xinit& bash ~/.banner; wait
