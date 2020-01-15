#! /bin/bash

sudo chmod -v 0400 csr/key.pem csr/server-key.pem
sudo chmod -v 0444 csr/ca.pem csr/server-cert.pem csr/cert.pem

sudo cp -f csr/ca.pem /etc/pki/ca-trust/source/anchors/
sudo cp -f csr/server-cert.pem /etc/pki/tls/certs
sudo cp -f csr/server-key.pem /etc/pki/tls/private
sudo update-ca-trust

sudo mkdir /home/sonny/.docker
sudo cp -v {csr/ca,csr/cert,csr/key}.pem /home/sonny/.docker

sudo mkdir /root/.docker
sudo cp -v {csr/ca,csr/cert,csr/key}.pem /root/.docker

sudo chown -R sonny: /home/sonny/.docker

sudo cat << EOF > daemon.json
{
	"debug": true,
	"hosts": ["fd://", "tcp://$HOSTNAME:2376"],
	"tls": true,
	"tlsverify": true,
	"tlscacert": "/etc/pki/tls/certs/ca-bundle.crt",
	"tlscert": "/etc/pki/tls/certs/server-cert.pem",
	"tlskey": "/etc/pki/tls/private/server-key.pem"
}
EOF

sudo mv daemon.json /etc/docker/

sudo sed -i "\$aexport DOCKER_HOST=tcp://$HOSTNAME:2376 DOCKER_TLS_VERIFY=1" /home/sonny/.bash_profile
sudo sed -i "\$aexport DOCKER_HOST=tcp://$HOSTNAME:2376 DOCKER_TLS_VERIFY=1" /root/.bash_profile
source /home/sonny/.bash_profile

sudo systemctl daemon-reload
sudo systemctl restart docker