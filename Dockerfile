FROM debian:latest
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
	tmux man-db less python3-qrcode \
	tigervnc-standalone-server \
	novnc tor xinit xfce4

RUN useradd -m user
USER user
WORKDIR /home/user
COPY torrc .torrc
COPY xserverrc .xserverrc
COPY xsession .xsession
COPY startx .startx
CMD /bin/bash ~/.startx
