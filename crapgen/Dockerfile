FROM byrnedo/alpine-curl

RUN mkdir -p /usr/crap
WORKDIR /usr/crap
COPY request.txt /usr/crap
COPY mapping.json /usr/crap
RUN tail /usr/crap/request.txt

ENTRYPOINT []
CMD ["sh", "-c", "curl -v -XDELETE es:9200/crap ; sleep 5 && echo && echo && echo && curl -v -XPUT es:9200/crap && curl -v -XPUT es:9200/crap/_mapping/crap --data-binary '@mapping.json' && echo && echo && echo && curl -XPOST -D - es:9200/_bulk --data-binary '@request.txt' -o /dev/null"]
