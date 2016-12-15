docker-machine stop consul host0 host1 host2
docker-machine rm -y consul host0 host1 host2
docker-machine create -d virtualbox consul
consul.cmd
