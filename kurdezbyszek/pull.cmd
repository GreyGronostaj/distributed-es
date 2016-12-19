SET PATH=%PATH%;C;\Program Files\Git\usr\bin
FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO %%i
docker rmi kurdezbyszek
docker load -i ../kurdezbyszek.tar.gz
