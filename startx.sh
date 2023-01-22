#!/bin/bash
tor -f /etc/tor/torrc &
xinit &
websockify --web=/usr/share/novnc localhost:8000 localhost:5900 &
wait
