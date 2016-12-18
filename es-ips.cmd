@echo off
FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO %%i
docker run --rm --network=iosrnet lherrera/bind-tools host -t A es
