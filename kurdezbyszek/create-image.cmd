REM provision builder VM
docker-machine create -d virtualbox builder
docker-machine start builder
FOR /f "tokens=*" %%i IN ('docker-machine env builder') DO %%i


REM upload & pull necessary files
SET PATH=%PATH%;C;\Program Files\Git\usr\bin
docker pull python:3.5-alpine
docker-machine ssh builder "rm -rf /home/docker/kurdezbyszek && mkdir /home/docker/kurdezbyszek"
tar c Dockerfile src .dockerignore requirements.txt test_config.json | gzip -1 > tmp.tgz
docker-machine scp tmp.tgz builder:/home/docker/kurdezbyszek
rm tmp.tgz
docker-machine ssh builder "cd /home/docker/kurdezbyszek && tar zxf tmp.tgz && rm tmp.tgz"

REM build image
docker-machine ssh builder "cd /home/docker/kurdezbyszek && docker build -t kurdezbyszek . && docker save kurdezbyszek | gzip -1 > ../kurdezbyszek.tar.gz"

REM download image from VM
docker-machine scp builder:/home/docker/kurdezbyszek.tar.gz ../
