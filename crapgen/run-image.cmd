REM Use host0 for this
FOR /f "tokens=*" %%i IN ('docker-machine env host0') DO %%i


REM upload & pull necessary files
SET PATH=%PATH%;C;\Program Files\Git\usr\bin
docker pull byrnedo/alpine-curl
docker-machine ssh host0 "rm -rf /home/docker/crap && mkdir /home/docker/crap"
docker-machine scp Dockerfile host0:/home/docker/crap
docker-machine scp res/request.txt host0:/home/docker/crap
docker-machine scp res/mapping.json host0:/home/docker/crap

REM build image
docker rmi insert_crap
docker-machine ssh host0 "cd /home/docker/crap && docker build -t insert_crap ."

REM run image
docker run --network=iosrnet -it --rm insert_crap
