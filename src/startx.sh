#!/bin/bash

trap "
  pkill -f /home/user/.banner
  pkill tor websockify Xvnc
" EXIT

tor -f /etc/tor/torrc &
xinit &
websockify --web=/usr/share/novnc localhost:8000 localhost:5900 &

wait
