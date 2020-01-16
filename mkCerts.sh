#! /bin/bash

export IPADDR=$(hostname -i)

rm -f cert.pem cert.csr key.pem server-cert.pem server-cert.csr server-key.pem

openssl genrsa -aes256 -out csr/ca-key.pem 4096
openssl req -new -x509 -days 365 -key csr/ca-key.pem -sha256 -out csr/ca.pem

openssl req -newkey rsa:4096 -nodes -keyout csr/server-key.pem -out csr/server-cert.csr -config csr/server-cert.cfg
openssl req -newkey rsa:4096 -nodes -keyout csr/key.pem -out csr/cert.csr -config csr/cert.cfg

openssl x509 -req -days 365 -sha256 -in csr/server-cert.csr -CA csr/ca.pem -CAkey csr/ca-key.pem -CAcreateserial -out csr/server-cert.pem
openssl x509 -req -days 365 -sha256 -in csr/cert.csr -CA csr/ca.pem -CAkey csr/ca-key.pem -CAcreateserial -out csr/cert.pem