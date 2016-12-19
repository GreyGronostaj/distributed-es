docker-machine start host0 host1 host2

timeout 2

FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO @%%i
docker run -itd --name=f0 --network=iosrnet --network-alias=frontend --env="constraint:node==host0" -e "es_name=kz_es" -p 8080:80 frontend
docker run -itd --name=f1 --network=iosrnet --network-alias=frontend --env="constraint:node==host1" -e "es_name=kz_es" -p 8080:80 frontend
docker run -itd --name=f2 --network=iosrnet --network-alias=frontend --env="constraint:node==host2" -e "es_name=kz_es" -p 8080:80 frontend
