SET PATH=%PATH%;C;\Program Files\Git\usr\bin
FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO %%i
docker rmi frontend
docker load -i ../frontend.tar.gz
