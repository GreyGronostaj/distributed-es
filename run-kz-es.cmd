FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO %%i
docker stop kz_es
docker rm kz_es
docker run -itd --name=kz_es --network=iosrnet --network-alias=kz_es -e "verbose=1" -e "lookup_name=es" -e "cache_ttl=3" -e "service_port=9200" kurdezbyszek
