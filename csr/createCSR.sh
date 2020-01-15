#! /bin/bash

export IPADDR=$(hostname -i)

rm -f cert.pem cert.csr key.pem server-cert.pem server-cert.csr server-key.pem
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-cert.csr -config server-cert.cfg
openssl req -newkey rsa:4096 -nodes -keyout key.pem -out cert.csr -config cert.cfg