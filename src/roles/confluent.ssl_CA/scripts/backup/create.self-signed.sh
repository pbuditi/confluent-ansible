#!/bin/bash

set -o nounset \
    -o errexit \
    -o verbose
#    -o xtrace

source /opt/confluent/jdk.sh

# Cleanup files
rm -f *.p12 *.crt *.csr *_creds *.jks *.srl *.key *.pem *.der *.p12 create.log ../trust.log ../*.jks

# Generate CA key
openssl req -new -x509 -keyout rootCA.key -out rootCA.crt -days 4000 -subj "/CN=$(hostname)/OU=SVCSUAT/O=MYDOMAIN/L=Singapore/S=SG/C=SG" -passin pass:confluent -passout pass:confluent

# for i in broker client
# do
	echo "------------------------------- $(hostname) -------------------------------"

	# Create host keystore
	keytool -genkey -noprompt \
				 -alias $(hostname -s) \
				 -dname "CN=$(hostname),OU=SVCSUAT,O=MYDOMAIN,L=Singapore,S=SG,C=SG" \
                                 -ext san=dns:$(hostname -s) \
				 -keystore $(hostname -s).keystore.jks \
				 -keyalg RSA \
				 -storepass confluent \
				 -keypass confluent

	# Create the certificate signing request (CSR)
	keytool -keystore $(hostname -s).keystore.jks -alias $(hostname -s) -certreq -file $(hostname -s).csr -storepass confluent -keypass confluent

        # Sign the host certificate with the certificate authority (CA)
	openssl x509 -req -CA rootCA.crt -CAkey rootCA.key -in $(hostname -s).csr -out $(hostname -s)-signed.crt -days 9999 -CAcreateserial -passin pass:confluent

        # Sign and import the CA cert into the keystore
	keytool -noprompt -keystore $(hostname -s).keystore.jks -alias CARoot -import -file rootCA.crt -storepass confluent -keypass confluent

        # Sign and import the host certificate into the keystore
	keytool -noprompt -keystore $(hostname -s).keystore.jks -alias $(hostname -s) -import -file $(hostname -s)-signed.crt -storepass confluent -keypass confluent

	# # Create truststore and import the CA cert
	# keytool -noprompt -keystore $i.truststore.jks -alias CARoot -import -file rootCA.crt -storepass confluent -keypass confluent

	# Save creds
  	# echo "confluent" > ${i}_sslkey_creds
  	# echo "confluent" > ${i}_keystore_creds
  	# echo "confluent" > ${i}_truststore_creds

	# # Create pem files and keys used for Schema Registry HTTPS testing
	# #   openssl x509 -noout -modulus -in client.certificate.pem | openssl md5
	# #   openssl rsa -noout -modulus -in client.key | openssl md5 
        # #   echo "GET /" | openssl s_client -connect localhost:8082/subjects -cert client.certificate.pem -key client.key -tls1 
	# keytool -export -alias $i -file $i.der -keystore $i.keystore.jks -storepass confluent
	# openssl x509 -inform der -in $i.der -out $i.certificate.pem
	# keytool -importkeystore -srckeystore $i.keystore.jks -destkeystore $i.keystore.p12 -deststoretype PKCS12 -deststorepass confluent -srcstorepass confluent -noprompt
	# openssl pkcs12 -in $i.keystore.p12 -nodes -nocerts -out $i.key -passin pass:confluent

# done

