REM provision builder VM
docker-machine create -d virtualbox builder
docker-machine start builder
FOR /f "tokens=*" %%i IN ('docker-machine env builder') DO %%i


REM upload & pull necessary files
SET PATH=%PATH%;C;\Program Files\Git\usr\bin
docker pull elasticsearch:2.4.2
docker-machine ssh builder "rm -rf /home/docker/es-multicast/{*,.*}"
docker-machine scp -r . builder:/home/docker/es-multicast

REM build image
docker-machine ssh builder "cd /home/docker/es-multicast && docker build -t es-multicast . && docker save es-multicast | gzip -1 > ../es-multicast.tar.gz"

REM download image from VM
docker-machine scp builder:/home/docker/es-multicast.tar.gz ../
