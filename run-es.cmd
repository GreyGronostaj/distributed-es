docker-machine start host0 host1 host2

timeout 2

FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO @%%i
docker run -itd --name=es0 --network=iosrnet --network-alias=es --env="constraint:node==host0" es-multicast -Des.cluster.name=iosr -Des.discovery.zen.ping.multicast.enabled=true -Des.discovery.zen.ping.unicast.hosts="es" -Des.network.host=_eth0_
timeout 3
docker run -itd --name=es1 --network=iosrnet --network-alias=es --env="constraint:node==host1" es-multicast -Des.cluster.name=iosr -Des.discovery.zen.ping.multicast.enabled=true -Des.discovery.zen.ping.unicast.hosts="es" -Des.network.host=_eth0_
timeout 3
docker run -itd --name=es2 --network=iosrnet --network-alias=es --env="constraint:node==host2" es-multicast -Des.cluster.name=iosr -Des.discovery.zen.ping.multicast.enabled=true -Des.discovery.zen.ping.unicast.hosts="es" -Des.network.host=_eth0_
timeout 10

docker run --rm --network=iosrnet byrnedo/alpine-curl http://es:9200/_cluster/state?pretty
