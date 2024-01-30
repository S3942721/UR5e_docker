#!/bin/bash 
docker rm -f ur5e_docker
./build-docker.sh
#docker run -it --name ur5e_docker ur5e_dev

docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net=host --name ur5e_docker ur5e_dev
