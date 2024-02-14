#!/bin/bash
docker rm -f mscratch
./build-docker
docker run -it --net=host  --name mscratch m2s
