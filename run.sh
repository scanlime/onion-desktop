#!/bin/sh
set -ve
tag=onion-desktop
docker build . -t $tag
docker run -it --rm $tag
