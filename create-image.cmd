REM provision temporary VM
docker-machine create -d virtualbox builder
FOR /f "tokens=*" %%i IN ('docker-machine env builder') DO %%i


REM upload & pull necessary files
SET PATH=%PATH%;C;\Program Files\Git\usr\bin
docker pull elasticsearch:2.4.2
docker-machine scp -r es-multicast builder:/home/docker

REM build image
docker-machine ssh builder "cd /home/docker/es-multicast && docker build -t es-multicast ."
docker-machine ssh builder "docker save es-multicast | gzip > es-multicast.tar.gz"

REM download image from VM
docker-machine scp builder:/home/docker/es-multicast.tar.gz .


REM teardown temporary VM
docker-machine stop builder
timeout 1
docker-machine rm -f builder
