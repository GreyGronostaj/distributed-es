FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO @%%i
docker run -itd --name=frontend --network=iosrnet --network-alias=frontend -e "es_name=kz_es" -p 80:80 frontend
