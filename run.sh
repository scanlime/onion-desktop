#!/bin/sh
set -ve
docker build . -t scanlime/onion-desktop
docker run -it --rm scanlime/onion-desktop
