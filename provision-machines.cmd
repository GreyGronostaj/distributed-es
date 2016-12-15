FOR /F "tokens=* USEBACKQ" %%F IN (`docker-machine ip consul`) DO (
	SET ip=%%F
)

docker-machine create -d virtualbox --swarm --swarm-master --swarm-discovery="consul://%ip%:8500" --engine-opt="cluster-store=consul://%ip%:8500" --engine-opt="cluster-advertise=eth1:2376" host0
docker-machine create -d virtualbox --swarm --swarm-discovery="consul://%ip%:8500" --engine-opt="cluster-store=consul://%ip%:8500" --engine-opt="cluster-advertise=eth1:2376" host1
docker-machine create -d virtualbox --swarm --swarm-discovery="consul://%ip%:8500" --engine-opt="cluster-store=consul://%ip%:8500" --engine-opt="cluster-advertise=eth1:2376" host2

FOR /f "tokens=*" %%i IN ('docker-machine env --swarm host0') DO @%%i
docker network create --driver overlay iosrnet
