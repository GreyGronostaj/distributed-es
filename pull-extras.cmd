FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO %%i

REM docker pull elasticsearch:2.4.2
docker pull byrnedo/alpine-curl
docker pull lherrera/bind-tools
