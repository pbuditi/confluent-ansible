#!/bin/bash

set -o nounset \
    -o errexit \
    -o verbose
#    -o xtrace

source /opt/confluent/jdk.sh

cd /opt/confluent/var/ssl
# import CARoot to client truststore
keytool -noprompt -keystore kafka-client.truststore.jks -alias  DBSBank-Root-CA-$(hostname -s) -import -file private/DBSBank-Root-CA.crt -storepass {{truststore_password}} 
keytool -noprompt -keystore kafka-client.truststore.jks -alias  DBSBank-Ent-SubCA-$(hostname -s) -import -file private/DBSBank-Ent-SubCA.crt -storepass {{truststore_password}} 


cd /opt/confluent/var/ssl
# import CARoot to server truststore
keytool -noprompt -keystore kafka-server.truststore.jks -alias DBSBank-Root-CA-$(hostname -s) -import -file private/DBSBank-Root-CA.crt -storepass {{truststore_password}} 
keytool -noprompt -keystore kafka-server.truststore.jks -alias DBSBank-Ent-SubCA-$(hostname -s) -import -file private/DBSBank-Ent-SubCA.crt -storepass {{truststore_password}} 