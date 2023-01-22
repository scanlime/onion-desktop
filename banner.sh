#!/bin/bash
while true; do
  # Loop allows regenerating the VNC password any time

  vncpass=`openssl rand -base64 6`
  mkdir -p ~/.vnc
  chmod 700 ~/.vnc
  echo $vncpass | vncpasswd -f > ~/.vnc/passwd

  f=~/.hs/hostname
  while [ ! -f $f ]; do
    sleep 1
  done

  echo "http://$(<$f)/#$vncpass" > ~/.vnc/url
  qr $(<~/.vnc/url)
  echo \> $(<~/.vnc/url)

  read
done

