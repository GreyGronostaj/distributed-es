FROM elasticsearch:2.4.2

COPY discovery-multicast-2.4.2.zip /

RUN /usr/share/elasticsearch/bin/plugin install --batch file:///discovery-multicast-2.4.2.zip
