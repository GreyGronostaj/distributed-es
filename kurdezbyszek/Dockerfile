# Based on https://github.com/docker-library/python/blob/master/3.5/onbuild/Dockerfile

FROM python:3.5-alpine

EXPOSE 80

RUN mkdir -p /usr/app/src /usr/app/config /usr/app/etc
WORKDIR /usr/app

COPY ./requirements.txt /usr/app/etc
RUN pip install --no-cache-dir -r /usr/app/etc/requirements.txt

COPY ./src /usr/app/src
COPY ./test_config.json /usr/app/config
CMD python /usr/app/src/main.py /usr/app/config/test_config.json
