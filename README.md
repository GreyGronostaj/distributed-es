# distrubuted-es



## Cluster management

### Initial setup

1. `provision-consul`
2. `run-consul`
3. `provision-machines`


### Starting existing cluster

> **Warning:** Machines may be assigned different IP addresses than previously. It will result in *"no healthy nodes in cluster"* message. In this case, shit will fall from the sky. Cover your head and recreate cluster from scratch: `teardown` && start again.

1. `run-consul`
2. `docker-machine start host0 host1 host2`
3. (run whatever you wish)


### Destroying cluster

1. `teardown`



## Elasticsearch

1. `es-multicast/create-image`
2. `es-multicast/pull`
3. `run-es`
4. `crapgen/run-image`


## kurdezbyszek

1. `kurdezbyszek/create-image`
2. `kurdezbyszek/pull`
3. `run-kz-es`



## Web interface

1. `frontend/create-image`
2. `frontend/pull`
3. `run-frontend` 
