#!/bin/bash
set -e

tor -f ~/.torrc&
xinit&
websockify --web=/usr/share/novnc localhost:8000 localhost:5900 &

(
  vncpass=`openssl rand -base64 6`
  mkdir -p ~/.vnc
  chmod 700 ~/.vnc
  echo $vncpass | vncpasswd -f > ~/.vnc/passwd

  f=~/.hs/hostname
  while [ ! -f $f ]; do
    sleep 1
  done
  echo "http://$(<$f)/vnc.html?resize=scale&autoconnect=1&password=$vncpass" | tee ~/.vnc/url
) 

qr $(<~/.vnc/url)
wait
