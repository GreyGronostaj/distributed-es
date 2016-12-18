# distrubuted-es



## Cluster management

### Initial setup

1. `provision-consul`
2. `run-consul`
3. `provision-machines`
4. (run whatever you wish)


### Starting existing cluster

> **Warning:** Machines may be assigned different IP addresses than previously. In this case, shit will fall from the sky. Recreate cluster from scratch.

1. `run-consul`
2. (run whatever you wish)


### Destroying cluster

1. `teardown`



## Elasticsearch

### Building custom Elasticsearch image

(regular Elasticsearch 2.4.2 image + multicast discovery plugin)

1. `create-image`


### Preparing machines

1. `pull-es`


### Starting ES

- Start 3 instances on 3 different machines and form a cluster: `run-es`
- Start one instance on any machine:

        docker run -itd --name=<INSTANCE_NAME> --network=iosrnet --network-alias=es es-multicast -Des.cluster.name=iosr -Des.discovery.zen.ping.multicast.enabled=true -Des.discovery.zen.ping.unicast.hosts="es" -Des.network.host=_eth0_
