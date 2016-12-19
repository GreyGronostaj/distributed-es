FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO %%i

docker pull byrnedo/alpine-curl
docker pull lherrera/bind-tools
