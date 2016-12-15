FOR /f "tokens=*" %%i IN ('docker-machine env consul') DO @%%i
docker run -d --name consul -p8500:8500 -h consul progrium/consul -server -bootstrap
