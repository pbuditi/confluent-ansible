#!/bin/bash

set -o nounset \
    -o errexit \
    -o verbose
#    -o xtrace

source /opt/confluent/jdk.sh

cd /opt/confluent/var/ssl
# import CARoot to client truststore
keytool -noprompt -keystore kafka-client.truststore.jks -alias CARoot-$(hostname -s) -import -file private/rootCA.crt -storepass changeit 

cd /opt/confluent/var/ssl
# import CARoot to server truststore
keytool -noprompt -keystore kafka-server.truststore.jks -alias CARoot-$(hostname -s) -import -file private/rootCA.crt -storepass changeit 