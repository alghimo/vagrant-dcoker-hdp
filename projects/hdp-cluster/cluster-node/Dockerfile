# Creates an Ambari Server base on vanilla centos
FROM node-sandbox:0.1

COPY supervisor /scripts/supervisor
COPY supervisord.conf /etc/supervisord.conf

EXPOSE 10000 10020 10030 10200 12999 13562 16000 16010 16020 16030 19888 22 2181 2888 3306 3888 443 45454 5151 6080 6083 6182 6183 8025 8030 8050 80 8080 8085 8088 8141 8188 8190 88 9090 9095 9292 9293 9933 9999

CMD /usr/bin/supervisord -c /etc/supervisord.conf