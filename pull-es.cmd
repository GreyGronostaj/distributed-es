REM FOR /f "tokens=*" %%i IN ('docker-machine env host0') DO @%%i
REM docker pull elasticsearch:2.4.2
REM FOR /f "tokens=*" %%i IN ('docker-machine env host1') DO @%%i
REM docker pull elasticsearch:2.4.2
REM FOR /f "tokens=*" %%i IN ('docker-machine env host2') DO @%%i
REM docker pull elasticsearch:2.4.2

SET PATH=%PATH%;C;\Program Files\Git\usr\bin
docker load -i es-multicast.tar.gz
