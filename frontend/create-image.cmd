REM provision builder VM
docker-machine create -d virtualbox builder
docker-machine start builder
FOR /f "tokens=*" %%i IN ('docker-machine env builder') DO %%i


REM upload & pull necessary files
SET PATH=%PATH%;C;\Program Files\Git\usr\bin
docker pull php:7.0-apache
docker-machine ssh builder "rm -rf /home/docker/frontend/{*,.*}"
docker-machine scp -r . builder:/home/docker/frontend

REM build image
docker-machine ssh builder "cd /home/docker/frontend && docker build -t frontend . && docker save frontend | gzip -1 > ../frontend.tar.gz"

REM download image from VM
docker-machine scp builder:/home/docker/frontend.tar.gz ../
