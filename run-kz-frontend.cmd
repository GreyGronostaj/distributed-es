FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO %%i
docker stop kz_frontend
docker rm kz_frontend
docker run -itd --name=kz_frontend --network=iosrnet --network-alias=kz_frontend -e "verbose=1" -e "lookup_name=frontend" -e "cache_ttl=3" -e "service_port=8080" -p80:80 kurdezbyszek
